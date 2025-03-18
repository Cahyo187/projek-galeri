// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:ruangpustaka/app/data/model/book/response_all_book.dart';
//
// import '../../style/app_colors.dart';
// import '../../style/app_textsizes.dart';
//
// class GridVieBukuItem extends StatelessWidget {
//   final controller;
//   final ResponseAllBook bukuList;
//   final VoidCallback onTap;
//   final EdgeInsets padding;
//
//   const GridVieBukuItem({
//     super.key,
//     required this.controller,
//     required this.bukuList,
//     required this.onTap,
//     required this.padding,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//
//       },
//       child: Padding(
//         padding: padding,
//         child: Container(
//           decoration: BoxDecoration(
//             color: AppColors.whiteColor,
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(
//                 color: AppColors.greyColor.withOpacity(0.40),
//                 width: 0.3
//             ),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//
//               Container(
//                 width: double.infinity,
//                 height: 225,
//                 decoration: BoxDecoration(
//                   borderRadius: const BorderRadius.only(
//                     topRight: Radius.circular(10),
//                     topLeft: Radius.circular(10),
//                   ),
//                   color: AppColors.backgroundOnboarding.withOpacity(0.25),
//                 ),
//                 child: Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(15),
//                     child: Stack(
//                       children: [
//                         ClipRRect(
//                           borderRadius: const BorderRadius.all(Radius.circular(10)),
//                           child: AspectRatio(
//                             aspectRatio: 6 / 8,
//                             child: Image.network(
//                               bukuList.coverBuku.toString(),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//
//                         bukuList.status == 'Popular' ?
//                         Positioned(
//                           top: 0,
//                           left: 0,
//                           right: 20,
//                           child: Container(
//                             width: 115,
//                             height: 30,
//                             decoration: const BoxDecoration(
//                               color: AppColors.secondaryColor,
//                               borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(12),
//                                 bottomRight: Radius.circular(12),
//                                 bottomLeft: Radius.circular(0),
//                                 topRight: Radius.circular(12),
//                               ),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   const Icon(
//                                     Iconsax.chart,
//                                     color: Colors.white,
//                                     size: 16,
//                                   ),
//                                   const SizedBox(width: 4),
//                                   Text(
//                                     'Popular',
//                                     style: GoogleFonts.montserrat(
//                                       letterSpacing: -0.3,
//                                       fontWeight: FontWeight.w600,
//                                       color: AppColors.whiteColor,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ) : const SizedBox(),
//
//                         Positioned(
//                           bottom: 0,
//                           left: 0,
//                           right: 0,
//                           child: Container(
//                             width: 115,
//                             height: 30,
//                             decoration: const BoxDecoration(
//                               color: AppColors.backgroundWhite,
//                               borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(12),
//                                 bottomLeft: Radius.circular(0),
//                                 topRight: Radius.circular(12),
//                               ),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   const Icon(
//                                     Iconsax.tick_square,
//                                     color: AppColors.primaryColor,
//                                     size: 16,
//                                   ),
//                                   const SizedBox(width: 4),
//                                   Text(
//                                     bukuList.jenisBuku.toString(),
//                                     style: GoogleFonts.montserrat(
//                                       letterSpacing: -0.3,
//                                       fontWeight: FontWeight.w600,
//                                       color: AppColors.blackColor,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//
//               const SizedBox(
//                 height: 10,
//               ),
//
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       bukuList.judul.toString(),
//                       style: GoogleFonts.montserrat(
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.colorDark,
//                         letterSpacing: -0.3,
//                         fontSize: AppTextSizes.caption,
//                       ),
//                       textAlign: TextAlign.start,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//
//                     const SizedBox(
//                       height: 5,
//                     ),
//
//                     Text(
//                       bukuList.penulis.toString(),
//                       style: GoogleFonts.montserrat(
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.greyColor,
//                         letterSpacing: -0.3,
//                         fontSize: AppTextSizes.small,
//                       ),
//                       textAlign: TextAlign.start,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//
//                     const SizedBox(
//                       height: 5,
//                     ),
//
//                     bukuList.stokBuku == null ? const SizedBox() : Text(
//                       'Tersedia : ${bukuList.stokBuku.toString()}',
//                       style: GoogleFonts.montserrat(
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.greyColor,
//                         letterSpacing: -0.3,
//                         fontSize: AppTextSizes.small,
//                       ),
//                       textAlign: TextAlign.start,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//
//                     Padding(
//                       padding: const EdgeInsets.only(top: 5),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Expanded(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 bukuList.rating != null && bukuList.rating! > 0 ?
//                                 RatingBarIndicator(
//                                   rating: bukuList.rating!,
//                                   itemCount: 5,
//                                   direction: Axis.horizontal,
//                                   itemSize: 15,
//                                   itemBuilder: (context, _) =>
//                                   const Icon(
//                                     Icons.star,
//                                     color: Colors.amber,
//                                   ),
//                                 ) :
//                                 RatingBarIndicator(
//                                   rating: 5,
//                                   itemCount: 5,
//                                   direction: Axis.horizontal,
//                                   itemSize: 15,
//                                   itemBuilder: (context, _) => Icon(
//                                     Icons.star,
//                                     color: AppColors.greyColor
//                                         .withOpacity(0.3),
//                                   ),
//                                 ),
//
//                                 const SizedBox(
//                                   width: 5,
//                                 ),
//
//                                 Text(
//                                   '(${bukuList.totalUlasan.toString()})',
//                                   style: GoogleFonts.montserrat(
//                                     fontWeight: FontWeight.w600,
//                                     color: AppColors.greyColor,
//                                     letterSpacing: -0.3,
//                                     fontSize: AppTextSizes.caption,
//                                   ),
//                                   textAlign: TextAlign.start,
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ],
//                             ),
//                           ),
//
//                           const SizedBox(
//                             width: 5,
//                           ),
//
//                           Text(
//                             '•••',
//                             style: GoogleFonts.montserrat(
//                               fontWeight: FontWeight.w600,
//                               color: AppColors.greyColor,
//                               letterSpacing: -0.3,
//                               fontSize: AppTextSizes.caption,
//                             ),
//                             textAlign: TextAlign.start,
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
