

import 'package:go_router/go_router.dart';

import '../home/home_screen.dart';
import '../onboarding/otp_screen.dart';
import '../onboarding/phone_auth_screen.dart';
import '../onboarding/welcome_screen.dart';

final GoRouter appRouter = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/phone-auth',
        builder: (context, state) => const PhoneAuthScreen(),
      ),
      GoRoute(
        path: '/otp',
        builder: (context, state) {
          final phone = state.extra as String;
          return OtpScreen(phoneNumber: phone);
        }
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
    ]
);