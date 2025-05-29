import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(),

              /// Icon Container
              Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.account_balance,
                    size: 48,
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              /// Title
              Text(
                "WELCOME TO DHAN KUBER",
                style: textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                  color: theme.hintColor,
                ),
              ),
              const SizedBox(height: 12),

              /// Headline
              Text(
                "Start investing in FDs\nwith returns that grow your wealth",
                textAlign: TextAlign.center,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  height: 1.4,
                  color: colorScheme.onBackground,
                ),
              ),
              const SizedBox(height: 12),

              /// Subtext
              Text(
                "Insured up to ₹5L as per government norms",
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(color: theme.hintColor),
              ),

              const Spacer(),

              /// Terms Text
              Text.rich(
                TextSpan(
                  text: "By proceeding, I agree to ",
                  children: [
                    TextSpan(
                      text: "Terms",
                      style: textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                    const TextSpan(text: " & "),
                    TextSpan(
                      text: "Privacy Policy",
                      style: textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onBackground,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              /// Get Started Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.go('/phone-auth'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Get Started", style: TextStyle(fontSize: 16)),
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
