import 'package:flutter/material.dart';

class SocialSignInButton extends StatefulWidget {
  final String logoPath; // Path to the image (Google, Facebook, LinkedIn logo)
  final Function onTap; // Action to be triggered on tap
  final double sizeH;
  final double sizeW;

  const SocialSignInButton({
    super.key,
    required this.logoPath,
    required this.onTap,
    required this.sizeH,
    required this.sizeW,
  });

  @override
  State<SocialSignInButton> createState() => _SocialSignInButtonState();
}

class _SocialSignInButtonState extends State<SocialSignInButton> {
  double _scale = 1.0; // Initial scale of the button

  // Function to handle the tap animation
  void _handleTapDown() {
    setState(() {
      _scale = 0.85; // Shrink the button slightly more on tap hold
    });
  }

  void _handleTapUp() {
    setState(() {
      _scale = 1.0; // Return to original scale
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap(); // Trigger the passed onTap function
      },
      onTapDown: (_) => _handleTapDown(), // Trigger animation on tap hold
      onTapUp: (_) => _handleTapUp(), // Reset animation when released
      onTapCancel: () => _handleTapUp(), // Reset animation if tap is canceled
      child: Transform.scale(
        scale: _scale, // Apply scaling transformation to the entire button
        alignment: Alignment.center, // Center the scaling
        child: AnimatedContainer(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.3)),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.3), // Same color as border with opacity
                spreadRadius: .5,
                blurRadius: 5,
                offset: Offset(0, 5), // Shadow position
              ),
            ],
          ),
          duration: const Duration(milliseconds: 100), // Animation duration
          curve: Curves.easeInOut,
          child: Image.asset(
            widget.logoPath, // Dynamic logo path
            height: widget.sizeH, // Dynamic size
            width: widget.sizeW, // Dynamic size
          ),
        ),
      ),
    );
  }
}
