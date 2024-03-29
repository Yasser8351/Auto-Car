import 'dart:convert';
import 'dart:io';

import 'package:auto_car/debugger/my_debuger.dart';
import 'package:auto_car/model/car_model.dart';
import 'package:auto_car/sharedpref/user_share_pref.dart';
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

  List<Datum> get listCars => _listCars;
  SharedPrefUser sharedPrefUser = SharedPrefUser();

  //This Constracter when execut Then Call Data from API
  //the aprothe to improve performancie when because the provider

  // CarProvider() {
  //   getCars(1, 10, '');
  // }

  //This function call the data from the API
  //The Post type function takes the search value from the body
  //get List of Cars in Home Screen

  Future<ApiResponse> getCarsByCategory(
      int pageNumber, int pageSize, String search) async {
    try {
      loadingState = LoadingState.loading;
      var response = await http
          .post(
              Uri.parse(
                ApiUrl.getOffersByCategory +
                    'PageNumber=$pageNumber&PageSize=$pageSize',
              ),
              headers: ApiUrl.getHeader(),
              body: json.encode(
                {
                  "search": search,
                  // "search": "276962eb-055f-467b-8323-04bce51ec348"
                },
              ))
          .timeout(Duration(seconds: 15));

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
    } on SocketException {
      setApiResponseValue(
          AppConfig.noInternet, false, _listCars, LoadingState.error);
    } on FormatException {
      setApiResponseValue(
          AppConfig.serverError, false, _listCars, LoadingState.error);
    } catch (error) {
      setApiResponseValue(
          error.toString().contains('TimeoutException')
              ? AppConfig.timeout
              : AppConfig.somthingWrong,
          false,
          _listCars,
          LoadingState.error);
      myLogs("catch error", error.toString());
    }
    // } catch (error) {
    // setApiResponseValue(
    //     error.toString(), false, _listCars, LoadingState.error);
    //   myLog("getCarsByCategory", "catch error", error.toString());
    // }

    notifyListeners();
    return apiResponse;
  }

  Future<ApiResponse> getCars(
      int pageNumber, int pageSize, String search) async {
    String uid = await sharedPrefUser.getUid();
    try {
      loadingState = LoadingState.loading;
      var response = await http
          .post(
              Uri.parse(
                ApiUrl.getAllOffer +
                    'PageNumber=$pageNumber&PageSize=$pageSize',
              ),
              headers: ApiUrl.getHeader(),
              body: json.encode(
                {
                  "search": search,
                  "clientId": uid,
                  // "e8aa0eb5-46c7-4e60-a32b-e96fd57f16252022-08-21 10:25:36.316499",
                },
              ))
          .timeout(Duration(seconds: 20));

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
    } on SocketException {
      setApiResponseValue(
          AppConfig.noInternet, false, _listCars, LoadingState.error);
    } on FormatException {
      setApiResponseValue(
          AppConfig.serverError, false, _listCars, LoadingState.error);
    } catch (error) {
      if (error.toString().contains('TimeoutException')) {
        setApiResponseValue(
            "اتصال الانترنت ضعيف", false, _listCars, LoadingState.error);
      } else {
        setApiResponseValue(
            error.toString(), false, _listCars, LoadingState.error);
      }
      myLog("getCars", "catch error", error.toString());
    }

    notifyListeners();
    return apiResponse;
  }

  Future<bool> updateFavorite(String offerId, bool isFavorite) async {
    myLog("start methode", " updateFavorite", '');

    // {
//   "offerId": "380bf5eb-f0aa-4906-b9d3-4649a5ef77ff",
//   "clientId": "e8aa0eb5-46c7-4e60-a32b-e96fd57f16252022-08-21 10:25:36.316499",
//   "isFavorite": true
// }
    String uid = await sharedPrefUser.getUid();

    try {
      loadingState = LoadingState.loading;
      var response = await http.post(
          Uri.parse(
            ApiUrl.updateFavorite,
          ),
          headers: ApiUrl.getHeader(),
          body: json.encode(
            {
              "offerId": offerId,
              "clientId": uid,
              "isFavorite": isFavorite,
            },
          ));

      myLogs('isFavorite', response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        setApiResponseValue(
            AppConfig.errorOoccurred, false, _listCars, LoadingState.error);
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  //This methode call to Refresh Data in Screen,
  //when user Scroll to refresh Screen
  //The function takes tow varibles pageNumber and key of the Search
  reloedListCars(int pageNumber, int pageSize, String search) {
    return getCars(pageNumber, pageSize, search);
  }

  reloedListCarsByCategory(int pageNumber, int pageSize, String search) {
    return getCarsByCategory(pageNumber, pageSize, search);
  }

  setApiResponseValue(
      String message, bool status, List<Datum> data, LoadingState state) {
    apiResponse.message = message;
    apiResponse.status = status;
    apiResponse.dataCar = data;
    loadingState = state;
  }
}
