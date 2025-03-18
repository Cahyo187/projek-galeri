import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vnica_app/app/widgets/authentication/widget_register.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          reverse: true,
          primary: false,
          child: BuildWidgetRegister(
            controller: controller,
          ),
        ));
  }
}
