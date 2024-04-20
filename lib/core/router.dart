import 'package:coinseek/auth/screens/login.screen.dart';
import 'package:coinseek/auth/screens/register.screen.dart';
import 'package:coinseek/auth/screens/splash.screen.dart';
import 'package:coinseek/core/api/api.dart';
import 'package:coinseek/home/screens/home.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CSRoutes {
  static const String home = '/';
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
}

class CSRouter {
  static final rootNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter router = GoRouter(
    initialLocation: CSRoutes.splash,
    navigatorKey: rootNavigatorKey,
    redirect: (context, state) async {
      final exceptions = [
        CSRoutes.login,
        CSRoutes.register,
      ];
      final isSignedIn = CSApi.isSignedIn();

      if (state.fullPath == CSRoutes.splash) {
        final forceClose = state.extra == true;
        if (forceClose) {
          return CSRoutes.splash;
        }

        if (isSignedIn) {
          return CSRoutes.home;
        }
      }

      if (!isSignedIn) {
        if (exceptions.contains(state.fullPath)) {
          return state.fullPath;
        }
        return CSRoutes.splash;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: CSRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: CSRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: CSRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: CSRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}

final csRouterProvider = Provider<GoRouter>((ref) {
  return CSRouter.router;
});
