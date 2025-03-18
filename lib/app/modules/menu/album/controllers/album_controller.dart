import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vnica_app/app/common/app_textsizes.dart';
import 'package:vnica_app/app/components/content/custom_toast.dart';
import 'package:vnica_app/app/components/custom_button.dart';
import 'package:vnica_app/app/components/custom_snackbar.dart';
import 'package:vnica_app/app/components/custom_textfield.dart';
import 'package:vnica_app/app/constants/constants.dart';
import 'package:vnica_app/app/constants/endpoint.dart';
import 'package:vnica_app/app/data/models/album/response_album.dart';
import 'package:vnica_app/app/data/provider/api_provider.dart';
import 'package:dio/dio.dart' as dio;
import 'package:vnica_app/app/data/provider/storage_provider.dart';
import 'package:vnica_app/app/routes/app_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlbumController extends GetxController with StateMixin<List<DataAlbum>> {
  RxList<DataAlbum> albums = <DataAlbum>[].obs;

  late AnimationController animationController;
  final isLoading = false.obs;
  //TODO: Implement AlbumController
  final textList = [
    'Posting moments, dan abadikan.',
    'Jangan lupa tersenyum hari ini!',
    'Jelajahi foto temanmu!',
    'Semangat dalam mengejar impian!',
  ].obs;

  final currentIndex = 0.obs;
  final count = 0.obs;
  final formKey = GlobalKey<FormState>();
  final TextEditingController albumController = TextEditingController();
  final isAlbumValid = true.obs;
  final isAlbumTrue = true.obs;
  final isLoadingAlbumPost = false.obs;
  String? messageValidateAlbum;

  String? validateAlbum() {
    String? email = albumController.text.toString().trim();

    if (email.isEmpty) {
      messageValidateAlbum = 'Pleasse input nama album';
      isAlbumValid.value = false;
    } else {
      // checkAlbumUser();
      isAlbumValid.value = true;
      messageValidateAlbum = '';
    }

    return messageValidateAlbum;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getAlbum();
  }

  @override
  void onClose() {
    super.onClose();

    animationController.dispose();
  }

  void refreshData() async {
    await getAlbum();
  }

  addAlbumPost() async {
    isLoadingAlbumPost(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        var formData = dio.FormData.fromMap({
          "user_id": int.tryParse(StorageProvider.read(StorageKey.idUser)),
          "nama_album": albumController.text,
        });
        final response = await ApiProvider.instance().post(
          Endpoint.album,
          data: formData,
          options: dio.Options(
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json"
            },
          ),
        );
        if (response.statusCode == 200) {
          ResponseAlbum<DataAlbum> responseFoto =
              ResponseAlbum.fromJson(response.data);
          addAlbum(responseFoto.data as DataAlbum);
          print(responseFoto.data?.toJson());
          clearForm();
          showAwesomeMaterialBanner(
            "Berhasil Menambahkan Album",
            "Album Berhasil Ditambahkan",
            ContentType.success,
            kGreen,
            Get.context!,
          );
          Get.back();
        }
      }
    } on dio.DioException catch (e) {
      if (e.response != null) {
        ResponseAlbum responseFoto = ResponseAlbum.fromJson(e.response?.data);
        if (responseFoto.status == false) {
          CustomToast.ShowToast(
              'Sorry, Terjadi Kesalahan Validasi', kRed, Colors.white);
        }
      } else {
        print(e.message);
        CustomToast.ShowToast('Sorry, Terjadi Kesalahan', kRed, Colors.white);
      }
    } catch (e) {
      print(e);
      CustomToast.ShowToast(e.toString(), kRed, Colors.white);
    } finally {
      isLoadingAlbumPost(false);
    }
  }

  void addAlbum(DataAlbum item) {
    var newSubkelas = item;
    albums.add(newSubkelas);
    albums.refresh();
  }

  void clearForm() {
    albumController.clear();
  }

  Future<void> getAlbum() async {
    isLoading(true);
    change(null, status: RxStatus.loading());
    try {
      final response = await ApiProvider.instance().get(
        Endpoint.album,
        options: dio.Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
        ),
      );

      if (response.statusCode == 200) {
        final ResponseAlbum<List<DataAlbum>> responseSubKelas =
            ResponseAlbum.fromJson(response.data);

        if (responseSubKelas.data!.isEmpty) {
          albums.value = [];

          change(null, status: RxStatus.empty());
        } else {
          print('test anjing ${responseSubKelas.data![0].toJson()}');
          albums.value = responseSubKelas.data ?? [];
          print('test anjing ${albums.value[0].toJson()}');
        }
      } else {
        change(null, status: RxStatus.error("Gagal Memanggil Data"));
      }
    } on dio.DioException catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          StorageProvider.clearAll();
          Get.offAllNamed(Routes.LOGIN);
        }
        final responseData = e.response?.data;
        if (responseData != null) {
          final errorMessage = responseData['message'] ?? "Unknown error";
          change(null, status: RxStatus.error(errorMessage));
        }
      } else {
        change(null, status: RxStatus.error(e.message));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    } finally {
      isLoading(false);
    }
  }

  Future<bool> dialogAlbum() async {
    return await showDialog<bool>(
          context: Get.context!,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Text(
                'Add Album',
                style: GoogleFonts.poppins(
                    fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              content: SingleChildScrollView(
                child: SizedBox(
                  width: MediaQuery.of(Get.context!).size.width,
                  child: ListBody(
                    children: <Widget>[
                      SizedBox(height: 20.h),
                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () => CustomTextField(
                                errorText: isAlbumValid.value
                                    ? null
                                    : messageValidateAlbum,
                                onChanged: (_) => validateAlbum(),
                                controller: albumController,
                                hintLabel: "Cinta",
                                labelText: "Nama ALbum",
                                gapHeight: 10,
                                obsureText: false,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please input nama album';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        width: 100,
                        height: 50,
                        child: CustomButton(
                          childWidget: Text(
                            "Batal",
                            style: GoogleFonts.montserrat(
                              fontSize: AppTextSizes.textButton,
                              color: kWhite,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          onPressed: () {
                            clearForm();
                            Navigator.of(context).pop(false);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        width: 100,
                        height: 50,
                        child: Obx(
                          () => CustomButton(
                            onPressed: () async {
                              await addAlbumPost();
                            },
                            childWidget: isLoadingAlbumPost.value
                                ? const CircularProgressIndicator(
                                    color: kWhite,
                                  )
                                : Text(
                                    "Add",
                                    style: GoogleFonts.montserrat(
                                      fontSize: AppTextSizes.textButton,
                                      color: kWhite,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ) ??
        false;
  }

  void increment() => count.value++;
}
