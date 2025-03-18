import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vnica_app/app/common/app_textsizes.dart';
import 'package:vnica_app/app/constants/constants.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Seeting TopBar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: kOnBoarding,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
        body: Obx(() => Stack(
              children: [
                Visibility(
                  visible: controller.currentIndex.value == 0,
                  child: layoutOnboarding(
                    'Selamat Datang',
                    'Di Vnicas Tale',
                    'assets/onboarding/onboarding1.png',
                    'Ayo Gabung di Vnicas Tale',
                    'Nikmati pengalaman membaca yang luar biasa dengan kebebasan membaca tak terbatas di RuangPustaka!📚.',
                    'Next',
                  ),
                ),
                Visibility(
                  visible: controller.currentIndex.value == 1,
                  child: layoutOnboarding(
                    'Jelajahi Foto',
                    'Sepuasnya',
                    'assets/onboarding/onboarding2.png',
                    'Kebebasan Jelajah Foto',
                    'Anda dapat menjelajahi Foto digital yang Anda cari dengan fitur Vnicas Tale yang sederhana dan cepat.',
                    'Next',
                  ),
                ),
                Visibility(
                  visible: controller.currentIndex.value == 2,
                  child: layoutOnboarding(
                    'Abadikan Moments',
                    'Sepuasnya',
                    'assets/onboarding/onboarding3.png',
                    'Kebebasan Mengabadikan Foto',
                    'Anda dapat mengabadikan Foto digital Anda dengan fitur Vnicas Tale yang sederhana dan cepat.',
                    'Get Started',
                  ),
                ),
              ],
            )));
  }

  Widget layoutOnboarding(String text1, String text2, String imagePath,
      String judulText, String deskripsiText, String buttonText) {
    // Size
    double sizeWidth = MediaQuery.of(Get.context!).size.width;
    double sizeHeight = MediaQuery.of(Get.context!).size.height;
    double sizeTopBar = MediaQuery.of(Get.context!).padding.top;
    double sizeBody = sizeHeight - sizeTopBar;

    return SafeArea(
      child: Container(
        width: sizeWidth,
        height: sizeBody,
        color: kOnBoarding,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: sizeHeight * 0.015,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizeWidth * 0.10),
                  child: SizedBox(
                    height: sizeHeight * 0.15,
                    width: sizeWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          child: Text(
                            text1,
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w900,
                              fontSize: AppTextSizes.headingLarge,
                              color: kDark,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),
                        FittedBox(
                          child: Text(
                            text2,
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w900,
                              fontSize: AppTextSizes.headingLarge,
                              color: kDark,
                              letterSpacing: -0.5,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: sizeHeight * 0.75,
                  child: Center(
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              height: sizeHeight * 0.25,
              child: Container(
                width: sizeWidth,
                decoration: const BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25),
                    )),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizeWidth * 0.10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FittedBox(
                        child: Text(
                          judulText,
                          style: GoogleFonts.montserrat(
                            fontSize: AppTextSizes.headline,
                            fontWeight: FontWeight.w800,
                            color: kDark,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: sizeHeight * 0.02,
                      ),
                      Text(
                        deskripsiText,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                            fontSize: AppTextSizes.caption,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.3,
                            color: kGray),
                      ),
                      SizedBox(
                        height: sizeHeight * 0.03,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.10),
                            ),
                          ),
                          onPressed: () => controller.nextLayout(),
                          child: Text(
                            buttonText,
                            style: GoogleFonts.montserrat(
                              fontSize: AppTextSizes.textButton,
                              color: kWhite,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
