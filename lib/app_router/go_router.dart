import 'package:go_router/go_router.dart';
import 'package:flutter_login/screens/login_screen.dart';
import 'package:flutter_login/screens/sign_up_screen.dart';
import 'package:flutter_login/screens/forgot_password_screen.dart';
import 'package:flutter_login/app_router/app_route_constants.dart';
import 'package:flutter_login/screens/home_screen.dart';
import 'package:flutter_login/screens/splash_screen.dart';
import 'package:flutter_login/screens/messages/message_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRouteConstants.splash,
  routes: [
    GoRoute(
      path: AppRouteConstants.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRouteConstants.login,
      builder: (context, state) =>
          const LoginScreen(title: 'Flutter Login Screen'),
    ),
    GoRoute(
      path: AppRouteConstants.signUp,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: AppRouteConstants.forgotPassword,
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: AppRouteConstants.home,
      builder: (context, state) =>
          const HomeScreen(title: 'Flutter Home Screen'),
    ),
    GoRoute(
      path: AppRouteConstants.messages,
      builder: (context, state) => const MessageScreen(),
    ),
  ],
);
