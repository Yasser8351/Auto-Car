// // class CategoryModel {
// //   String title;
// //   String image;

// //   CategoryModel(this.title, this.image);
// // }
// // To parse this JSON data, do
// //
// //     final CategoryModel = CategoryModelFromJson(jsonString);

// import 'dart:convert';

// List<CategoryModel> categoryModelFromJson(String str) =>
//     List<CategoryModel>.from(
//         json.decode(str).map((x) => CategoryModel.fromJson(x)));

// String categoryModelToJson(List<CategoryModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class CategoryModel {
//   CategoryModel({
//     this.id,
//     this.title,
//     this.price,
//     this.description,
//     this.category,
//     this.image,
//     this.rating,
//   });

//   int? id;
//   String? title;
//   double? price;
//   String? description;
//   Category? category;
//   String? image;
//   Rating? rating;

//   factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
//         id: json["id"] ?? 0,
//         title: json["title"] ?? "",
//         price: json["price"].toDouble() ?? 0.0,
//         description: json["description"] ?? "",
//         category: categoryValues.map[json["category"]],
//         image: json["image"] ?? "",
//         rating: Rating.fromJson(json["rating"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "title": title,
//         "price": price,
//         "description": description,
//         "category": categoryValues.reverse[category],
//         "image": image,
//         "rating": rating!.toJson(),
//       };
// }

// enum Category { MEN_S_CLOTHING, JEWELERY, ELECTRONICS, WOMEN_S_CLOTHING }

// final categoryValues = EnumValues({
//   "electronics": Category.ELECTRONICS,
//   "jewelery": Category.JEWELERY,
//   "men's clothing": Category.MEN_S_CLOTHING,
//   "women's clothing": Category.WOMEN_S_CLOTHING
// });

// class Rating {
//   Rating({
//     this.rate,
//     this.count,
//   });

//   double? rate;
//   int? count;

//   factory Rating.fromJson(Map<String, dynamic> json) => Rating(
//         rate: json["rate"].toDouble() ?? 0.0,
//         count: json["count"] ?? 0,
//       );

//   Map<String, dynamic> toJson() => {
//         "rate": rate,
//         "count": count,
//       };
// }

// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap = {};

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap;
//     return reverseMap;
//   }
// }
// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);
// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

List<CategoryModel> categoryModelFromJson(String str) =>
    List<CategoryModel>.from(
        json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoryModelToJson(List<CategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel {
  CategoryModel({
    required this.id,
    required this.typeName,
    required this.typeNameAr,
    required this.imgPath,
  });

  String id;
  String typeName;
  dynamic typeNameAr;
  String imgPath;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        typeName: json["typeName"] ?? '',
        typeNameAr: json["typeNameAr"] ?? '',
        imgPath: json["imgPath"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "typeName": typeName,
        "typeNameAr": typeNameAr,
        "imgPath": imgPath,
      };
}
