import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'auth_viewmodel.dart';

class PhoneAuthScreen extends ConsumerStatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  ConsumerState<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends ConsumerState<PhoneAuthScreen> {
  final TextEditingController _controller = TextEditingController();

  void _onSubmit() {
    final phone = _controller.text.trim();
    if (phone.length == 10) {
      ref.read(phoneAuthProvider.notifier).sendOtp(phone);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid 10-digit number")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(phoneAuthProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    //  Listen to verification state
    ref.listen<AsyncValue<String>>(phoneAuthProvider, (prev, next) {
      if (next is AsyncData && next.value?.isNotEmpty == true) {
        final phone = _controller.text.trim();
        context.go('/otp', extra: "+91$phone");
      }

      if (next is AsyncError) {
        debugPrint(next.error.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error.toString())),
        );
      }
    });

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        leading: BackButton(color: colorScheme.onBackground),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              "What’s your mobile number?",
              style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              "Please enter your mobile number",
              style: textTheme.bodyMedium?.copyWith(color: theme.hintColor),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: colorScheme.outline.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text("+91", style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
                  ),
                  const VerticalDivider(width: 1),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: "Enter phone number",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Your mobile number is used to secure your investments",
              style: textTheme.bodySmall?.copyWith(color: theme.hintColor),
            ),
            const Spacer(),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Have a referral link?",
                  style: textTheme.bodyMedium?.copyWith(
                    decoration: TextDecoration.underline,
                    color: colorScheme.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: authState is AsyncLoading ? null : _onSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: authState is AsyncLoading
                    ? CircularProgressIndicator(color: colorScheme.onPrimary)
                    : const Text("Verify mobile number"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
