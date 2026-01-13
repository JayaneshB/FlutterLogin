import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/app_router/app_route_constants.dart';
import 'package:flutter_login/bloc/auth/auth_bloc.dart';
import 'package:flutter_login/bloc/auth/auth_events.dart';
import 'package:flutter_login/bloc/auth/auth_states.dart';

/// SIGN UP SCREEN

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SignUpCard(
              emailController: emailController,
              passwordController: passwordController,
              confirmPasswordController: confirmPasswordController,
            ),
            const Column(
              children: [
                SizedBox(height: 16),
                LoginText(),
                SizedBox(height: 24),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// SIGN UP CARD

class SignUpCard extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const SignUpCard({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF8E5CF6), Color(0xFF5B7CF6)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BackButtonWidget(),
          const SizedBox(height: 24),
          const Center(
            child: Text(
              'SIGN UP',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 32),

          const FormLabel(text: 'Email'),
          InputField(
            hint: 'Enter your email',
            icon: Icons.email_outlined,
            controller: emailController,
          ),

          const SizedBox(height: 20),

          const FormLabel(text: 'Password'),
          PasswordField(controller: passwordController),

          const SizedBox(height: 20),

          const FormLabel(text: 'Confirm Password'),
          PasswordField(controller: confirmPasswordController),

          const SizedBox(height: 32),

          SignUpButton(
            emailController: emailController,
            passwordController: passwordController,
            confirmPasswordController: confirmPasswordController,
          ),
        ],
      ),
    );
  }
}

/// BACK BUTTON

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(25),
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
          onPressed: () => context.pop(),
        ),
      ),
    );
  }
}

/// FORM WIDGETS

class FormLabel extends StatelessWidget {
  final String text;
  const FormLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final TextEditingController controller;

  const InputField({
    super.key,
    required this.hint,
    required this.icon,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: inputDecoration(hintText: hint, icon: icon),
    );
  }
}

class PasswordField extends StatelessWidget {
  final TextEditingController controller;

  const PasswordField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      decoration: inputDecoration(
        hintText: "Enter password",
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
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide.none,
    ),
  );
}

/// SIGN UP BUTTON (BlocConsumer)

class SignUpButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const SignUpButton({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          context.go(AppRouteConstants.home);
        }

        if (state is AuthFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: state is AuthLoading
                ? null
                : () {
                    if (passwordController.text !=
                        confirmPasswordController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Passwords do not match")),
                      );
                      return;
                    }

                    context.read<AuthBloc>().add(
                      SignUpRequested(
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
                    "Sign Up",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
          ),
        );
      },
    );
  }
}

/// LOGIN TEXT

class LoginText extends StatelessWidget {
  const LoginText({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pop(),
      child: const Text(
        "Already have an account? Log in",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
