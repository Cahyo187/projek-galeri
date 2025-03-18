import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart' as dio;
import 'package:vnica_app/app/constants/constants.dart';

import 'package:vnica_app/app/constants/endpoint.dart';
import 'package:vnica_app/app/data/models/authentication/response_login.dart';
import 'package:vnica_app/app/data/provider/api_provider.dart';
import 'package:vnica_app/app/data/provider/storage_provider.dart';
import 'package:vnica_app/app/routes/app_pages.dart';

class VerificationotpController extends GetxController {
  List<TextEditingController> controllers =
      List.generate(5, (index) => TextEditingController());
  FocusNode nextFocusNode = FocusNode();
  final _secondsRemaining = 60.obs; // 1 menit = 60 detik
  Timer? _timer;
  final _enableResend = true.obs;
  late String emailUser;
  late String textOTP;

  // Post OTP
  final loadinglogin = false.obs;
  final loadingResend = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    _enableResend.value = false;
    startTimer();
    for (var i = 0; i < controllers.length - 1; i++) {
      controllers[i].addListener(() {
        if (controllers[i].text.length == 1) {
          // Fokuskan ke controller berikutnya jika panjang karakter = 1
          FocusScope.of(Get.context!).requestFocus(nextFocusNode);
        }
      });

      emailUser = Get.parameters['emailUser'].toString();
      textOTP = "Masukan kode OTP yang telah di kirimkan ke email ";
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  bool get enableResend => _enableResend.value;

  String get formattedTime {
    return '${_secondsRemaining.value} Seconds';
  }

  void startTimer() {
    _secondsRemaining.value = 60;
    _timer?.cancel(); // Batalkan timer sebelumnya jika ada
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining.value > 0) {
        _secondsRemaining.value--;
      } else {
        _timer?.cancel();
        _enableResend.value = true;
      }
    });
  }

  void resetTimer() {
    _enableResend.value = false;
    startTimer();
  }

  // Get Kode Otp
  String getOtpFromTextFields() {
    String otp = '';
    for (TextEditingController controller in controllers) {
      otp += controller.text;
    }
    return otp;
  }

  resendOtp() async {
    try {
      final response = await ApiProvider.instance().post(Endpoint.resendOtp,
          data: dio.FormData.fromMap({
            "email": emailUser,
          }));
      if (response.statusCode == 200) {
        showAwesomeMaterialBanner(
          "Success",
          "OTP Berhasil dikirimkan ke email",
          ContentType.success,
          kGreen,
        );
        resetTimer();
      } else {
        showAwesomeMaterialBanner(
          "Sorry",
          "OTP Gagal dikirimkan ke email",
          ContentType.failure,
          kSecondary,
        );
      }
    } catch (e) {
      showAwesomeMaterialBanner(
        "Sorry",
        "Terjadi Kesalahan Server",
        ContentType.failure,
        kRed,
      );
    }
  }

  verifikasiOTP() async {
    loadinglogin(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        final response = await ApiProvider.instance().post(Endpoint.verifyOtp,
            data: dio.FormData.fromMap({
              "otp": getOtpFromTextFields(),
            }));
        if (response.statusCode == 200) {
          ResponseLogin responseLogin = ResponseLogin.fromJson(response.data);
          await StorageProvider.write(StorageKey.status, "logged");
          await StorageProvider.write(
              StorageKey.nama, responseLogin.data!.namaLengkap.toString());
          await StorageProvider.write(
              StorageKey.username, responseLogin.data!.username.toString());
          await StorageProvider.write(
              StorageKey.tokenUser, responseLogin.data!.token.toString());
          await StorageProvider.write(
              StorageKey.idUser, responseLogin.data!.id.toString());
          await StorageProvider.write(
              StorageKey.email, responseLogin.data!.email.toString());

          String usernameUser = responseLogin.data!.username.toString();
          showAwesomeMaterialBanner(
            "Verifikasi Berhasil",
            "Proses verifikasi akun berhasil, selamat datang kembali $usernameUser",
            ContentType.success,
            kGreen,
          );
          Get.offAllNamed(Routes.DASHBOARD);
        } else {
          showAwesomeMaterialBanner(
            "Sorry",
            "Verifikasi akun gagal, periksan koneksi internet anda",
            ContentType.failure,
            kSecondary,
          );
        }
      }
      loadinglogin(false);
    } on dio.DioException catch (e) {
      loadinglogin(false);
      if (e.response != null) {
        print(e.response);
        if (e.response?.data != null) {
          showAwesomeMaterialBanner("Pemberitahuan",
              "${e.response?.data['message']}", ContentType.warning, kYellow);
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
