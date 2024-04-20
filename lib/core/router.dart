import 'package:coinseek/auth/screens/register.screen.dart';
import 'package:coinseek/auth/screens/splash.screen.dart';
import 'package:coinseek/core/api/api.dart';
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
      final accessToken = (await CSApi.auth.getToken());

      if (state.fullPath == CSRoutes.splash) {
        final forceClose = state.extra == true;
        if (forceClose) {
          return CSRoutes.splash;
        }

        if (accessToken?.isNotEmpty ?? false) {
          return CSRoutes.home;
        }
      }

      if (accessToken?.isEmpty ?? true) {
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
        builder: (context, state) => Container(),
      ),
      GoRoute(
        path: CSRoutes.home,
        builder: (context, state) => Container(),
      ),
    ],
  );
}

final csRouterProvider = Provider<GoRouter>((ref) {
  return CSRouter.router;
});
