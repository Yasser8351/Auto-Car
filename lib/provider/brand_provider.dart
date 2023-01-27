import 'dart:io';

import 'package:auto_car/config/app_config.dart';
import 'package:auto_car/model/brand_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../api/api_constant.dart';
import '../api/api_response.dart';
import '../enum/all_enum.dart';

class BrandProvider with ChangeNotifier {
  List<BrandsModel> _listBrands = [];
  ApiResponse apiResponse = ApiResponse();
  LoadingState loadingState = LoadingState.initial;

  List<BrandsModel> get listBrands => _listBrands;

  // getBrands();

  BrandProvider() {
    getBrands();
  }

//////////////////////// get List of Brand in Home Screen
  Future<ApiResponse> getBrands() async {
    try {
      loadingState = LoadingState.loading;
      var response =
          await http.get(ApiUrl.getAllBrand, headers: ApiUrl.getHeader());
      // .timeout(const Duration(seconds: 20));
      if (response.statusCode == 200) {
        //  _listBrands = carModelFromJson(response.body);
        _listBrands = brandsModelFromJson(response.body);
        // myLogs('_listBrands', _listBrands.length);
        if (_listBrands.isEmpty) {
          loadingState = LoadingState.noDataFound;
        } else {
          setApiResponseValue('get Data Brands Sucsessfuly', true, _listBrands,
              LoadingState.loaded);
        }
      } else if (response.statusCode == 401) {
        setApiResponseValue(
            'Un autaristion', false, _listBrands, LoadingState.error);
      } else if (response.statusCode == 500) {
        setApiResponseValue(
            'Server error', false, _listBrands, LoadingState.error);
      } else {
        setApiResponseValue(
            'Somthing wrong error', false, _listBrands, LoadingState.error);
      }
    } on SocketException {
      setApiResponseValue(
          AppConfig.noInternet, false, _listBrands, LoadingState.error);
    } on FormatException {
      setApiResponseValue(
          AppConfig.serverError, false, _listBrands, LoadingState.error);
    } catch (error) {
      setApiResponseValue(
          error.toString().contains('TimeoutException')
              ? AppConfig.timeout
              : AppConfig.somthingWrong,
          false,
          _listBrands,
          LoadingState.error);
    }
    notifyListeners();
    return apiResponse;
  }

//////////////////////// reloed List of Brands if the user refresh the Home Screen

  reloedListBrands() {
    return getBrands();
  }

  setApiResponseValue(
      String message, bool status, List<BrandsModel> data, LoadingState state) {
    apiResponse.message = message;
    apiResponse.status = status;
    apiResponse.dataBrand = data;
    loadingState = state;
  }
}
