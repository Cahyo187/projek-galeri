import 'package:carousel_slider/carousel_slider.dart';
import 'package:vnica_app/app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SliderScreen extends StatelessWidget {
  final List imageList = [
    {"id": 1, "image_path": 'assets/home/slider1.png'},
    {"id": 1, "image_path": 'assets/home/slider2.png'},
  ];

  final CarouselSliderController carouselController =
      CarouselSliderController();
  final currentIndex = 0.obs;

  SliderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            // print(currentIndex.value);
          },
          child: CarouselSlider(
            items: imageList
                .map(
                  (item) => Image.asset(
                    item['image_path'],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 150,
                  ),
                )
                .toList(),
            carouselController: carouselController,
            options: CarouselOptions(
              scrollPhysics: const BouncingScrollPhysics(),
              autoPlay: true,
              aspectRatio: 16 / 7,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                currentIndex.value = index;
              },
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imageList.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => carouselController.animateToPage(entry.key),
                    child: Container(
                      width: currentIndex.value == entry.key ? 17 : 7,
                      height: 7.0,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 3.0,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: currentIndex.value == entry.key
                              ? kGray
                              : kSecondary),
                    ),
                  );
                }).toList(),
              )),
        ),
      ],
    );
  }
}
