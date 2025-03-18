import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vnica_app/app/routes/app_pages.dart';

class OnboardingController extends GetxController {
  // Bagian untuk pindah layout
  final currentIndex = 0.obs;
  void nextLayout() {
    if (currentIndex.value < 2) {
      currentIndex.value++;
    } else {
      setFirstTime();
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  // Manajemen State
  final box = GetStorage();
  final _isFirstTime = true.obs;

  bool get isFirstTime => _isFirstTime.value;

  void checkFirstTime() async {
    final value = await box.read('firstTime');
    _isFirstTime.value = value ?? true;
  }

  void setFirstTime() async {
    await box.write('firstTime', false);
    _isFirstTime.value = false;
  }

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    checkFirstTime();
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
}
