import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:vnica_app/app/constants/constants.dart';
import 'package:vnica_app/app/constants/endpoint.dart';
import 'package:vnica_app/app/data/models/authentication/response_login.dart';
import 'package:vnica_app/app/data/provider/storage_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import '../../../../data/provider/api_provider.dart';
import '../../../../routes/app_pages.dart';

class LoginController extends GetxController {
  // Inputan TextFormField
  final loadinglogin = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var isPasswordHidden = true.obs;

  // Validasi Inputam TextFormField
  final isPasswordValid = true.obs;
  final isEmailValid = true.obs;
  final isEmailTrue = true.obs;
  String? messageValidateEmail;
  String? messageValidatePassword;
  String? messageCheckEmailUser;

  // Validasi Email
  String? validateEmail() {
    String? email = emailController.text.toString().trim();

    if (email.isEmpty) {
      messageValidateEmail = 'Pleasse input email address';
      isEmailValid.value = false;
    } else if (!email.endsWith('@gmail.com')) {
      messageValidateEmail = 'Email harus @gmail.com';
      isEmailValid.value = false;
    } else if (!EmailValidator.validate(email)) {
      messageValidateEmail = 'Email address tidak sesuai';
      isEmailValid.value = false;
    } else {
      // checkEmailUser();
      isEmailValid.value = true;
      messageValidateEmail = '';
    }

    return messageValidateEmail;
  }

  // Validasi Password
  String? validatePassword() {
    String? password = passwordController.text.toString();

    if (password.isEmpty) {
      messageValidatePassword = 'Please input password';
      isPasswordValid.value = false;
    } else if (password.length < 8) {
      messageValidatePassword = 'Panjang password harus lebih dari 8';
      isPasswordValid.value = false;
    }
    // Validasi setidaknya satu huruf besar
    else if (!password.contains(RegExp(r'[A-Z]'))) {
      messageValidatePassword = 'Password harus mengandung satu huruf besar';
      isPasswordValid.value = false;
    }
    // Validasi setidaknya satu karakter khusus
    else if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      messageValidatePassword =
          'Password harus mengandung satu karakter khusus';
      isPasswordValid.value = false;
    }
    // Validasi setidaknya satu angka
    else if (!password.contains(RegExp(r'[0-9]'))) {
      messageValidatePassword = 'Password harus mengandung minimal 1 angka';
      isPasswordValid.value = false;
    } else {
      isPasswordValid.value = true;
      messageValidatePassword = "";
    }

    return messageValidatePassword;
  }

  // Fungsi Login API
  loginPost() async {
    loadinglogin(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        final response = await ApiProvider.instance().post(Endpoint.login,
            data: dio.FormData.fromMap({
              "email": emailController.text.toString(),
              "password": passwordController.text.toString()
            }));
        if (response.statusCode == 200) {
          ResponseLogin responseLogin = ResponseLogin.fromJson(response.data);
          await StorageProvider.write(StorageKey.status, "logged");
          await StorageProvider.write(
              StorageKey.nama, responseLogin.data!.namaLengkap.toString());
          await StorageProvider.write(
              StorageKey.tokenUser, responseLogin.data!.token.toString());
          await StorageProvider.write(
              StorageKey.idUser, responseLogin.data!.id.toString());
          await StorageProvider.write(
              StorageKey.email, responseLogin.data!.email.toString());
          Get.offAllNamed(Routes.DASHBOARD);
        } else {
          showAwesomeMaterialBanner(
            "Sorry",
            "Sign In gagal, periksan koneksi internet anda",
            ContentType.failure,
            kSecondary,
          );
        }
      }
      loadinglogin(false);
    } on dio.DioException catch (e) {
      loadinglogin(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          if (e.response?.statusCode == 400 &&
              e.response?.data['errors']['email'][0] ==
                  'Email belum diverifikasi.') {
            await StorageProvider.write(
                StorageKey.tokenUser, e.response?.data['errors']['token'][0]);
            Get.offAllNamed(
              Routes.VERIFICATIONOTP,
              parameters: {
                'emailUser': emailController.text.toString(),
              },
            );
            return;
          }
          showAwesomeMaterialBanner("Pemberitahuan",
              "${e.response?.data['message']}", ContentType.warning, kRed);
        }
      } else {
        showAwesomeMaterialBanner(
          "Sorry",
          e.message ?? "",
          ContentType.failure,
          kSecondary,
        );
      }
    } catch (e) {
      loadinglogin(false);
      showAwesomeMaterialBanner(
        "Sorry",
        e.toString(),
        ContentType.failure,
        kSecondary,
      );
    }
  }

  // Fungsi untuk snackbar
  void showAwesomeMaterialBanner(
      final String judulText,
      final String deskripsiText,
      final ContentType contentType,
      final Color backgroundColor) {
    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      duration: const Duration(milliseconds: 3000),
      dismissDirection: DismissDirection.down,
      padding: const EdgeInsets.symmetric(vertical: 20),
      behavior: SnackBarBehavior.floating,
      content: AwesomeSnackbarContent(
        color: backgroundColor,
        title: judulText,
        inMaterialBanner: true,
        message: deskripsiText,
        contentType: contentType,
      ),
    );

    ScaffoldMessenger.of(Get.context!)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
