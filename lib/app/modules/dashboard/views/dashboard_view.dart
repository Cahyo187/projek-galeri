import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:vnica_app/app/modules/menu/album/views/album_view.dart';
import 'package:vnica_app/app/modules/menu/home/views/home_view.dart';
import 'package:vnica_app/app/modules/menu/like/views/like_view.dart';
import 'package:vnica_app/app/modules/menu/profile/views/profile_view.dart';

import '../../../components/content/customBarMaterial.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (controller) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: IndexedStack(
          index: controller.tabIndex,
          children: const [
            HomeView(),
            LikeView(),
            AlbumView(),
            ProfileView(),
          ],
        ),
        bottomNavigationBar: CustomBottomBarMaterial(
          onTap: controller.changeTabIndex,
          currentIndex: controller.tabIndex,
        ),
      );
    });
  }
}
