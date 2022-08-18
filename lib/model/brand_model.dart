// class BrandsModel {
//   String title;
//   String image;

//   BrandsModel(this.title, this.image);
// }
// To parse this JSON data, do
//
//     final BrandsModel = BrandsModelFromJson(jsonString);

import 'dart:convert';

List<BrandsModel> brandsModelFromJson(String str) => List<BrandsModel>.from(
    json.decode(str).map((x) => BrandsModel.fromJson(x)));

String brandsModelToJson(List<BrandsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BrandsModel {
  BrandsModel({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.logo,
  });

  String id;
  String name;
  String nameAr;
  String logo;

  factory BrandsModel.fromJson(Map<String, dynamic> json) => BrandsModel(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
        nameAr: json["nameAr"] ?? '',
        logo: json["logoPath"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "nameAr": nameAr,
        "logoPath": logo,
      };
}
