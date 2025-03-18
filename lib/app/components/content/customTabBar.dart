import 'package:vnica_app/app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTabBar extends StatelessWidget {
  final String tittle;
  final Widget widgetText;
  final Function() onTap;

  const CustomTabBar({
    super.key,
    required this.tittle,
    required this.widgetText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: onTap,
            child: Text(
              tittle,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3,
                  color: kWhite,
                  fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
