// To parse this JSON data, do
//
//     final carModel = carModelFromJson(jsonString);

import 'dart:convert';

CarModel carModelFromJson(String str) => CarModel.fromJson(json.decode(str));

String carModelToJson(CarModel data) => json.encode(data.toJson());

class CarModel {
  CarModel({
    required this.data,
    required this.pageNumber,
    required this.pageSize,
    required this.firstPage,
    required this.lastPage,
    required this.totalPages,
    required this.totalRecords,
    required this.nextPage,
    required this.previousPage,
  });

  List<Datum> data;
  int pageNumber;
  int pageSize;
  String firstPage;
  String lastPage;
  int totalPages;
  int totalRecords;
  String nextPage;
  String previousPage;

  factory CarModel.fromJson(Map<String, dynamic> json) => CarModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        pageNumber: json["pageNumber"] ?? 0,
        pageSize: json["pageSize"] ?? 0,
        firstPage: json["firstPage"] ?? '',
        lastPage: json["lastPage"] ?? '',
        totalPages: json["totalPages"] ?? 0,
        totalRecords: json["totalRecords"] ?? 0,
        nextPage: json["nextPage"] ?? '',
        previousPage: json["previousPage"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "firstPage": firstPage,
        "lastPage": lastPage,
        "totalPages": totalPages,
        "totalRecords": totalRecords,
        "nextPage": nextPage,
        "previousPage": previousPage,
      };
}

class Datum {
  Datum({
    required this.id,
    required this.description,
    required this.brandModel,
    required this.year,
    required this.seats,
    required this.kilometer,
    required this.price,
    required this.currency,
    required this.isActive,
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
  String ytLink;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? '',
        description: json["description"] ?? '',
        brandModel: BrandModel.fromJson(json["brandModel"]),
        year: Year.fromJson(json["year"]),
        seats: json["seats"] ?? 0,
        kilometer: json["kilometer"] ?? '',
        price: json["price"] ?? 0.0,
        currency: Currency.fromJson(json["currency"]),
        isActive: json["isActive"] ?? false,
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
  String brand;

  factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
        id: json["id"] ?? '',
        modelName: json["modelName"] ?? '',
        modelNameAr: json["modelNameAr"] ?? '',
        brand: json["brand"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "modelName": modelName,
        "modelNameAr": modelNameAr,
        "brand": brand,
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

class Year {
  Year({
    required this.id,
    required this.yearName,
  });

  String id;
  int yearName;

  factory Year.fromJson(Map<String, dynamic> json) => Year(
        id: json["id"] ?? '',
        yearName: json["yearName"] ?? 2022,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "yearName": yearName,
      };
}


/* 
import 'dart:convert';

CarModel carModelFromJson(String str) => CarModel.fromJson(json.decode(str));

String carModelToJson(CarModel data) => json.encode(data.toJson());

class CarModel {
  CarModel({
    required this.data,
    required this.pageNumber,
    required this.pageSize,
    required this.firstPage,
    required this.lastPage,
    required this.totalPages,
    required this.totalRecords,
    required this.nextPage,
    required this.previousPage,
  });

  List<Datum> data;
  int pageNumber;
  int pageSize;
  String firstPage;
  String lastPage;
  int totalPages;
  int totalRecords;
  String nextPage;
  dynamic previousPage;

  factory CarModel.fromJson(Map<String, dynamic> json) => CarModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        pageNumber: json["pageNumber"] ?? 0,
        pageSize: json["pageSize"] ?? 0,
        firstPage: json["firstPage"] ?? '',
        lastPage: json["lastPage"] ?? '',
        totalPages: json["totalPages"] ?? 0,
        totalRecords: json["totalRecords"] ?? 0,
        nextPage: json["nextPage"] ?? '',
        previousPage: json["previousPage"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "firstPage": firstPage,
        "lastPage": lastPage,
        "totalPages": totalPages,
        "totalRecords": totalRecords,
        "nextPage": nextPage,
        "previousPage": previousPage,
      };
}

class Datum {
  Datum({
    required this.id,
    required this.description,
    required this.brandModel,
    required this.year,
    required this.seats,
    required this.kilometer,
    required this.price,
    required this.currency,
    required this.isActive,
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
  dynamic ytLink;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? '',
        description: json["description"] ?? '',
        brandModel: BrandModel.fromJson(json["brandModel"]),
        year: Year.fromJson(json["year"]),
        seats: json["seats"] ?? 0,
        kilometer: json["kilometer"] ?? '',
        price: json["price"] ?? 0.0,
        currency: Currency.fromJson(json["currency"]),
        isActive: json["isActive"] ?? false,
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
        id: json["id"],
        currencyName: json["currencyName"] ?? '',
        currencyNameAr: json["currencyNameAr"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "currencyName": currencyName,
        "currencyNameAr": currencyNameAr,
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
        id: json["id"],
        yearName: json["yearName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "yearName": yearName,
      };
}
*/