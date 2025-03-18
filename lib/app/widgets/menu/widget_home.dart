import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vnica_app/app/common/app_sizes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vnica_app/app/common/app_textsizes.dart';
import 'package:vnica_app/app/components/custom_button.dart';
import 'package:vnica_app/app/constants/constants.dart';
import 'package:vnica_app/app/constants/endpoint.dart';
import 'package:vnica_app/app/data/models/foto/response_foto.dart';
import 'package:vnica_app/app/modules/menu/home/controllers/home_controller.dart';

class WidgetBuildHome extends StatelessWidget {
  WidgetBuildHome({super.key});
  HomeController controller = Get.put(HomeController());
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
              SingleChildScrollView(
                child: Column(
                  children: [
                    addPost(context),
                    ...List.generate(
                      controller.fotos.length,
                      (index) => PostCard(
                        controller: controller,
                        sizes: sizes,
                        data: controller.fotos.value[index],
                        index: index,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listFrinds() {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 10),
      height: 100,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) => index == 0
            ? SizedBox(
                width: 70,
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundColor: kPrimary,
                      child: Icon(Icons.add, color: kWhite),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Add Friends",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                        color: kDark,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              )
            : SizedBox(
                width: 70,
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundColor: kGray,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Name",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                        color: kDark,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  Widget addPost(BuildContext context) {
    return Card(
      color: kLightWhite,
      shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 0.1,
            color: kGrayLight,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.r),
          )),
      elevation: 0.5,
      margin: const EdgeInsets.symmetric(
          horizontal: 20, vertical: 10), // Jarak kanan-kiri dan atas-bawah
      child: Form(
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.r,
                    backgroundColor: kWhite,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Image.asset(
                        'assets/home/profile.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: controller.descriptionController,
                      keyboardType: TextInputType.text,
                      style: GoogleFonts.montserrat(
                        fontSize: AppTextSizes.caption,
                        fontWeight: FontWeight.w700,
                      ),
                      validator: (value) => controller.validateDescription(),
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Write something here...",
                        hintStyle: GoogleFonts.montserrat(
                          fontSize: AppTextSizes.caption,
                          fontWeight: FontWeight.w700,
                          color: kGray.withOpacity(0.30),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Obx(() {
                if (controller.imagePost.value != null) {
                  return Container(
                    height: 200.h,
                    margin: EdgeInsets.only(bottom: 10.h, top: 10.h),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: -2,
                          blurRadius: 5,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Image.file(controller.imagePost.value!),
                  );
                } else
                  return Container();
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Pusatkan Row
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.1), // Warna shadow
                              spreadRadius:
                                  -2, // Spread radius negatif untuk inner shadow
                              blurRadius: 5, // Blur radius
                              offset: const Offset(0, 1), // Offset shadow
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: () async {
                            await controller.pickImage();
                          },
                          icon: const Icon(Icons.image),
                          color: kPrimary,
                          style: IconButton.styleFrom(
                            backgroundColor: kWhite,
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(5),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.1), // Warna shadow
                              spreadRadius:
                                  -2, // Spread radius negatif untuk inner shadow
                              blurRadius: 5, // Blur radius
                              offset: const Offset(0, 1), // Offset shadow
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.camera_alt),
                          color: kPrimary,
                          style: IconButton.styleFrom(
                            backgroundColor: kWhite,
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(5),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.1), // Warna shadow
                              spreadRadius:
                                  -2, // Spread radius negatif untuk inner shadow
                              blurRadius: 5, // Blur radius
                              offset: const Offset(0, 1), // Offset shadow
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Iconsax.microphone),
                          color: kPrimary,
                          style: IconButton.styleFrom(
                            backgroundColor: kWhite,
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 120.w,
                    child: CustomButton(
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          controller.contentPost();
                        }
                      },
                      childWidget: Obx(
                        () => controller.loadingPost.value
                            ? const CircularProgressIndicator(
                                color: kWhite,
                              )
                            : Text(
                                "Posting",
                                style: GoogleFonts.montserrat(
                                  fontSize: AppTextSizes.textButton,
                                  color: kWhite,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
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
  final DataFoto data;
  final int index;
  final HomeController controller;
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
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 25.r,
                            backgroundColor: kGray,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.data.user?.namaLengkap ?? '',
                              style: TextStyle(
                                color: kDark,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              widget.data.tanggalUnggah ?? '',
                              style: TextStyle(
                                color: kDark.withOpacity(0.4),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Expanded(child: Container()),
                        (widget.data.author ?? false)
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    widget.showEditDelete =
                                        !widget.showEditDelete;
                                  });
                                },
                                icon: const Icon(Icons.more_vert),
                              )
                            : const SizedBox()
                      ],
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.network(
                        '${Endpoint.baseUrlApi}${widget.data.lokasiFoto}',
                        height: 200.h,
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  widget.controller.updateLike(widget.index);
                                },
                                child: Icon(
                                  (widget.data.like ?? false)
                                      ? Iconsax.heart5
                                      : Iconsax.heart,
                                  color: kPrimary,
                                ),
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              Text(
                                widget.data.likeCount?.toString() ?? '0',
                                style: TextStyle(
                                  fontFamily:
                                      GoogleFonts.montserrat().fontFamily,
                                  color: kDark,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  widget.controller
                                      .getKomentar(widget.data.id ?? 0);
                                  widget.controller.showBottomDialogComentar(
                                      context, widget.data.id ?? 0);
                                },
                                child: const Icon(
                                  Iconsax.message,
                                  color: kPrimary,
                                ),
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              Text(
                                widget.data.komentarCount?.toString() ?? '0',
                                style: TextStyle(
                                  fontFamily:
                                      GoogleFonts.montserrat().fontFamily,
                                  color: kDark,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.data.user?.username ?? '',
                            style: TextStyle(
                              color: kDark,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                              widget.data.deskripsiFoto ?? '',
                              style: TextStyle(
                                color: kGray,
                                fontFamily: GoogleFonts.montserrat().fontFamily,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                if (widget.showEditDelete == true)
                  Positioned(
                    top: 50.h,
                    right: 10.h,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: const [
                            BoxShadow(
                              color: kGrayLight,
                              blurRadius: 5,
                            ),
                          ]),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () =>
                                widget.controller.deletePost(widget.data),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  Icons.delete,
                                  color: kRed,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Text('Delete'),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          InkWell(
                            onTap: () async {
                              widget.controller.selectedAlbumForm?.value = {
                                'id': widget.data.albumId?.toString() ?? '',
                                'name':
                                    widget.data.album?.namaAlbum.toString() ??
                                        '',
                              };
                              await widget.controller
                                  .dialogAlbum(foto: widget.data);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.add,
                                  color: kDark,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 12.w,
                                ),
                                Text('Album'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
