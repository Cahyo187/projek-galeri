import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:vnica_app/app/data/provider/storage_provider.dart';
import 'package:vnica_app/app/routes/app_pages.dart';

import '../../onboarding/controllers/onboarding_controller.dart';
import '../controllers/splashscreen_controller.dart';

class SplashscreenView extends GetView<SplashscreenController> {
  const SplashscreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Size
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // Lottie Assets
    String lottieAsset;
    if (height < 740) {
      lottieAsset = 'assets/logo/ruangpustaka_small.json';
    } else {
      lottieAsset = 'assets/logo/ruangpustaka.json';
    }

    // Seeting TopBar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark, // Change this color as needed
    ));

    String status = StorageProvider.read(StorageKey.status);

    Future.delayed(const Duration(milliseconds: 8000), (() {
      if (status == 'logged') {
        print(status);
        Get.offAllNamed(Routes.DASHBOARD);
      } else {
        Get.offAllNamed(Routes.LOGIN);
      }
    }));

    return Scaffold(
        body: SizedBox(
      width: width,
      height: height,
      child: Center(
        child: Lottie.asset(
          lottieAsset,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          repeat: false,
        ),
      ),
    ));
  }
}
