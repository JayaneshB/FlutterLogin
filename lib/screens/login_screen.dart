import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/app_router/app_route_constants.dart';
import 'package:flutter_login/bloc/auth/auth_bloc.dart';
import 'package:flutter_login/bloc/auth/auth_events.dart';
import 'package:flutter_login/bloc/auth/auth_states.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.title});
  final String title;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6FB),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            /// TOP WHITE SPACE
            SizedBox(height: MediaQuery.of(context).padding.top + 300),

            /// LOGIN CARD FILLS REST OF SCREEN
            Expanded(
              child: LoginCard(
                emailController: emailController,
                passwordController: passwordController,
                rememberMe: rememberMe,
                onRememberChanged: (value) {
                  setState(() {
                    rememberMe = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginCard extends StatelessWidget {
  const LoginCard({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.rememberMe,
    required this.onRememberChanged,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool rememberMe;
  final ValueChanged<bool> onRememberChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF8E6CEF), Color(0xFF6A5AE0)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          /// 🔼 FORM SECTION (TOP)
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  const FieldLabel(text: "Email"),
                  const SizedBox(height: 8),
                  EmailField(controller: emailController),
                  const SizedBox(height: 16),
                  const FieldLabel(text: "Password"),
                  const SizedBox(height: 8),
                  PasswordField(controller: passwordController),
                  const SizedBox(height: 8),
                  RememberForgotRow(
                    rememberMe: rememberMe,
                    onRememberChanged: onRememberChanged,
                  ),
                ],
              ),
            ),
          ),

          /// 🔽 BOTTOM SECTION (STICKY)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LoginButton(
                emailController: emailController,
                passwordController: passwordController,
              ),
              const SizedBox(height: 16),
              const SignUpText(),
            ],
          ),
        ],
      ),
    );
  }
}

class EmailField extends StatelessWidget {
  const EmailField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: inputDecoration(
        hintText: "Enter your email",
        icon: Icons.email_outlined,
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  const PasswordField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      decoration: inputDecoration(
        hintText: "Enter your password",
        icon: Icons.lock_outline,
      ),
    );
  }
}

InputDecoration inputDecoration({
  required String hintText,
  required IconData icon,
}) {
  return InputDecoration(
    hintText: hintText,
    prefixIcon: Icon(icon, size: 20),
    filled: true,
    fillColor: Colors.white,
    labelStyle: TextStyle(color: Colors.black),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide.none,
    ),
  );
}

class FieldLabel extends StatelessWidget {
  const FieldLabel({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white, fontSize: 16),
    );
  }
}

class RememberForgotRow extends StatelessWidget {
  const RememberForgotRow({
    super.key,
    required this.rememberMe,
    required this.onRememberChanged,
  });

  final bool rememberMe;
  final ValueChanged<bool> onRememberChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: rememberMe,
          onChanged: (value) => onRememberChanged(value ?? false),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        const Text("Remember me", style: TextStyle(color: Colors.white)),
        const Spacer(),
        TextButton(
          onPressed: () {
            /**
             *   Moves to the Forgot password screen but it removes it from the stack so back icon won't be present
            */

            // context.go(AppRouteConstants.forgotPassword);
            context.push(AppRouteConstants.forgotPassword);
          },
          child: const Text(
            "Forgot password?",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          context.go(AppRouteConstants.home);
        }

        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              elevation: 0,
              content: CustomSnackBar(
                message: state.message,
                backgroundColor: Colors.redAccent,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state is AuthLoading
              ? null
              : () {
                  context.read<AuthBloc>().add(
                    LoginRequested(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    ),
                  );
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: state is AuthLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Text(
                  "Login",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
        );
      },
    );
  }
}

class SignUpText extends StatelessWidget {
  const SignUpText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          /**
           *  Using Navigator
            */

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => SignUpScreen(title: "Sign Up"),
          //   ),
          // );

          /**
          *  Using Navigator with named routes
          */

          // Navigator.pushNamed(context, '/sign_up');

          /**
          *  Using Navigator routes with go_router
           */

          context.push(AppRouteConstants.signUp);
        },
        child: const Text(
          "Don’t have an account? Sign Up",
          style: TextStyle(
            color: Colors.white,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}

class CustomSnackBar extends StatelessWidget {
  const CustomSnackBar({
    super.key,
    required this.message,
    required this.backgroundColor,
  });

  final String message;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.white),
          const SizedBox(width: 8),
          // ✅ Expanded allows text to wrap instead of overflowing
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
