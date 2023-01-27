import 'dart:io';

import 'package:auto_car/config/app_config.dart';
import 'package:auto_car/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../api/api_constant.dart';
import '../api/api_response.dart';
import '../enum/all_enum.dart';

class CategoryProvider with ChangeNotifier {
  List<CategoryModel> _listCategory = [];
  ApiResponse apiResponse = ApiResponse();
  LoadingState loadingState = LoadingState.initial;

  // get list
  List<CategoryModel> get listCategory => _listCategory;
  CategoryProvider() {
    getListCategory();
  }
//////////////////////// get List of Category in Category Screen
  Future<ApiResponse> getListCategory() async {
    try {
      loadingState = LoadingState.loading;
      var response = await http
          .get(ApiUrl.getAllCateory, headers: ApiUrl.getHeader())
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        _listCategory = categoryModelFromJson(response.body);
        if (_listCategory.isEmpty) {
          loadingState = LoadingState.noDataFound;
        } else {
          setApiResponseValue('get Data Category Sucsessfuly', true,
              _listCategory, LoadingState.loaded);
        }
      } else if (response.statusCode == 401) {
        setApiResponseValue(
            //'Un autaristion'
            AppConfig.unAutaristion,
            false,
            _listCategory,
            LoadingState.error);
      } else if (response.statusCode == 500) {
        setApiResponseValue(
            AppConfig.serverError, false, _listCategory, LoadingState.error);
      } else {
        setApiResponseValue(
            AppConfig.somthingWrong, false, _listCategory, LoadingState.error);
      }
    } on SocketException {
      setApiResponseValue(
          AppConfig.noInternet, false, _listCategory, LoadingState.error);
    } on FormatException {
      setApiResponseValue(
          AppConfig.serverError, false, _listCategory, LoadingState.error);
    } catch (error) {
      setApiResponseValue(
          error.toString().contains('TimeoutException')
              ? AppConfig.timeout
              : AppConfig.somthingWrong,
          false,
          _listCategory,
          LoadingState.error);
    }

    notifyListeners();
    return apiResponse;
  }

//////////////////////// reloed List of Cars if the user refresh the Home Screen

  reloedListCategory() {
    return getListCategory();
  }

  setApiResponseValue(String message, bool status, List<CategoryModel> data,
      LoadingState state) {
    apiResponse.message = message;
    apiResponse.status = status;
    apiResponse.dataCategory = data;
    loadingState = state;
  }
}
