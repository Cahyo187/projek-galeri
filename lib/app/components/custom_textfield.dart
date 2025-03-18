import 'package:vnica_app/app/common/app_textsizes.dart';
import 'package:vnica_app/app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintLabel;
  final String labelText;
  final double gapHeight;
  final bool obsureText;
  final Widget? suffixIcon;
  final void Function(String) onChanged;
  final String? errorText;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintLabel,
    required this.labelText,
    required this.gapHeight,
    required this.obsureText,
    this.suffixIcon,
    required this.onChanged,
    required this.errorText,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          textAlign: TextAlign.start,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            color: kGray,
            fontSize: AppTextSizes.caption,
            letterSpacing: -0.3,
          ),
        ),
        SizedBox(
          height: gapHeight,
        ),
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          obscureText: obsureText,
          style: GoogleFonts.montserrat(
              fontSize: AppTextSizes.body,
              fontWeight: FontWeight.w600,
              color: kDark),
          decoration: InputDecoration(
            errorText: errorText,
            errorStyle: GoogleFonts.montserrat(
                fontSize: AppTextSizes.small,
                fontWeight: FontWeight.w600,
                color: kPrimary),
            hintText: hintLabel,
            hintStyle: GoogleFonts.montserrat(
                fontSize: AppTextSizes.body,
                fontWeight: FontWeight.w600,
                color: kGray),
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kPrimary, width: 1.3),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kSecondary, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kPrimary, width: 1.3),
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
