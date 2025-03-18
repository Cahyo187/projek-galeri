import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vnica_app/app/common/app_textsizes.dart';
import 'package:vnica_app/app/constants/constants.dart';
import 'package:vnica_app/app/data/provider/storage_provider.dart';
import 'package:vnica_app/app/widgets/menu/widget_like.dart';

import '../controllers/like_controller.dart';

class LikeView extends GetView<LikeController> {
  const LikeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kLightWhite,
        title: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  SizedBox(
                    width: 45,
                    height: 45,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'assets/home/profile.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Obx(() {
                    final currentIndex = controller.currentIndex.value;
                    String usernameUser =
                        StorageProvider.read(StorageKey.username);
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hallo $usernameUser',
                          style: GoogleFonts.montserrat(
                            fontSize: AppTextSizes.subheadline,
                            color: kPrimary,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          controller.textList[currentIndex],
                          style: GoogleFonts.montserrat(
                            fontSize: AppTextSizes.small,
                            color: kGray,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.3,
                          ),
                        )
                      ],
                    );
                  })
                ],
              ),
            ),
          ],
        ),
        actions: const [
          SizedBox(
            width: 45,
            height: 45,
            child: Icon(
              Iconsax.notification_bing5,
              size: 30,
              color: kDark,
            ),
          )
        ],
        centerTitle: true,
      ),
      body: WidgetBuildLike(),
    );
  }
}
