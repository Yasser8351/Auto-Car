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
  int? pageNumber;
  int? pageSize;
  String? firstPage;
  String? lastPage;
  int totalPages;
  int totalRecords;
  dynamic? nextPage;
  dynamic? previousPage;

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
    required this.trim,
    required this.year,
    required this.colors,
    required this.cartype,
    required this.gearbox,
    required this.specs,
    required this.location,
    required this.seats,
    required this.kilometer,
    required this.price,
    required this.currency,
    required this.isActive,
    required this.imageGallaries,
    required this.features,
  });

  String id;
  String description;
  BrandModel brandModel;
  Trim trim;
  Year year;
  Colors colors;
  Cartype cartype;
  Gearbox gearbox;
  Specs specs;
  Location location;
  int seats;
  String kilometer;
  double price;
  Currency currency;
  bool isActive;
  List<ImageGallary> imageGallaries;
  dynamic features;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? '',
        description: json["description"] ?? '',
        brandModel: BrandModel.fromJson(json["brandModel"]),
        trim: Trim.fromJson(json["trim"]),
        year: Year.fromJson(json["year"]),
        colors: Colors.fromJson(json["colors"]),
        cartype: Cartype.fromJson(json["cartype"]),
        gearbox: Gearbox.fromJson(json["gearbox"]),
        specs: Specs.fromJson(json["specs"]),
        location: Location.fromJson(json["location"]),
        seats: json["seats"] ?? 0,
        kilometer: json["kilometer"] ?? '',
        price: json["price"] ?? 0.0,
        currency: Currency.fromJson(json["currency"]),
        isActive: json["isActive"] ?? false,
        imageGallaries: List<ImageGallary>.from(
            json["imageGallaries"].map((x) => ImageGallary.fromJson(x))),
        features: json["features"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "brandModel": brandModel.toJson(),
        "trim": trim.toJson(),
        "year": year.toJson(),
        "colors": colors.toJson(),
        "cartype": cartype.toJson(),
        "gearbox": gearbox.toJson(),
        "specs": specs.toJson(),
        "location": location.toJson(),
        "seats": seats,
        "kilometer": kilometer,
        "price": price,
        "currency": currency.toJson(),
        "isActive": isActive,
        "imageGallaries":
            List<dynamic>.from(imageGallaries.map((x) => x.toJson())),
        "features": features,
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

class Cartype {
  Cartype({
    required this.id,
    required this.typeName,
    required this.typeNameAr,
    required this.imgPath,
  });

  String id;
  String typeName;
  dynamic typeNameAr;
  String imgPath;

  factory Cartype.fromJson(Map<String, dynamic> json) => Cartype(
        id: json["id"] ?? '',
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

class Colors {
  Colors({
    required this.id,
    required this.colorName,
    required this.colorNameAr,
  });

  String? id;
  String? colorName;
  dynamic? colorNameAr;

  factory Colors.fromJson(Map<String, dynamic> json) => Colors(
        id: json["id"] ?? '',
        colorName: json["colorName"] ?? '',
        colorNameAr: json["colorNameAr"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "colorName": colorName,
        "colorNameAr": colorNameAr,
      };
}

class Currency {
  Currency({
    required this.id,
    required this.currencyName,
    required this.currencyNameAr,
  });

  String? id;
  String? currencyName;
  dynamic? currencyNameAr;

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

class Gearbox {
  Gearbox({
    required this.id,
    required this.gearboxName,
    required this.gearboxNameAr,
  });

  String? id;
  String? gearboxName;
  dynamic? gearboxNameAr;

  factory Gearbox.fromJson(Map<String, dynamic> json) => Gearbox(
        id: json["id"] ?? '',
        gearboxName: json["gearboxName"] ?? '',
        gearboxNameAr: json["gearboxNameAr"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gearboxName": gearboxName,
        "gearboxNameAr": gearboxNameAr,
      };
}

class ImageGallary {
  ImageGallary({
    required this.id,
    required this.filePath,
    required this.orderNo,
  });

  String? id;
  String filePath;
  int? orderNo;

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

class Location {
  Location({
    required this.id,
    required this.locationName,
    required this.locationNameAr,
  });

  String? id;
  String? locationName;
  dynamic? locationNameAr;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"] ?? '',
        locationName: json["locationName"] ?? '',
        locationNameAr: json["locationNameAr"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "locationName": locationName,
        "locationNameAr": locationNameAr,
      };
}

class Specs {
  Specs({
    required this.id,
    required this.specsName,
    required this.specsNameAr,
  });

  String? id;
  String? specsName;
  dynamic? specsNameAr;

  factory Specs.fromJson(Map<String, dynamic> json) => Specs(
        id: json["id"] ?? '',
        specsName: json["specsName"] ?? '',
        specsNameAr: json["specsNameAr"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "specsName": specsName,
        "specsNameAr": specsNameAr,
      };
}

class Trim {
  Trim({
    this.id,
    this.trimName,
    this.trimNameAr,
  });

  String? id;
  String? trimName;
  dynamic? trimNameAr;

  factory Trim.fromJson(Map<String, dynamic> json) => Trim(
        id: json["id"] ?? '',
        trimName: json["trimName"] ?? '',
        trimNameAr: json["trimNameAr"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "trimName": trimName,
        "trimNameAr": trimNameAr,
      };
}

class Year {
  Year({
    required this.id,
    required this.yearName,
  });

  String? id;
  int? yearName;

  factory Year.fromJson(Map<String, dynamic> json) => Year(
        id: json["id"] ?? '',
        yearName: json["yearName"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "yearName": yearName,
      };
}
*/
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
