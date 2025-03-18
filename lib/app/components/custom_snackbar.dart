// Fungsi untuk snackbar
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

void showAwesomeMaterialBanner(
    final String judulText,
    final String deskripsiText,
    final ContentType contentType,
    final Color backgroundColor,
    final BuildContext context) {
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

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
