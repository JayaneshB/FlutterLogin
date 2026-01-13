import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/app_router/go_router.dart';
import 'package:flutter_login/bloc/auth/auth_bloc.dart';
import 'package:flutter_login/data/network/api_clients.dart';
import 'package:flutter_login/data/repository/auth_repository.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(AuthRepository(ApiClient())),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: 'Flutter Demo',
  //     debugShowCheckedModeBanner: false,
  //     theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
  //     initialRoute: '/',
  //     routes: {
  //       '/': (context) => HomeScreen(title: 'Flutter Home Page'),
  //       '/sign_up': (context) => SignUpScreen(title: 'Sign Up'),
  //     },
  //     home: HomeScreen(title: 'Flutter Home Page'),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: appRouter,
    );
  }
}
