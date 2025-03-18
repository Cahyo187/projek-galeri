import 'package:vnica_app/app/common/app_textsizes.dart';
import 'package:vnica_app/app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintLabel;
  final bool obsureText;
  final Widget? suffixIcon;
  final Widget? preffixIcon;
  final void Function(String) onChanged;
  final FormFieldValidator<String>? validator;

  const CustomSearchTextField({
    super.key,
    required this.controller,
    required this.hintLabel,
    required this.obsureText,
    required this.onChanged,
    this.suffixIcon,
    this.preffixIcon,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obsureText,
      style: GoogleFonts.montserrat(
          fontSize: AppTextSizes.body,
          fontWeight: FontWeight.w600,
          color: kDark),
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: kWhite,
        hintText: hintLabel,
        hintStyle: GoogleFonts.montserrat(
            fontSize: AppTextSizes.body,
            fontWeight: FontWeight.w600,
            color: kGray),
        suffixIcon: suffixIcon,
        prefixIcon: preffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kWhite, width: 1.3),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kSecondary, width: 1.3),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kWhite, width: 1.3),
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
      validator: validator,
    );
  }
}
