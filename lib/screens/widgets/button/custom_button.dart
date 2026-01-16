import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Function() onTap;
  final Color? color;
  const CustomButton({super.key, required this.buttonText, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        backgroundColor: color ?? const Color(0xFF14B8A6),
        foregroundColor: const Color(0xFF111214),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 10,
      ),
      onPressed: onTap,
      child: Text(
        buttonText,
        style: GoogleFonts.manrope(fontSize: 18, fontWeight: FontWeight.w800),
      ),
    );
  }
}
