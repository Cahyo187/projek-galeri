import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vnica_app/app/common/app_style.dart';
import 'package:vnica_app/app/common/reusable_text.dart';
import 'package:vnica_app/app/constants/constants.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 110.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      color: kOffWhite,
      child: Container(
        margin: EdgeInsets.only(top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25.r,
                  backgroundColor: kSecondary,
                  backgroundImage: const NetworkImage(
                      "https://yt3.googleusercontent.com/ytc/AIdro_ltetWFU6uIu-Bxg5-jDER2jRqOUwWzrp5pbKtqk2zRUQg=s176-c-k-c0x00ffffff-no-rj"),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 6.h, left: 8.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                        text: "Deliver To",
                        textStyle: appStyle(13, kSecondary, FontWeight.w600),
                      ),
                      SizedBox(
                          width: width * 0.65,
                          child: Text(
                            "Jl. Raya Cempaka Putih No. 7",
                            overflow: TextOverflow.ellipsis,
                            style: appStyle(12, kGrayLight, FontWeight.normal),
                          ))
                    ],
                  ),
                ),
              ],
            ),
            Text(
              getTimeOfDay(),
              style: const TextStyle(fontSize: 35),
            )
          ],
        ),
      ),
    );
  }

  String getTimeOfDay() {
    var hour = DateTime.now().hour;
    if (hour < 12 && hour >= 5) {
      return '🌞';
    }
    if (hour < 17 && hour >= 12) {
      return '⛅';
    }
    return '🌙';
  }
}
