import 'package:dhan_kuber/presentation/screens/profile/edit_profile/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../di/service_locator.dart';
import '../../domain/models/fd_plan.dart';
import '../screens/home/bank_detail/bank_detail_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/tools/tool_screen.dart';
import '../screens/onboarding/otp_screen.dart';
import '../screens/onboarding/phone_auth_screen.dart';
import '../screens/onboarding/welcome_screen.dart';
import '../screens/profile/profile_screens.dart';
import 'bottom_nav.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKeyHome = GlobalKey<NavigatorState>();
final shellNavigatorKeyTools = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  initialLocation: '/home',
  navigatorKey: rootNavigatorKey,
  redirect: (context, state) {
    final user = getIt<FirebaseAuth>().currentUser;
    final isLoggedIn = user != null;
    final location = state.uri.toString();

    final isOnboarding = [
      '/welcome',
      '/phone-auth',
      '/otp',
    ].any((path) => location.startsWith(path));

    if (!isLoggedIn && !isOnboarding) return '/welcome';
    if (isLoggedIn && isOnboarding) return '/home';
    return null;
  },
  routes: [
    // Onboarding Routes
    GoRoute(path: '/welcome', builder: (_, __) => const WelcomeScreen()),
    GoRoute(path: '/phone-auth', builder: (_, __) => const PhoneAuthScreen()),
    GoRoute(
      path: '/otp',
      builder: (_, state) =>
          OtpScreen(phoneNumber: state.extra as String),
    ),

    // Bottom Navigation using StatefulShellRoute
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          MainScaffold(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          navigatorKey: shellNavigatorKeyHome,
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: shellNavigatorKeyTools,
          routes: [
            GoRoute(
              path: '/tools',
              builder: (context, state) => const ToolsScreen(),
            ),
          ],
        ),
      ],
    ),

    // Other screen outside navi
    GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
    GoRoute(path: '/edit-profile', builder: (_, __) => const EditProfileScreen()),
    GoRoute(path: '/calculator', builder: (_, __) => const ToolsScreen()),
    GoRoute(
      path: '/bank-detail',
      builder: (context, state) => BankDetailScreen(
        plan: state.extra as FDPlan,
      ),
    ),

  ],
);
