import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vnica_app/app/components/content/custom_toast.dart';
import 'package:vnica_app/app/constants/constants.dart';
import 'package:vnica_app/app/constants/endpoint.dart';
import 'package:vnica_app/app/data/models/foto/response_foto.dart';
import 'package:vnica_app/app/data/models/komentar/response_komentar.dart';
import 'package:vnica_app/app/data/provider/api_provider.dart';
import 'package:vnica_app/app/data/provider/storage_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dio/dio.dart' as dio;
import 'package:vnica_app/app/routes/app_pages.dart';

class LikeController extends GetxController with StateMixin<List<DataFoto>> {
  final isDeskripsiValid = true.obs;
  RxList<DataKomentar> komentars = <DataKomentar>[].obs;
  RxList<DataFoto> fotos = <DataFoto>[].obs;
  final isLoading = false.obs;
  final isLoadingKomentar = false.obs;
  final loadingPostKomentar = false.obs;
  final showKomentar = false.obs;

  final loadingPost = false.obs;
  final GlobalKey<FormState> formKeyKomentar = GlobalKey<FormState>();
  final TextEditingController searchController = TextEditingController();
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

  void refreshData() async {
    await getFoto();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getFoto();
  }

  @override
  void onClose() {
    super.onClose();
    animationController.dispose();
    searchController.dispose();
    komentarController.dispose();
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
        queryParameters: {
          'like': 1,
        },
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
}
