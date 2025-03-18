import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 30,
        height: 35,
        child: Lottie.asset(
          'assets/logo/logo_loading.json',
          fit: BoxFit.cover,
          repeat: true,
        ),
      ),
    );
  }
}
