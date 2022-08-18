import 'package:auto_car/model/brand_model.dart';
import 'package:auto_car/model/car_model.dart';
import 'package:auto_car/model/category_model.dart';

import '../model/offer_details_model.dart';

class ApiResponse {
  bool status = false;
  String message = "";
  String code = "";
  int totalRecords = 0;
  List<Datum> dataCar = [];
  List<CategoryModel> dataCategory = [];
  List<BrandsModel> dataBrand = [];
  List<ImageGallary> dataImageGallary = [];
}
