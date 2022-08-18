// import 'package:auto_car/model/brand_model.dart';
// import 'package:flutter/material.dart';

// class ListBrandTextWidget extends StatefulWidget {
//   const ListBrandTextWidget({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<ListBrandTextWidget> createState() => _ListBrandTextWidgetState();
// }

// class _ListBrandTextWidgetState extends State<ListBrandTextWidget> {
//   int expandedIndex = -1;
//   @override
//   Widget build(BuildContext context) {
//     List<BrandsModel> listBrand = [
//       // BrandModel(AppConfig.recentlyArrived, AppConfig.recentlyArrived),
//       // BrandModel("سيدان", "سيدان"),
//       // BrandModel("تويوتا", "تويوتا"),
//       // BrandModel("فورد", "فورد"),
//       // BrandModel("نيسان", "نيسان"),
//       // BrandModel("سيدان", "سيدان"),
//       // BrandModel("تويوتا", "تويوتا"),
//       // BrandModel("فورد", "فورد"),
//       // BrandModel("نيسان", "نيسان"),
//     ];
//     return Column(
//       children: [
//         const SizedBox(
//           height: 30,
//         ),
//         SizedBox(
//           height: 38,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: Expanded(
//                   child: ListView.separated(
//                     separatorBuilder: (context, index) =>
//                         const SizedBox(width: 10),
//                     scrollDirection: Axis.horizontal,
//                     itemCount: listBrand.length,
//                     itemBuilder: (context, index) {
//                       String logo = listBrand[index].logo;
//                       String title = listBrand[index].name;
//                       return GestureDetector(
//                         onTap: (() {
//                           setState(
//                             () {
//                               expandedIndex = index;
//                             },
//                           );
//                         }),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: expandedIndex == index
//                                 ? Colors.black
//                                 : Colors.white,
//                             border: Border.all(width: .5, color: Colors.black),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Center(
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 8),
//                               child: Text(
//                                 title,
//                                 style: TextStyle(
//                                   color: expandedIndex == index
//                                       ? Colors.white
//                                       : Colors.black,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 width: 5,
//               ),
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }
