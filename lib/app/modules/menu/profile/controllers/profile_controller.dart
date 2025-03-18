import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:vnica_app/app/constants/endpoint.dart';
import 'package:vnica_app/app/data/provider/api_provider.dart';
import 'package:vnica_app/app/data/provider/storage_provider.dart';
import 'package:vnica_app/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  final loadingLogout = false.obs;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  void logout() async {
    loadingLogout.value = true;
    try {
      final response = await ApiProvider.instance().post(
        Endpoint.logout,
      );
      if (response.statusCode == 200) {
        StorageProvider.clearAll();
        Get.offAllNamed(Routes.LOGIN);
      }
    } catch (e) {
      print(e);
    }
  }
}
