import 'dart:convert';
import 'dart:io';

import 'package:auto_car/api/api_constant.dart';
import 'package:auto_car/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../api/api_response.dart';
import '../debugger/my_debuger.dart';
import '../enum/all_enum.dart';
import '../model/offer_details_model.dart';

class OfferDetailsProvider with ChangeNotifier {
  List<ImageGallary> _listImageGallary = [];
  List<FeaturesType> _listFeature = [];
  OfferModel get getOfferModel => offerModel;
  ApiResponse apiResponse = ApiResponse();
  LoadingState loadingState = LoadingState.initial;
  OfferModel offerModel = OfferModel(
      id: "",
      description: "",
      kilometer: "",
      price: 0.0,
      seats: 0,
      modelName: '');

  // get list
  List<ImageGallary> get listImageGallary => _listImageGallary;
  List<FeaturesType> get listFeature => _listFeature;
  // OfferDetailsProvider() {
  //   geOffersDetails(id);
  // }

//////////////////////// get List of Category in Category Screen
  Future<ApiResponse> geOffersDetails(String id) async {
    try {
      loadingState = LoadingState.loading;
      var response = await http
          .post(
              Uri.parse(
                  "http://207.180.223.113:8975/api/v1/Offer/MGetOfferDetails?bid=$id"),
              headers: ApiUrl.getHeader(),
              body: json.encode({"updateSummary": true}))
          .timeout(const Duration(seconds: 200));

      myLogs("statusCode", response.statusCode);
      myLogs("response", response.body.toString());

      if (response.statusCode == 200) {
        var responseFromBody = offerDetailsModelFromJson(response.body);

        _listImageGallary = responseFromBody.imageGallaries;
        _listFeature = responseFromBody.featuresTypes;

        offerModel.description = responseFromBody.description;
        offerModel.kilometer = responseFromBody.kilometer;
        offerModel.seats = responseFromBody.seats;
        offerModel.price = responseFromBody.price;
        offerModel.modelName = responseFromBody.brandModel.modelName;

        if (_listImageGallary.isEmpty) {
          loadingState = LoadingState.noDataFound;
        } else {
          setApiResponseValue('get Data Category Sucsessfuly', true,
              _listImageGallary, LoadingState.loaded);
        }
      } else if (response.statusCode == 401) {
        setApiResponseValue(
            //'Un autaristion'
            AppConfig.unAutaristion,
            false,
            _listImageGallary,
            LoadingState.error);
      } else if (response.statusCode == 500) {
        setApiResponseValue(AppConfig.serverError, false, _listImageGallary,
            LoadingState.error);
      } else {
        setApiResponseValue(AppConfig.somthingWrong, false, _listImageGallary,
            LoadingState.error);
      }
    } on SocketException {
      setApiResponseValue(
          AppConfig.noInternet, false, _listImageGallary, LoadingState.error);
    } on FormatException {
      setApiResponseValue(
          AppConfig.serverError, false, _listImageGallary, LoadingState.error);
    }
    // } catch (e) {
    //   myLogs("error", e.toString());
    // }

    notifyListeners();
    return apiResponse;
  }

//////////////////////// reloed List of Cars if the user refresh the Home Screen

  reloedListCategory(String id) {
    return geOffersDetails(id);
  }

  setApiResponseValue(String message, bool status, List<ImageGallary> data,
      LoadingState state) {
    apiResponse.message = message;
    apiResponse.status = status;
    apiResponse.dataImageGallary = data;
    loadingState = state;
  }
}
