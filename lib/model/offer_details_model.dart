// To parse this JSON data, do
//
//     final offerDetailsModel = offerDetailsModelFromJson(jsonString);
/*
import 'dart:convert';

OfferDetailsModel offerDetailsModelFromJson(String str) =>
    OfferDetailsModel.fromJson(json.decode(str));

String offerDetailsModelToJson(OfferDetailsModel data) =>
    json.encode(data.toJson());

class OfferDetailsModel {
  OfferDetailsModel({
    required this.id,
    required this.description,
    required this.brandModel,
    required this.year,
    required this.seats,
    required this.kilometer,
    required this.price,
    required this.currency,
    required this.isActive,
    required this.imageGallaries,
    required this.featuresTypes,
    required this.ytLink,
  });

  String id;
  String description;
  BrandModel brandModel;
  Year year;
  int seats;
  String kilometer;
  double price;
  Currency currency;
  bool isActive;
  List<ImageGallary> imageGallaries;
  List<FeaturesType> featuresTypes;
  dynamic ytLink;

  factory OfferDetailsModel.fromJson(Map<String, dynamic> json) =>
      OfferDetailsModel(
        id: json["id"] ?? '',
        description: json["description"] ?? '',
        brandModel: BrandModel.fromJson(json["brandModel"]),
        year: Year.fromJson(json["year"]),
        seats: json["seats"] ?? 0,
        kilometer: json["kilometer"] ?? '',
        price: json["price"] ?? 0.0,
        currency: Currency.fromJson(json["currency"]),
        isActive: json["isActive"] ?? false,
        imageGallaries: List<ImageGallary>.from(
            json["imageGallaries"].map((x) => ImageGallary.fromJson(x))),
        featuresTypes: List<FeaturesType>.from(
            json["featuresTypes"].map((x) => FeaturesType.fromJson(x))),
        ytLink: json["ytLink"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "brandModel": brandModel.toJson(),
        "year": year.toJson(),
        "seats": seats,
        "kilometer": kilometer,
        "price": price,
        "currency": currency.toJson(),
        "isActive": isActive,
        "imageGallaries":
            List<dynamic>.from(imageGallaries.map((x) => x.toJson())),
        "featuresTypes":
            List<dynamic>.from(featuresTypes.map((x) => x.toJson())),
        "ytLink": ytLink,
      };
}

class BrandModel {
  BrandModel({
    required this.id,
    required this.modelName,
    required this.modelNameAr,
    required this.brand,
  });

  String id;
  String modelName;
  dynamic modelNameAr;
  Brand brand;

  factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
        id: json["id"] ?? '',
        modelName: json["modelName"] ?? '',
        modelNameAr: json["modelNameAr"] ?? '',
        brand: Brand.fromJson(json["brand"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "modelName": modelName,
        "modelNameAr": modelNameAr,
        "brand": brand.toJson(),
      };
}

class Brand {
  Brand({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.logoPath,
  });

  String id;
  String name;
  String nameAr;
  String logoPath;

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
        nameAr: json["nameAr"] ?? '',
        logoPath: json["logoPath"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "nameAr": nameAr,
        "logoPath": logoPath,
      };
}

class Currency {
  Currency({
    required this.id,
    required this.currencyName,
    required this.currencyNameAr,
  });

  String id;
  String currencyName;
  dynamic currencyNameAr;

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        id: json["id"] ?? '',
        currencyName: json["currencyName"] ?? '',
        currencyNameAr: json["currencyNameAr"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "currencyName": currencyName,
        "currencyNameAr": currencyNameAr,
      };
}

class FeaturesType {
  FeaturesType({
    required this.id,
    required this.typeName,
    required this.typeNameAr,
    required this.features,
  });

  String id;
  String typeName;
  dynamic typeNameAr;
  List<Feature> features;

  factory FeaturesType.fromJson(Map<String, dynamic> json) => FeaturesType(
        id: json["id"],
        typeName: json["typeName"],
        typeNameAr: json["typeNameAr"],
        features: List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "typeName": typeName,
        "typeNameAr": typeNameAr,
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
      };
}

class Feature {
  Feature({
    required this.id,
    required this.featureName,
    required this.featureNameAr,
    required this.featuresType,
  });

  String id;
  String featureName;
  dynamic featureNameAr;
  dynamic featuresType;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"] ?? '',
        featureName: json["featureName"] ?? '',
        featureNameAr: json["featureNameAr"] ?? '',
        featuresType: json["featuresType"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "featureName": featureName,
        "featureNameAr": featureNameAr,
        "featuresType": featuresType,
      };
}

class ImageGallary {
  ImageGallary({
    required this.id,
    required this.filePath,
    required this.orderNo,
  });

  String id;
  String filePath;
  int orderNo;

  factory ImageGallary.fromJson(Map<String, dynamic> json) => ImageGallary(
        id: json["id"] ?? '',
        filePath: json["filePath"] ?? '',
        orderNo: json["orderNo"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "filePath": filePath,
        "orderNo": orderNo,
      };
}

class Year {
  Year({
    required this.id,
    required this.yearName,
  });

  String id;
  int yearName;

  factory Year.fromJson(Map<String, dynamic> json) => Year(
        id: json["id"] ?? '',
        yearName: json["yearName"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "yearName": yearName,
      };
}

class OfferModel {
  String id;
  String description;
  int seats;
  String kilometer;
  double price;
  String modelName;

  OfferModel({
    required this.id,
    required this.description,
    required this.kilometer,
    required this.price,
    required this.seats,
    required this.modelName,
  });
}
*/

