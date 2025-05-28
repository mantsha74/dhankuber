import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpScreen({super.key,required this.phoneNumber});


  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with CodeAutoFill {
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
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void codeUpdated() {
    setState(() {
      _otpCode = code ?? '';
    });
    if (_otpCode.length == 6) {
      // Handle OTP verification here
      context.go('/home');
    }
  }

  @override
  void dispose() {
    cancel();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var phoneText =  widget.phoneNumber; // replace dynamically if needed

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.help_outline, color: Colors.black),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "OTP please?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "We’ve sent it to $phoneText",
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            PinFieldAutoFill(
              currentCode: _otpCode,
              codeLength: 6,
              onCodeChanged: (code) {
                setState(() => _otpCode = code ?? '');
                if ((_otpCode).length == 6) {
                  // OTP filled manually
                  context.go('/home');
                }
              },
              decoration: BoxLooseDecoration(
                gapSpace: 12,
                strokeColorBuilder: FixedColorBuilder(Colors.grey),
                bgColorBuilder: FixedColorBuilder(Colors.grey.shade100),
                radius: const Radius.circular(10),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              _secondsRemaining > 0
                  ? "Resend in ${_secondsRemaining}s"
                  : "Didn’t receive code? Resend",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                fontWeight:
                _secondsRemaining > 0 ? FontWeight.normal : FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
