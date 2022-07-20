import 'package:auto_car/model/car_model.dart';
import 'package:auto_car/model/category_model.dart';

class ApiResponse {
  bool status = false;
  String message = "";
  String code = "";
  List<CarModel> dataCar = [];
  List<CategoryModel> dataCategory = [];
}
