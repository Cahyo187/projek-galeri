import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:vnica_app/app/widgets/authentication/widget_otpverification.dart';

import '../controllers/verificationotp_controller.dart';

class VerificationotpView extends GetView<VerificationotpController> {
  const VerificationotpView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BuildWidgetOTP(
        controller: controller,
      ),
    );
  }
}
