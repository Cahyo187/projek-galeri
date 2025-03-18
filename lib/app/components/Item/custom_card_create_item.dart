import 'package:vnica_app/app/common/app_textsizes.dart';
import 'package:vnica_app/app/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

// ignore: must_be_immutable
class CardCreateItem extends StatelessWidget {
  String? title;
  void Function()? onTap;
  CardCreateItem({super.key, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Container(
          width: 135,
          height: 250,
          decoration: BoxDecoration(
              color: kGray.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10)),
          child: Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 30, left: 15),
                  child: Text(
                    'Belum ada ${title} yang dibuat',
                    style: GoogleFonts.montserrat(
                      color: kWhite,
                      fontSize: AppTextSizes.caption,
                      letterSpacing: -0.3,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                  ),
                ),
              ),
              Positioned(
                bottom: 15,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 80.w,
                        child: Text(
                          'Tambah Item',
                          maxLines: 1,
                          style: GoogleFonts.montserrat(
                            color: kWhite,
                            fontSize: AppTextSizes.small,
                            letterSpacing: -0.3,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Icon(
                        Iconsax.add_circle,
                        color: kWhite,
                        size: 16,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
