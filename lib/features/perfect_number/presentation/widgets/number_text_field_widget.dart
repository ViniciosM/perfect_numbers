import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class NumberTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final VoidCallback? onSubmitted;

  const NumberTextFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: GoogleFonts.spaceGrotesk(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      onSubmitted: (_) => onSubmitted?.call(),
      decoration: InputDecoration(labelText: label, hintText: hint),
    );
  }
}