// To parse this JSON data, do
//
//     final offerDetailModel = offerDetailModelFromJson(jsonString);

import 'dart:convert';

OfferDetailModel offerDetailModelFromJson(String str) =>
    OfferDetailModel.fromJson(json.decode(str));

String offerDetailModelToJson(OfferDetailModel data) =>
    json.encode(data.toJson());

class OfferDetailModel {
  OfferDetailModel({
    required this.id,
    required this.description,
    required this.brandModel,
    required this.year,
    required this.seats,
    required this.kilometer,
    required this.price,
    required this.currency,
    required this.isActive,
    required this.imageGallaries,
    required this.featuresTypes,
    required this.ytLink,
  });

  String id;
  String description;
  BrandModel brandModel;
  Year year;
  int seats;
  String kilometer;
  double price;
  Currency currency;
  bool isActive;
  List<ImageGallary> imageGallaries;
  List<FeaturesType> featuresTypes;
  String ytLink;

  factory OfferDetailModel.fromJson(Map<String, dynamic> json) =>
      OfferDetailModel(
        id: json["id"] ?? '',
        description: json["description"] ?? '',
        brandModel: BrandModel.fromJson(json["brandModel"]),
        year: Year.fromJson(json["year"]),
        seats: json["seats"] ?? 0,
        kilometer: json["kilometer"] ?? '',
        price: json["price"] ?? 0.0,
        currency: Currency.fromJson(json["currency"]),
        isActive: json["isActive"] ?? false,
        imageGallaries: List<ImageGallary>.from(
            json["imageGallaries"].map((x) => ImageGallary.fromJson(x))),
        featuresTypes: List<FeaturesType>.from(
            json["featuresTypes"].map((x) => FeaturesType.fromJson(x))),
        ytLink: json["ytLink"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "brandModel": brandModel.toJson(),
        "year": year.toJson(),
        "seats": seats,
        "kilometer": kilometer,
        "price": price,
        "currency": currency.toJson(),
        "isActive": isActive,
        "imageGallaries":
            List<dynamic>.from(imageGallaries.map((x) => x.toJson())),
        "featuresTypes":
            List<dynamic>.from(featuresTypes.map((x) => x.toJson())),
        "ytLink": ytLink,
      };
}

class BrandModel {
  BrandModel({
    required this.id,
    required this.modelName,
    required this.modelNameAr,
    required this.brand,
  });

  String id;
  String modelName;
  String modelNameAr;
  Brand brand;

  factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
        id: json["id"] ?? '',
        modelName: json["modelName"] ?? '',
        modelNameAr: json["modelNameAr"] ?? '',
        brand: Brand.fromJson(
          json["brand"],
        ),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "modelName": modelName,
        "modelNameAr": modelNameAr,
        "brand": brand.toJson(),
      };
}

class Brand {
  Brand({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.logoPath,
  });

  String id;
  String name;
  String nameAr;
  String logoPath;

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
        nameAr: json["nameAr"] ?? '',
        logoPath: json["logoPath"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "nameAr": nameAr,
        "logoPath": logoPath,
      };
}

class Currency {
  Currency({
    required this.id,
    required this.currencyName,
    required this.currencyNameAr,
  });

  String id;
  String currencyName;
  String currencyNameAr;

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        id: json["id"] ?? '',
        currencyName: json["currencyName"] ?? '',
        currencyNameAr: json["currencyNameAr"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "currencyName": currencyName,
        "currencyNameAr": currencyNameAr,
      };
}

class FeaturesType {
  FeaturesType({
    required this.id,
    required this.typeName,
    required this.typeNameAr,
    required this.features,
  });

  String id;
  String typeName;
  String typeNameAr;
  List<Feature> features;

  factory FeaturesType.fromJson(Map<String, dynamic> json) => FeaturesType(
        id: json["id"] ?? '',
        typeName: json["typeName"] ?? '',
        typeNameAr: json["typeNameAr"] ?? '',
        features: List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "typeName": typeName,
        "typeNameAr": typeNameAr,
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
      };
}

class Feature {
  Feature({
    required this.id,
    required this.featureName,
    required this.featureNameAr,
    required this.featuresType,
  });

  String id;
  String featureName;
  String featureNameAr;
  String featuresType;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"] ?? '',
        featureName: json["featureName"] ?? '',
        featureNameAr: json["featureNameAr"] ?? '',
        featuresType: json["featuresType"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "featureName": featureName,
        "featureNameAr": featureNameAr,
        "featuresType": featuresType,
      };
}

class ImageGallary {
  ImageGallary({
    required this.id,
    required this.filePath,
    required this.orderNo,
  });

  String id;
  String filePath;
  int orderNo;

  factory ImageGallary.fromJson(Map<String, dynamic> json) => ImageGallary(
        id: json["id"] ?? '',
        filePath: json["filePath"] ?? '',
        orderNo: json["orderNo"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "filePath": filePath,
        "orderNo": orderNo,
      };
}

class Year {
  Year({
    required this.id,
    required this.yearName,
  });

  String id;
  int yearName;

  factory Year.fromJson(Map<String, dynamic> json) => Year(
        id: json["id"] ?? '',
        yearName: json["yearName"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "yearName": yearName,
      };
}

class OfferModel {
  String id;
  String description;
  int seats;
  String kilometer;
  double price;
  String modelName;

  OfferModel({
    required this.id,
    required this.description,
    required this.kilometer,
    required this.price,
    required this.seats,
    required this.modelName,
  });
}
