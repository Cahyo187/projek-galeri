import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vnica_app/app/common/app_sizes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vnica_app/app/common/app_textsizes.dart';
import 'package:vnica_app/app/constants/constants.dart';
import 'package:vnica_app/app/data/models/album/response_album.dart';
import 'package:vnica_app/app/modules/menu/album/controllers/album_controller.dart';
import 'package:vnica_app/app/routes/app_pages.dart';

class WidgetBuildAlbum extends StatelessWidget {
  WidgetBuildAlbum({super.key});
  AlbumController controller = Get.put(AlbumController());
  @override
  Widget build(BuildContext context) {
    AppSizes sizes = AppSizes(context);
    return RefreshIndicator(
      color: kLightWhite,
      backgroundColor: kPrimary,
      onRefresh: () async {
        await Future.delayed(
          const Duration(milliseconds: 1000),
        );
        controller.refreshData();
      },
      child: Obx(
        () => Container(
          width: sizes.sizeWidth,
          height: sizes.sizeHeight,
          color: kLightWhite,
          child: Stack(
            children: [
              GridView.builder(
                  itemCount: controller.albums.value.length + 1,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3.2 / 3,
                  ),
                  itemBuilder: (context, index) {
                    if (index + 1 == controller.albums.value.length + 1) {
                      return InkWell(
                        onTap: () => controller.dialogAlbum(),
                        child: Container(
                          alignment: Alignment.center,
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: kLightWhite,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                color: kPrimary,
                              ),
                              Text(
                                'Tambah Album',
                                style: GoogleFonts.montserrat(
                                  fontSize: AppTextSizes.textButton,
                                  fontWeight: FontWeight.w600,
                                  color: kPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return InkWell(
                        onTap: () {
                          Get.toNamed(
                            Routes.ALBUM_DETAIL,
                            arguments: {
                              'albumId': controller.albums.value[index].id,
                              'nama': controller.albums.value[index].namaAlbum
                            },
                          );
                        },
                        child: PostCard(
                            controller: controller,
                            sizes: sizes,
                            data: controller.albums.value[index],
                            index: index),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class PostCard extends StatefulWidget {
  PostCard({
    super.key,
    required this.sizes,
    required this.data,
    required this.index,
    required this.controller,
  });

  final AppSizes sizes;
  final DataAlbum data;
  final int index;
  final AlbumController controller;
  bool showEditDelete = false;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Container(
        alignment: Alignment.center,
        width: widget.sizes.sizeWidth,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: kGrayLight.withOpacity(0.6),
              blurRadius: 5,
            ),
          ],
          color: kLightWhite,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(
          widget.data.namaAlbum ?? '',
          style: GoogleFonts.montserrat(
            fontSize: AppTextSizes.headingLarge,
            fontWeight: FontWeight.w600,
            color: kSecondary,
          ),
        ),
      ),
    );
  }
}
