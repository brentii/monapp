import 'package:monapp/services/auth_service.dart';
import 'package:monapp/shared/styled_button.dart';
import 'package:monapp/shared/styled_text.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  String? _errorFeedback;

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your password";
    }
    if (value.length < 8) {
      return "Password must be at least 8 characters";
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return "Password must contain at least one uppercase letter";
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return "Password must contain at least one lowercase letter";
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return "Password must contain at least one number";
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return "Password must contain at least one special character";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //intro text
            const Center(child: StyledBodyText('Sign-up for a new account.')),
            const SizedBox(height: 16),

            //email address
            TextFormField(
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: "Email"),
              validator: (value) {
                if (value == null || value.isEmpty){
                  return "Please enter your email";
                }
                /*if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return "Please enter a valid email. ex: example@email.com";
                }*/
                return null;
              },
            ),
            const SizedBox(height: 16),

            //password
            TextFormField(
              controller: _passwordCtrl,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
              validator: _validatePassword,
            ),
            const SizedBox(height: 16),

            //error feedback
            if(_errorFeedback!=null)
              Text(
                _errorFeedback!,
                style: const TextStyle(color: Colors.red),
              ),

            //submit/ sign-in button
            StyledButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _errorFeedback = null;
                  });

                  final em = _emailCtrl.text.trim();
                  final pw = _passwordCtrl.text.trim();

                  final user = await AuthService.signUp(em, pw);

                  //error feedback
                  if (user == null) {
                    setState(() {
                      _errorFeedback = "Could not sign up with those details";
                    });
                  }
                }
              },
              child: const StyledButtonText("Sign Up")
            ),
          ],
        )
      ),
    );
  }
}