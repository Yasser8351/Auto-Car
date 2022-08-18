import 'dart:convert';

import 'package:auto_car/debugger/my_debuger.dart';
import 'package:auto_car/model/car_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../api/api_constant.dart';
import '../api/api_response.dart';
import '../config/app_config.dart';
import '../enum/all_enum.dart';

class CarProvider with ChangeNotifier {
  List<Datum> _listCars = [];
  ApiResponse apiResponse = ApiResponse();
  LoadingState loadingState = LoadingState.initial;

  //This Constracter when execut Then Call Data from API
  //the aprothe to improve performancie when because the provider

  // CarProvider(){
  //   getCars();
  // }

  //This function call the data from the API
  //The Post type function takes the search value from the body
  //get List of Cars in Home Screen
  Future<ApiResponse> getCars(int pageNumber, String search) async {
    myLogs("getCars", getCars);
    try {
      loadingState = LoadingState.loading;
      var response = await http
          .post(
              Uri.parse(
                  'http://207.180.223.113:8975/api/v1/Offer/MGetAll?PageNumber=$pageNumber&PageSize=5'
                  //  ApiUrl.getAllOffer + 'PageNumber=$pageNumber&PageSize=1',
                  ),
              headers: ApiUrl.getHeader(),
              body: json.encode(
                {
                  "search": search //mercedes benz
                },
              ))
          .timeout(Duration(seconds: 10));

      myLogs("response.body", response.body);
      myLogs("response.statusCode", response.statusCode);
      if (response.statusCode == 200) {
        //  _listCars = carModelFromJson(response.body);
        apiResponse.totalRecords = carModelFromJson(response.body).totalRecords;
        _listCars = carModelFromJson(response.body).data;
        if (_listCars.isEmpty) {
          loadingState = LoadingState.noDataFound;
        } else {
          setApiResponseValue('get Data Cars Sucsessfuly', true, _listCars,
              LoadingState.loaded);
        }
      } else if (response.statusCode == 401) {
        setApiResponseValue(
            AppConfig.unAutaristion, false, _listCars, LoadingState.error);
      } else if (response.statusCode == 500) {
        setApiResponseValue(
            AppConfig.serverError, false, _listCars, LoadingState.error);
      } else {
        setApiResponseValue(
            AppConfig.errorOoccurred, false, _listCars, LoadingState.error);
      }
      /*
    
    } on SocketException {
      setApiResponseValue(
          AppConfig.noInternet, false, _listCars, LoadingState.error);
    } on FormatException {
      setApiResponseValue(
          AppConfig.serverError, false, _listCars, LoadingState.error);
    }

    
    */
    } catch (error) {
      setApiResponseValue(
          error.toString(), false, _listCars, LoadingState.error);
      myLog("getCars", "catch error", error.toString());
    }

    notifyListeners();
    return apiResponse;
  }

  //This methode call to Refresh Data in Screen,
  //when user Scroll to refresh Screen
  //The function takes tow varibles pageNumber and key of the Search
  reloedListCars(int pageNumber, String search) {
    return getCars(pageNumber, search);
  }

  setApiResponseValue(
      String message, bool status, List<Datum> data, LoadingState state) {
    apiResponse.message = message;
    apiResponse.status = status;
    apiResponse.dataCar = data;
    loadingState = state;
  }
}
