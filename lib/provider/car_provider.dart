import 'package:auto_car/model/car_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../api/api_constant.dart';
import '../api/api_response.dart';
import '../debugger/my_debuger.dart';
import '../enum/all_enum.dart';

class CarProvider with ChangeNotifier {
  List<CarModel> _listCars = [];
  ApiResponse apiResponse = ApiResponse();
  LoadingState loadingState = LoadingState.initial;

//////////////////////// get List of Cars in Home Screen
  Future<ApiResponse> getCars() async {
    try {
      loadingState = LoadingState.loading;
      var response =
          await http.get(ApiUrl.products).timeout(const Duration(seconds: 12));
      if (response.statusCode == 200) {
        _listCars = carModelFromJson(response.body);
        if (_listCars.isEmpty) {
          loadingState = LoadingState.noDataFound;
        } else {
          setApiResponseValue('get Data Cars Sucsessfuly', true, _listCars,
              LoadingState.loaded);
        }
      } else if (response.statusCode == 401) {
        setApiResponseValue(
            'Un autaristion', false, _listCars, LoadingState.error);
      } else if (response.statusCode == 500) {
        setApiResponseValue(
            'Server error', false, _listCars, LoadingState.error);
      } else {
        setApiResponseValue(
            'Somthing wrong error', false, _listCars, LoadingState.error);
      }
    } catch (error) {
      setApiResponseValue(
          error.toString(), false, _listCars, LoadingState.error);
      myLog("getCars", "error", error.toString());
    }
    notifyListeners();
    return apiResponse;
  }

//////////////////////// reloed List of Cars if the user refresh the Home Screen

  reloed_listCars() {
    return getCars();
  }

  setApiResponseValue(
      String message, bool status, List<CarModel> data, LoadingState state) {
    apiResponse.message = message;
    apiResponse.status = status;
    apiResponse.data = data;
    loadingState = state;
  }
}
