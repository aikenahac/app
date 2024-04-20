import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CSTextField extends StatelessWidget {
  const CSTextField({
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType = TextInputType.none,
    this.obscured = false,
  });

  final TextEditingController controller;
  final String label;
  final bool obscured;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscured,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        labelText: label,
        labelStyle: GoogleFonts.poppins(),
      ),
      style: GoogleFonts.poppins(),
    );
  }
}
