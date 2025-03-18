import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vnica_app/app/common/app_textsizes.dart';
import 'package:vnica_app/app/components/custom_button.dart';
import 'package:vnica_app/app/constants/constants.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ProfileView'),
          centerTitle: true,
        ),
        body: Column(children: [
          CustomButton(
            onPressed: () {
              controller.logout();
            },
            childWidget: Obx(
              () => controller.loadingLogout.value
                  ? const CircularProgressIndicator(
                      color: kWhite,
                    )
                  : Text(
                      "Logout",
                      style: GoogleFonts.montserrat(
                        fontSize: AppTextSizes.textButton,
                        color: kWhite,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
          ),
        ]));
  }
}
