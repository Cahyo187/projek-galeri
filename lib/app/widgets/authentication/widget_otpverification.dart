import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vnica_app/app/common/app_sizes.dart';
import 'package:vnica_app/app/common/app_textsizes.dart';
import 'package:vnica_app/app/constants/constants.dart';

import '../../components/custom_button.dart';

class BuildWidgetOTP extends StatelessWidget {
  final dynamic controller;
  const BuildWidgetOTP({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    // Size
    AppSizes sizes = AppSizes(context);

    return SingleChildScrollView(
      child: Container(
          width: sizes.sizeWidth,
          height: sizes.sizeHeight,
          color: kLightWhite,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: sizes.sizeWidth,
                    height: sizes.sizeHeight * 0.25,
                    decoration: const BoxDecoration(color: kPrimary),
                  ),
                  Container(
                    width: sizes.sizeWidth,
                    height: sizes.sizeHeight * 0.75,
                    color: kLightWhite,
                  ),
                ],
              ),
              Positioned(
                top: sizes.sizeHeight * 0.10,
                left: sizes.sizeWidth * 0.05,
                right: sizes.sizeWidth * 0.05,
                bottom: sizes.sizeHeight * 0.10,
                child: Container(
                  width: sizes.sizeWidth,
                  height: sizes.sizeHeight,
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: sizes.sizeWidth * 0.05),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: sizes.sizeHeight * 0.010,
                        ),
                        SizedBox(
                          width: sizes.sizeWidth,
                          height: sizes.sizeHeight * 0.25,
                          child: Image.asset(
                            'assets/gif/animation_otp.gif',
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        SizedBox(
                          height: sizes.sizeHeight * 0.010,
                        ),
                        Center(
                          child: FittedBox(
                            child: Text(
                              'Email Verifikasi',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                fontSize: AppTextSizes.h1,
                                color: kPrimary,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Text.rich(
                            textAlign: TextAlign.center,
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: controller.textOTP,
                                  style: GoogleFonts.montserrat(
                                    fontSize: AppTextSizes.body,
                                    color: kGray,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                TextSpan(
                                  text: controller.emailUser,
                                  style: GoogleFonts.montserrat(
                                    fontSize: AppTextSizes.body,
                                    color: kPrimary,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: sizes.sizeHeight * 0.035,
                        ),
                        Form(
                          key: controller.formKey,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                              5,
                              (index) => Expanded(
                                child: SizedBox(
                                  height: 68,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: index < 4 ? 8 : 8),
                                    child: TextFormField(
                                      controller: controller.controllers[index],
                                      keyboardType: TextInputType.number,
                                      style: GoogleFonts.montserrat(
                                          fontSize: AppTextSizes.headline,
                                          fontWeight: FontWeight.w700),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      onChanged: (value) {
                                        // Jika nilai input kosong, fokus akan beralih ke input sebelumnya
                                        if (value.isEmpty) {
                                          if (index > 0) {
                                            FocusScope.of(context)
                                                .previousFocus();
                                          }
                                        } else if (value.length == 1) {
                                          // Jika nilai input memiliki panjang 1, fokus akan beralih ke input berikutnya
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      decoration: InputDecoration(
                                        hintText: "0",
                                        hintStyle: GoogleFonts.montserrat(
                                            fontSize: AppTextSizes.headline,
                                            fontWeight: FontWeight.w700,
                                            color: kGray.withOpacity(0.30)),
                                        enabledBorder:
                                            const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: kGray, width: 1.5),
                                        ),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: kPrimary, width: 1.5),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: sizes.sizeHeight * 0.010,
                        ),
                        CustomButton(
                          backgroundColor: kSecondary.withOpacity(0.4),
                          onPressed: () {
                            controller.resendOtp();
                          },
                          childWidget: Obx(
                            () => controller.loadingResend.value
                                ? const CircularProgressIndicator(
                                    color: kWhite,
                                  )
                                : buttonResendOtp(),
                          ),
                        ),
                        SizedBox(
                          height: sizes.sizeHeight * 0.010,
                        ),
                        CustomButton(
                          backgroundColor: kSecondary,
                          onPressed: () {
                            controller.verifikasiOTP();
                          },
                          childWidget: Obx(
                            () => controller.loadinglogin.value
                                ? const CircularProgressIndicator(
                                    color: kWhite,
                                  )
                                : Text(
                                    "Submit",
                                    style: GoogleFonts.montserrat(
                                      fontSize: AppTextSizes.textButton,
                                      color: kWhite,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: sizes.sizeHeight * 0.035,
                        ),
                        sectionResendOTP(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget sectionResendOTP() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FittedBox(
          child: Text(
            "Salah memasukan email anda?",
            maxLines: 1,
            style: GoogleFonts.montserrat(
              fontSize: AppTextSizes.caption,
              color: kGray,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        InkWell(
          onTap: () {},
          child: Text(
            "Edit Email",
            style: GoogleFonts.montserrat(
              fontSize: AppTextSizes.small,
              color: kPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        )
      ],
    );
  }

  Widget buttonResendOtp() {
    if (controller.enableResend) {
      return Text(
        "Resend Otp",
        style: GoogleFonts.montserrat(
          fontSize: AppTextSizes.textButton,
          color: kWhite,
          fontWeight: FontWeight.w700,
        ),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Iconsax.clock5,
            color: kGray,
            size: 22,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            controller.formattedTime,
            style: GoogleFonts.montserrat(
              fontSize: AppTextSizes.textButton,
              color: kGray,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      );
    }
  }
}
