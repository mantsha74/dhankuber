import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'auth_viewmodel.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final String phoneNumber;
  const OtpScreen({super.key, required this.phoneNumber});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> with CodeAutoFill {
  String _otpCode = '';
  int _secondsRemaining = 30;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    listenForCode();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        _timer.cancel();
      }
    });
  }

  void _verifyOtp() async {
    if (_otpCode.length != 6) return;
    try {
      await ref.read(phoneAuthProvider.notifier).verifyOtp(_otpCode);
      if (!mounted) return;
      context.go('/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  void codeUpdated() {
    setState(() => _otpCode = code ?? '');
    if (_otpCode.length == 6) _verifyOtp();
  }

  @override
  void dispose() {
    cancel();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final phoneText = widget.phoneNumber;
    final isOtpFilled = _otpCode.length == 6;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        leading: BackButton(color: colorScheme.onBackground),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Icon(Icons.help_outline, color: colorScheme.onBackground),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("OTP Verification", style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
              "We’ve sent a 6-digit code to $phoneText",
              style: textTheme.bodyMedium?.copyWith(color: theme.hintColor),
            ),
            const SizedBox(height: 32),
            PinFieldAutoFill(
              currentCode: _otpCode,
              codeLength: 6,
              onCodeChanged: (code) {
                setState(() => _otpCode = code ?? '');
                if (_otpCode.length == 6) _verifyOtp();
              },
              decoration: BoxLooseDecoration(
                gapSpace: 12,
                strokeColorBuilder: FixedColorBuilder(colorScheme.outline),
                bgColorBuilder: FixedColorBuilder(colorScheme.surfaceVariant),
                radius: const Radius.circular(10),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              _secondsRemaining > 0
                  ? "Resend in ${_secondsRemaining}s"
                  : "Didn’t receive code? Resend",
              style: textTheme.bodyMedium?.copyWith(
                color: theme.hintColor,
                fontWeight:
                _secondsRemaining > 0 ? FontWeight.normal : FontWeight.bold,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isOtpFilled ? _verifyOtp : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Verify & Continue",
                  style: textTheme.labelLarge?.copyWith(color: colorScheme.onPrimary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
