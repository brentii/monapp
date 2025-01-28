import 'package:monapp/services/auth_service.dart';
import 'package:monapp/shared/styled_button.dart';
import 'package:monapp/shared/styled_text.dart';
import 'package:flutter/material.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  String? _errorFeedback;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //intro text
            const Center(child: StyledBodyText('Sign-in to your account.')),
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
                return null;
              },
            ),
            const SizedBox(height: 16),

            //password
            TextFormField(
              controller: _passwordCtrl,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
              validator: (value) {
                if (value == null || value.isEmpty){
                  return "Please enter your password";
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            //error feedback
            if(_errorFeedback!=null)
              Text(
                _errorFeedback!,
                style: const TextStyle(color: Colors.red),
              ),
            Text("Forgot Password?", style: TextStyle(color: Colors.grey),),

            //submit/ sign-in button
            StyledButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _errorFeedback = null;
                  });

                  final em = _emailCtrl.text.trim();
                  final pw = _passwordCtrl.text.trim();

                  final user = await AuthService.signIn(em, pw);
                  
                  //error feedback
                  if (user == null) {
                    setState(() {
                      _errorFeedback = "Incorrect login credentials";
                    });
                  }
                }
              },
              child: const StyledButtonText("Sign In")
            ),
          ],
        )
      ),
    );
  }
}