import 'package:coinseek/utils/assets.util.dart';
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
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: AppAssets.colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: AppAssets.colors.black),
        ),
        labelText: label,
        labelStyle: GoogleFonts.poppins(
          color: AppAssets.colors.black,
        ),
      ),
      cursorColor: AppAssets.colors.black,
      style: GoogleFonts.poppins(),
    );
  }
}
