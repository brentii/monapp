// ignore_for_file: avoid_print

import 'package:animate_do/animate_do.dart';
import 'package:monapp/screens/welcome/sign_in.dart';
import 'package:monapp/screens/welcome/sign_up.dart';
import 'package:monapp/services/auth_service.dart';
import 'package:monapp/shared/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'socialsignin_button.dart';


const kGradient = LinearGradient(
  begin: Alignment.topCenter,
  colors: [
    Color(0xFF003D99),
    Color(0xFF0066CC),
    Color(0xFF66B2FF),
  ],
);

const kBounceDuration = Duration(milliseconds: 1000);
const kFadeInDuration = Duration(milliseconds: 1400);

const kBoxShadow = [
  BoxShadow(
    color: Color.fromRGBO(26, 10, 1, 0.3),
    blurRadius: 20,
    offset: Offset(0, 10),
  ),
];

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isSignUpForm = true;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(gradient: kGradient),
            child: Column(
              children: [
                BounceInDown(
                  duration: kBounceDuration,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: screenWidth * 0.25),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.3),
                              spreadRadius: 3,
                              blurRadius: 10,
                              offset: Offset(0, 7), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/icon/main-icon.png',
                          width: screenWidth * 0.25,
                        ),
                      ),
                      SizedBox(height: screenWidth * 0.05),
                      Text(
                        "Welcome to Mon App",
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            shadows: [
                              Shadow(
                                offset: Offset(1.0, 3.0),
                                blurRadius: 3.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenWidth * 0.1),
                AuthContainer(
                  isSignUpForm: isSignUpForm,
                  onToggleForm: () => setState(() => isSignUpForm = !isSignUpForm),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AuthContainer extends StatelessWidget {
  final bool isSignUpForm;
  final VoidCallback onToggleForm;

  const AuthContainer({
    super.key,
    required this.isSignUpForm,
    required this.onToggleForm,
  });

  Future<void> _signInWithGoogle() async {
    try {
      await AuthService.signInWithGoogle();
      // Handle successful sign-in here, e.g., navigate or show message
      print("Google sign-in successful");
    } catch (error) {
      print("Google sign-in failed: $error");
    }
  }
  
  Future<void> _signInWithFacebook() async {
    try {
      /*
      final result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        // Handle successful sign-in here, e.g., navigate or show message
      } else {
        print("Facebook sign-in failed: ${result.status}");
      }*/
      print("Facebook sign-in failed");
    } catch (error) {
      print("Facebook sign-in error: $error");
    }
  }
  

  Future<void> _signInWithLinkedIn() async {
    // LinkedIn authentication logic (OAuth2)
    // Note: You can integrate LinkedIn's API for OAuth2 authentication here.
    print("LinkedIn sign-in logic here.");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60),
          topRight: Radius.circular(60),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: FadeInUp(
          duration: kFadeInDuration,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: kBoxShadow,
            ),
            child: Column(
              children: [
                isSignUpForm
                    ? SignUpFormSection(onToggle: onToggleForm)
                    : SignInFormSection(onToggle: onToggleForm),
                const SizedBox(height: 10),
                StyledBodyText("Or sign-in with"),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    // Google Sign-In Button
                    SocialSignInButton(
                      logoPath: 'assets/icon/auth_logo/google.png', 
                      onTap: _signInWithGoogle, 
                      sizeH: 40, 
                      sizeW: 40,
                    ),

                    // Facebook Sign-In Button
                    SocialSignInButton(
                      logoPath: 'assets/icon/auth_logo/facebook.png', 
                      onTap: _signInWithFacebook, 
                      sizeH: 40, 
                      sizeW: 40,
                    ),
                    
                    // LinkedIn Sign-In Button
                    SocialSignInButton(
                      logoPath: 'assets/icon/auth_logo/linkedin.png', 
                      onTap: _signInWithLinkedIn, 
                      sizeH: 40, 
                      sizeW: 40,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class SignUpFormSection extends StatelessWidget {
  final VoidCallback onToggle;

  const SignUpFormSection({super.key, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SignUpForm(),
        const StyledBodyText("Already have an account?"),
        TextButton(
          onPressed: onToggle,
          child: Text("Sign-in instead", style: GoogleFonts.poppins()),
        ),
      ],
    );
  }
}

class SignInFormSection extends StatelessWidget {
  final VoidCallback onToggle;

  const SignInFormSection({super.key, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SignInForm(),
        const StyledBodyText("Need an account?"),
        TextButton(
          onPressed: onToggle,
          child: Text("Sign-up instead", style: GoogleFonts.poppins()),
        ),
      ],
    );
  }
}
