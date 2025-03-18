import 'package:get/get.dart';
import 'package:vnica_app/app/modules/menu/album/controllers/album_controller.dart';
import 'package:vnica_app/app/modules/menu/home/controllers/home_controller.dart';
import 'package:vnica_app/app/modules/menu/like/controllers/like_controller.dart';
import 'package:vnica_app/app/modules/menu/profile/controllers/profile_controller.dart';

import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );

    Get.lazyPut<HomeController>(
      () => HomeController(),
    );

    Get.lazyPut<LikeController>(
      () => LikeController(),
    );
    Get.lazyPut<AlbumController>(
      () => AlbumController(),
    );

    Get.lazyPut<LikeController>(
      () => LikeController(),
    );

    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
}
