import 'package:vnica_app/app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class CustomBottomBarMaterial extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomBarMaterial({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: kGray,
      selectedItemColor: kPrimary,
      onTap: onTap,
      currentIndex: currentIndex,
      showSelectedLabels: true,
      type: BottomNavigationBarType.fixed,
      backgroundColor: kWhite,
      elevation: 0,
      selectedFontSize: 12,
      selectedLabelStyle: GoogleFonts.montserrat(
        fontWeight: FontWeight.w700,
      ),
      iconSize: 28,
      showUnselectedLabels: true,
      items: [
        _bottomNavigationBarItem(
          icon: Iconsax.home5,
          label: 'Home',
        ),
        _bottomNavigationBarItem(
          icon: Iconsax.lovely,
          label: 'Like',
        ),
        _bottomNavigationBarItem(
          icon: Iconsax.bookmark,
          label: 'Album',
        ),
        _bottomNavigationBarItem(
          icon: Iconsax.profile_circle5,
          label: 'Profile',
        ),
      ],
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem({
    required IconData? icon,
    required String label,
  }) {
    if (icon != null) {
      return BottomNavigationBarItem(
        icon: Icon(icon),
        label: label,
      );
    } else {
      return BottomNavigationBarItem(
        icon: Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: kPrimary,
          ),
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: Icon(
              Iconsax.search_favorite,
              color: kWhite,
            ),
          ),
        ),
        label: label,
      );
    }
  }
}
