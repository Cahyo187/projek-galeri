import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:vnica_app/app/widgets/menu/widget_albumdetail.dart';

import '../controllers/album_detail_controller.dart';

class AlbumDetailView extends GetView<AlbumDetailController> {
  const AlbumDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(controller.namaAlbum ?? ''),
          centerTitle: true,
        ),
        body: WidgetBuildAlbumDetail());
  }
}
