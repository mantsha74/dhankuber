import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const iconAssetPath = 'assets/images/your_icon.png'; // your custom icon
    const title = "WELCOME TO FINOVA";
    const headline = "Start investing in FDs\nwith returns that grow your wealth";
    const subText = "Insured up to ₹5L as per government norms";
    const termsNotice = "By proceeding, I agree to ";
    const tnc = "Terms";
    const privacy = "Privacy Policy";
    const buttonLabel = "Get Started";

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child:Icon(
                    Icons.account_balance,
                    size: 48, // Correct way to control the size
                    color: Colors.white,
                  ),

                  // child: Image.asset(
                  //   iconAssetPath,
                  //   height: 48,
                  //   width: 48,
                  //   color: Colors.white,
                  // ),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                headline,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  height: 1.4,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                subText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const Spacer(),
              const Text.rich(
                TextSpan(
                  text: termsNotice,
                  children: [
                    TextSpan(
                      text: tnc,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: " & "),
                    TextSpan(
                      text: privacy,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                style: TextStyle(fontSize: 12, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.go('/phone-auth'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(buttonLabel, style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
