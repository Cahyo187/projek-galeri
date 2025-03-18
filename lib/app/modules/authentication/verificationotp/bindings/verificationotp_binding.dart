import 'package:get/get.dart';

import '../controllers/verificationotp_controller.dart';

class VerificationotpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerificationotpController>(
      () => VerificationotpController(),
    );
  }
}
