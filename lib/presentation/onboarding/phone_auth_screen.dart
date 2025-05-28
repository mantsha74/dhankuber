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
      context.go('/otp',extra: "+91$phone");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid number")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const title = "What’s your mobile number?";
    const subtitle = "Please enter your mobile number";
    const helper = "Your mobile number is used to secure your investments";
    const buttonText = "Verify mobile number";
    const referralText = "Have a referral link?";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text(
              title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              subtitle,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "+91",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const VerticalDivider(width: 1),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
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
            const Text(
              helper,
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const Spacer(),
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  referralText,
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){
                 _onSubmit();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
