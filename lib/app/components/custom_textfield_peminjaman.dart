import 'package:vnica_app/app/common/app_textsizes.dart';
import 'package:vnica_app/app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFieldPeminjaman extends StatelessWidget {
  final controller;
  final String hintLabel;
  final String labelText;
  final double gapHeight;
  final bool obsureText, isDisabled;
  final Widget? suffixIcon;

  const CustomTextFieldPeminjaman({
    super.key,
    required this.controller,
    required this.hintLabel,
    required this.labelText,
    required this.gapHeight,
    required this.obsureText,
    this.isDisabled = true,
    this.suffixIcon,
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
          enabled: isDisabled,
          initialValue: controller,
          obscureText: obsureText,
          style: GoogleFonts.montserrat(
              fontSize: AppTextSizes.textButton,
              fontWeight: FontWeight.w800,
              color: kPrimary),
          decoration: InputDecoration(
            errorStyle: GoogleFonts.montserrat(
                fontSize: AppTextSizes.small,
                fontWeight: FontWeight.w600,
                color: kPrimary),
            hintText: hintLabel,
            hintStyle: GoogleFonts.montserrat(
                fontSize: AppTextSizes.body,
                fontWeight: FontWeight.w700,
                color: kPrimary),
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kGray, width: 1.3),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kSecondary, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kGray, width: 1.3),
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          ),
        ),
      ],
    );
  }
}
