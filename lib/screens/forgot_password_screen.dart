import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Stack(children: const [ForgotPasswordContent()]));
  }
}

/// MAIN CONTENT

class ForgotPasswordContent extends StatelessWidget {
  const ForgotPasswordContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox.expand(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // distributes children
          children: const [
            // Top
            SignUpCard(),

            // Bottom
            Column(
              children: [SubmitButton(), SizedBox(height: 25), LoginText()],
            ),
          ],
        ),
      ),
    );
  }
}

/// BACK BUTTON

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(25),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
    );
  }
}

/// CARD

class SignUpCard extends StatelessWidget {
  const SignUpCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF8E5CF6), Color(0xFF5B7CF6)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Stack(
        children: const [
          Padding(
            padding: EdgeInsets.fromLTRB(24, 150, 24, 40),
            child: SignUpForm(),
          ),

          Positioned(top: 16, left: 0, child: BackButtonWidget()),
        ],
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Center(
          child: Text(
            'Forgot Password',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 32),

        FormLabel(text: 'Username'),
        InputField(hint: 'Enter your username', icon: Icons.person_outline),

        SizedBox(height: 20),

        FormLabel(text: 'Mobile number'),
        InputField(
          hint: 'Enter your mobile number',
          icon: Icons.phone_outlined,
        ),
      ],
    );
  }
}

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

  const InputField({super.key, required this.hint, required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        labelStyle: TextStyle(color: Colors.black),
        prefixIcon: Icon(icon, size: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

/// SIGN UP BUTTON

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: const Text(
              'Submit',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginText extends StatelessWidget {
  const LoginText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Already have an account? '),
        GestureDetector(
          onTap: () {
            context.pop();
          },
          child: const Text(
            'Log in',
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
