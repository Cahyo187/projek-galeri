import 'package:vnica_app/app/widgets/authentication/widget_login.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          primary: false,
          child: BuildWidgetLogin(controller: controller)),
    );
  }
}
