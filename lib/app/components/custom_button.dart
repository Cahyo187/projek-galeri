import 'package:vnica_app/app/constants/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget? childWidget;
  final Color backgroundColor;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.childWidget,
    this.backgroundColor = kPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.10),
          ),
        ),
        onPressed: onPressed,
        child: childWidget,
        // Text(
        //   buttonText,
        //   style: GoogleFonts.montserrat(
        //     fontSize: AppTextSizes.textButton,
        //     color: AppColors.whiteColor,
        //     fontWeight: FontWeight.w700,
        //   ),
        // ),
      ),
    );
  }
}
