import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vnica_app/app/common/app_textsizes.dart';
import 'package:vnica_app/app/components/content/custom_toast.dart';
import 'package:vnica_app/app/components/custom_button.dart';
import 'package:vnica_app/app/components/custom_dropdown.dart';
import 'package:vnica_app/app/components/custom_snackbar.dart';
import 'package:vnica_app/app/components/src/dropdown_form_validations.dart';
import 'package:vnica_app/app/constants/constants.dart';
import 'package:vnica_app/app/constants/endpoint.dart';
import 'package:vnica_app/app/data/models/foto/response_foto.dart';
import 'package:vnica_app/app/data/models/komentar/response_komentar.dart';
import 'package:vnica_app/app/data/provider/api_dropdown_data.dart';
import 'package:vnica_app/app/data/provider/api_provider.dart';
import 'package:vnica_app/app/data/provider/storage_provider.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart' as dio;
import 'package:vnica_app/app/modules/menu/like/controllers/like_controller.dart';
import 'package:vnica_app/app/routes/app_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeController extends GetxController with StateMixin<List<DataFoto>> {
  RxMap<String, String>? selectedAlbumForm = RxMap<String, String>();
  RxList<Map<String, String>> listAlbum = <Map<String, String>>[].obs;
  final LikeController _likeController = Get.find<LikeController>();
  final isDeskripsiValid = true.obs;
  RxList<DataFoto> fotos = <DataFoto>[].obs;
  RxList<DataKomentar> komentars = <DataKomentar>[].obs;
  final isLoading = false.obs;
  final isLoadingKomentar = false.obs;
  final loadingPostKomentar = false.obs;
  final showKomentar = false.obs;
  String? messageValidateEmail;
  String? validateDescription() {
    String? deskripsi = descriptionController.text.toString().trim();

    if (deskripsi.isEmpty) {
      messageValidateEmail = 'Tolong masukan judul postingan';
      isDeskripsiValid.value = false;
    } else {
      messageValidateEmail = null;
      isDeskripsiValid.value = true;
    }

    return messageValidateEmail;
  }

  final loadingPost = false.obs;
  final loadingAlbumPost = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyKomentar = GlobalKey<FormState>();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController komentarController = TextEditingController();
  // Animation Text
  late AnimationController animationController;
  final textList = [
    'Posting moments, dan abadikan.',
    'Jangan lupa tersenyum hari ini!',
    'Jelajahi foto temanmu!',
    'Semangat dalam mengejar impian!',
  ].obs;
  final currentIndex = 0.obs;
  final showEditDeleteKomentar = 0.obs;
  // Banner Pemberitahuan
  RxBool showBanner = false.obs;
  final Rx<File?> imagePost = Rx<File?>(null);

  void showNotificationBanner() {
    String statusBanner = StorageProvider.read(StorageKey.showBanner);
    if (statusBanner == 'true') {
      showBanner.value = false;
    } else {
      Timer(const Duration(seconds: 5), () {
        showBanner.value = true;
        StorageProvider.write(StorageKey.showBanner, 'true');
      });
    }
  }

  void refreshData() async {
    await getFoto();
  }

  Future pickImage() async {
    try {
      // print('test'); // Hapus atau komentari ini untuk debugging yang lebih bersih
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      imagePost.value = File(image.path); // Langsung tetapkan ke .value
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
      // Pertimbangkan untuk menampilkan pesan kesalahan ke pengguna, misalnya dengan Get.snackbar
      Get.snackbar('Error', 'Failed to pick image: ${e.message}',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getFoto();
    getAlbumDropdown();
  }

  @override
  void onClose() {
    super.onClose();
    animationController.dispose();
    searchController.dispose();
    descriptionController.dispose();
    komentarController.dispose();
    imagePost.value = null;
  }

  void getAlbumDropdown({Map<dynamic, dynamic>? filter}) {
    ApiDropdownData(endpoint: Endpoint.album, filter: filter)
        .getDropdownData()
        .then((data) {
      listAlbum.value.addAll(data);
      listAlbum.refresh();
    });
  }

  void updateLike(int index) {
    fotos[index].like = !fotos[index].like!;
    if (fotos[index].like!) {
      fotos[index].likeCount = fotos[index].likeCount! + 1;
    } else {
      fotos[index].likeCount = fotos[index].likeCount! - 1;
    }
    fotos.refresh();
    likePost(fotos[index].id);
    _likeController.refreshData();
  }

  void addFotoToAlbum(DataFoto item) {
    DataFoto fotoData = fotos.firstWhere((element) => element.id == item.id);

    // Hanya perbarui albumId dan album
    fotoData.albumId = item.albumId; // Asumsi 'item' juga memiliki albumId baru
    fotoData.album = item.album; // Asumsi 'item' juga memiliki album baru

    fotos.refresh();
  }

  likePost(fotoId) async {
    try {
      final response = await ApiProvider.instance().post(
        Endpoint.like,
        data: {
          "foto_id": fotoId,
          "user_id": int.tryParse(StorageProvider.read(StorageKey.idUser))
        },
      );
      if (response.statusCode == 200) {
        print(response.data);
      }
    } catch (e) {
      print(e);
    }
  }

  deletePost(DataFoto foto) async {
    try {
      fotos.remove(foto);
      fotos.refresh();
      final response = await ApiProvider.instance().delete(
        Endpoint.foto + '/${foto.id.toString()}',
      );
      if (response.statusCode == 200) {
        print(response.data);
      }
    } catch (e) {
      print(e);
    }
  }

  deleteKomentar(DataKomentar komentar) async {
    try {
      komentars.remove(komentar);
      komentars.refresh();
      final index =
          fotos.indexWhere((element) => element.id == komentar.fotoId);

      if (index != -1) {
        // Periksa apakah elemen ditemukan
        if (fotos[index].komentarCount != 0) {
          fotos[index].komentarCount = fotos[index].komentarCount! - 1;
        } else {
          fotos[index].komentarCount = 0;
        }

        fotos.refresh();
      } else {
        // Tangani kasus di mana elemen dengan fotoId tidak ditemukan
        print('Foto dengan ID ${komentar.fotoId} tidak ditemukan.');
      }
      showEditDeleteKomentar(0);
      final response = await ApiProvider.instance().delete(
        Endpoint.komentar + '/${komentar.id.toString()}',
      );
      if (response.statusCode == 200) {
        print(response.data);
      }
    } catch (e) {
      print(e);
    }
  }

  contentPost() async {
    loadingPost(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        var formData = dio.FormData.fromMap({
          "user_id": int.tryParse(StorageProvider.read(StorageKey.idUser)),
          "album_id": null,
          "deskripsi_foto": descriptionController.text,
          'foto': await dio.MultipartFile.fromFile(imagePost.value?.path ?? '',
              filename: "image.png"),
        });
        final response = await ApiProvider.instance().post(
          Endpoint.foto,
          data: formData,
          options: dio.Options(
            headers: {
              "Content-Type": "multipart/form-data",
            },
          ),
        );
        if (response.statusCode == 200) {
          ResponseFoto<DataFoto> responseFoto =
              ResponseFoto.fromJson(response.data);

          addFoto(responseFoto.data as DataFoto);
          clearForm();
          showAwesomeMaterialBanner(
            "Berhasil Menambahkan Postingan",
            "Postingan Berhasil Ditambahkan",
            ContentType.success,
            kGreen,
            Get.context!,
          );
        } else {
          CustomToast.ShowToast(
              'Sorry, Terjadi Kesalahan Internet', kRed, Colors.white);
        }
      }
    } on dio.DioException catch (e) {
      if (e.response != null) {
        ResponseFoto responseFoto = ResponseFoto.fromJson(e.response?.data);
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
      loadingPost(false);
    }
  }

  albumPost(DataFoto foto) async {
    loadingAlbumPost(true);
    try {
      var formData = {
        "foto_id": foto.id,
        "album_id": int.tryParse(selectedAlbumForm?.value['id'] ?? ''),
      };
      final response = await ApiProvider.instance().get(
        Endpoint.foto + '/add/album',
        queryParameters: formData,
        options: dio.Options(
          headers: {
            "Content-Type": "multipart/form-data",
          },
        ),
      );
      if (response.statusCode == 200) {
        ResponseFoto<DataFoto> responseFoto =
            ResponseFoto.fromJson(response.data);

        addFotoToAlbum(responseFoto.data as DataFoto);
        clearForm();
        showAwesomeMaterialBanner(
          "Berhasil Menambahkan Postingan",
          "Postingan Berhasil Ditambahkan",
          ContentType.success,
          kGreen,
          Get.context!,
        );
        Get.back();
      } else {
        CustomToast.ShowToast(
            'Sorry, Terjadi Kesalahan Internet', kRed, Colors.white);
      }
    } on dio.DioException catch (e) {
      if (e.response != null) {
        ResponseFoto responseFoto = ResponseFoto.fromJson(e.response?.data);
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
      loadingAlbumPost(false);
    }
  }

  addKomentarPost(fotoId) async {
    loadingPostKomentar(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKeyKomentar.currentState?.save();
      if (formKeyKomentar.currentState!.validate()) {
        var formData = dio.FormData.fromMap({
          "user_id": int.tryParse(StorageProvider.read(StorageKey.idUser)),
          "foto_id": fotoId,
          "komentar": komentarController.text,
        });
        final response = await ApiProvider.instance().post(
          Endpoint.komentar,
          data: formData,
          options: dio.Options(
            headers: {
              "Content-Type": "multipart/form-data",
            },
          ),
        );
        if (response.statusCode == 200) {
          ResponseKomentar<DataKomentar> responseFoto =
              ResponseKomentar.fromJson(response.data);
          final index = fotos.indexWhere((element) => element.id == fotoId);

          if (index != -1) {
            // Periksa apakah elemen ditemukan
            if (fotos[index].komentarCount != 0) {
              fotos[index].komentarCount = fotos[index].komentarCount! + 1;
            } else {
              fotos[index].komentarCount = 1;
            }

            fotos.refresh();
          } else {
            // Tangani kasus di mana elemen dengan fotoId tidak ditemukan
            print('Foto dengan ID $fotoId tidak ditemukan.');
          }
          addKomentar(responseFoto.data as DataKomentar);
          komentarController.clear();
          CustomToast.ShowToast(
              'Berhasil menambahkan komentar', kGreen, Colors.white);
        } else {
          CustomToast.ShowToast(
              'Sorry, Terjadi Kesalahan Internet', kRed, Colors.white);
        }
      }
    } on dio.DioException catch (e) {
      if (e.response != null) {
        ResponseFoto responseFoto = ResponseFoto.fromJson(e.response?.data);
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
      loadingPostKomentar(false);
    }
  }

  Future<void> getFoto() async {
    isLoading(true);
    change(null, status: RxStatus.loading());
    try {
      final response = await ApiProvider.instance().get(
        Endpoint.foto,
        options: dio.Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
        ),
      );

      if (response.statusCode == 200) {
        final ResponseFoto<List<DataFoto>> responseSubKelas =
            ResponseFoto.fromJson(response.data);

        if (responseSubKelas.data!.isEmpty) {
          fotos.value = [];

          change(null, status: RxStatus.empty());
        } else {
          fotos.value = responseSubKelas.data ?? [];
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

  Future<void> getKomentar(fotoId) async {
    isLoadingKomentar(true);
    change(null, status: RxStatus.loading());
    try {
      final response = await ApiProvider.instance().get(
        Endpoint.komentar + '/foto/${fotoId}',
        options: dio.Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
        ),
      );

      if (response.statusCode == 200) {
        final ResponseKomentar<List<DataKomentar>> responseKomentar =
            ResponseKomentar.fromJson(response.data);

        if (responseKomentar.data!.isEmpty) {
          komentars.value = [];

          change(null, status: RxStatus.empty());
        } else {
          komentars.value = responseKomentar.data ?? [];
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
      isLoadingKomentar(false);
    }
  }

  void clearForm() {
    descriptionController.clear();
    imagePost.value = null;
  }

  bool addFoto(DataFoto item) {
    var newSubkelas = item;
    fotos.add(newSubkelas);
    fotos.refresh();
    return true;
  }

  bool addKomentar(DataKomentar item) {
    var newKomentar = item;
    komentars.add(newKomentar);
    komentars.refresh();
    return true;
  }

  void showBottomDialogComentar(BuildContext context, fotoId) {
    if (showKomentar.value) {
      return;
    }
    showKomentar.value = true;

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (BuildContext context) {
        return Obx(
          () => Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: FractionallySizedBox(
              heightFactor: 0.9,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Expanded(
                      child: isLoadingKomentar.value == true
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : komentars.isEmpty
                              ? const Center(
                                  child: Text('Belum ada komentar'),
                                )
                              : ListView.builder(
                                  itemCount: komentars.length,
                                  itemBuilder: (context, index) {
                                    return Obx(
                                      () => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const CircleAvatar(),
                                                    SizedBox(
                                                      width: 6.w,
                                                    ),
                                                    Text(
                                                      komentars[index]
                                                              .user
                                                              ?.username ??
                                                          '',
                                                      style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontFamily: GoogleFonts
                                                                .montserrat()
                                                            .fontFamily,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    (komentars[index].author ??
                                                            false)
                                                        ? IconButton(
                                                            onPressed: () {
                                                              if (showEditDeleteKomentar
                                                                      .value ==
                                                                  index + 1) {
                                                                showEditDeleteKomentar
                                                                    .value = 0;
                                                              } else {
                                                                showEditDeleteKomentar
                                                                        .value =
                                                                    index + 1;
                                                              }
                                                            },
                                                            icon: const Icon(
                                                                Icons
                                                                    .more_vert),
                                                          )
                                                        : const SizedBox()
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 4.h,
                                                ),
                                                Text(
                                                  komentars[index].komentar ??
                                                      '',
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontFamily: GoogleFonts
                                                              .montserrat()
                                                          .fontFamily),
                                                ),
                                                SizedBox(
                                                  height: 6.h,
                                                ),
                                              ],
                                            ),
                                            if (showEditDeleteKomentar.value ==
                                                index + 1)
                                              Positioned(
                                                top: 6.h,
                                                right: 38.w,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      color: kWhite,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.r),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          color: kGrayLight,
                                                          blurRadius: 5,
                                                        ),
                                                      ]),
                                                  child: InkWell(
                                                    onTap: () => deleteKomentar(
                                                        komentars[index]),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
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
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                    ),
                    Form(
                      key: formKeyKomentar,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: komentarController,
                                  validator: (value) => value!.isEmpty
                                      ? 'Tolong masukan komentar'
                                      : null,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Tulis komentar...',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: loadingPostKomentar.value == true
                                ? const CircularProgressIndicator()
                                : const Icon(Icons.send),
                            onPressed: () {
                              if (formKeyKomentar.currentState!.validate()) {
                                addKomentarPost(fotoId);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ).then((value) {
      showKomentar.value = false;
      showEditDeleteKomentar(0);
    });
  }

  Future<bool> dialogAlbum({bool isUpdate = false, DataFoto? foto}) async {
    return await showDialog<bool>(
          context: Get.context!,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Text(
                isUpdate ? 'Ubah Album' : 'Add Album',
                style: GoogleFonts.poppins(
                    fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              content: Obx(
                () => SingleChildScrollView(
                  child: SizedBox(
                    width: MediaQuery.of(Get.context!).size.width,
                    child: ListBody(
                      children: <Widget>[
                        SizedBox(height: 20.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pilih Album',
                              style: GoogleFonts.poppins(fontSize: 14.sp),
                            ),
                            const SizedBox(height: 8),
                            CustomDropdown(
                              prefixicon: const Icon(
                                Icons.gif_box_rounded,
                                color: kPrimary,
                              ).paddingAll(10),
                              hint: 'Jenis Album',
                              items: listAlbum,
                              itemLabel: (value) => value?['name'],
                              onChanged: (value) {
                                selectedAlbumForm?.value = value ?? {};
                              },
                              initialValue:
                                  !(selectedAlbumForm?.isEmpty ?? true)
                                      ? selectedAlbumForm?.value
                                      : null,
                              borderColor: Colors.blue,
                              isBorder: true,
                              validators: [
                                (value) => DropdownFormValidations.required(
                                    value,
                                    fieldName: 'Jenis Album'),
                                (value) => DropdownFormValidations.isValidItem(
                                    value, listAlbum,
                                    message: 'Pilihan jenis album tidak valid'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
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
                              await albumPost(foto!);
                            },
                            childWidget: loadingAlbumPost.value
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
