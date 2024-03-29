import 'dart:developer';

import 'package:auto_car/config/app_config.dart';
import 'package:auto_car/debugger/my_debuger.dart';
import 'package:auto_car/model/brand_model.dart';
import 'package:auto_car/provider/brand_provider.dart';
import 'package:auto_car/provider/car_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../enum/all_enum.dart';
import '../model/car_model.dart';
import '../widget/list_cars_widget.dart';
import '../widget/loading_widget.dart';
import '../widget/reytry_error_widget.dart';
import '../widget/search_widget_with_logo.dart';
import '../widget/text_faild_search_widget.dart';

class OffersByCategory extends StatefulWidget {
  const OffersByCategory({Key? key, required this.search}) : super(key: key);
  static const routeName = 'OffersByCategory';
  final String search;

  @override
  State<OffersByCategory> createState() => _OffersByCategoryState();
}

class _OffersByCategoryState extends State<OffersByCategory> {
  late CarProvider carProvider;
  late BrandProvider brandProvider;
  List<Datum> listCars = [];
  List<BrandsModel> listBrands = [];
  bool isSearch = false;
  bool isRefresh = false;
  List<Map<String, dynamic>> _id = [];
  TextEditingController textSearchController = TextEditingController();
  int totalRecords = 0;
  int pageNumber = 1;
  //String search = '';
  int expandedIndex = -1;

  @override
  void initState() {
    FirebaseMessaging.instance.subscribeToTopic("test");

    myLogs("key", widget.search);

    carProvider = Provider.of<CarProvider>(context, listen: false);
    carProvider.getCarsByCategory(1, 20, widget.search).then((value) => {
          setState(() {
            listCars = value.dataCar;
            totalRecords = value.totalRecords;
            myLogs("totalRecords", totalRecords);
          }),
        });
    brandProvider = Provider.of<BrandProvider>(context, listen: false);
    brandProvider.getBrands().then((value) => {
          setState(() {
            listBrands = value.dataBrand;
          }),
        });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      myLogs("onMessageOpenedApp", message);
      toastMessage('onMessageOpenedApp');

      // Navigator.of(context).pushNamed(More.routeName);
      // Future.delayed(const Duration(seconds: 3));
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    ///forground work
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        toastMessage(message.notification!.body.toString());
        log("forground work");
        log(message.notification!.body.toString());
        log(message.notification!.title.toString());
        Navigator.of(context).pushNamed(message.notification!.body.toString());
      }

      //  LocalNotificationService.display(message);
    });

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        myLogs("message", message.data.toString());
        myLogs("message", message.from);
        final routeFromMessage = message.data["route"];
        myLogs("routeFromMessage", routeFromMessage);

        // Navigator.of(context).pushNamed(message.data.b);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (carProvider.loadingState == LoadingState.initial ||
        carProvider.loadingState == LoadingState.loading) {
      return LoadingWidget(
        msg: AppConfig.loading,
        msgColor: Theme.of(context).colorScheme.onSecondary,
        color: Theme.of(context).colorScheme.onBackground,
      );
    } else if (carProvider.loadingState == LoadingState.error) {
      return ReyTryErrorWidget(
        title: carProvider.apiResponse.message,
        onTap: () {
          setState(() => carProvider.loadingState = LoadingState.loading);
          getDataCars();
        },
      );
    } else {
      return Scaffold(
        body: Builder(
          builder: (context) {
            if (isSearch) {
              return TextFaildSearchWidget(
                textSearchController: textSearchController,
                onTap: () {
                  setState(() => isSearch = !isSearch);
                },
                onTapSearch: () {
                  setState(() => isSearch = !isSearch);
                  if (textSearchController.text.isEmpty) {
                    isSearch = false;
                    //getDataCars();
                  }
                  carProvider
                      .getCarsByCategory(1, 10, textSearchController.text)
                      .then((value) => {
                            setState(() {
                              expandedIndex = -1;
                              listCars = value.dataCar;
                              totalRecords = value.totalRecords;
                            }),
                          });
                },
              );
            } else {
              return Container(
                color: const Color(0xffF8F8F8),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
                        SearchWidgetWithLogo(
                          onTap: () {
                            setState(() {
                              isSearch = !isSearch;
                            });
                          },
                        ),
                        const SizedBox(height: 0),
                        // carProvider.loadingState == LoadingState.noDataFound
                        //     ?
                        // NoDataFoundWidget(
                        //   title: AppConfig.noOfferFound,
                        //   onTap: () {
                        //     setState(() {
                        //       carProvider.loadingState = LoadingState.loading;
                        //     });
                        //     getDataCars();
                        //   },
                        // )
                        // :
                        ListCarsWidget(
                          isSearch: isSearch,
                          listCars: listCars,
                          totalRecords: 0,
                          isOffers: false,
                          carProvider: carProvider,
                          listCarsById: _id,
                          onTap: () {
                            // myLogs(listCars.length.toString(),
                            //     "no data found  --------  loade more");
                            // if (listCars.length == totalRecords) {
                            // } else {
                            //   myLogs(listCars.length.toString(),
                            //       "OffersByCategory  --------  loade more");
                            //   getDataCarsProvider(pageNumber + 1);
                            // }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      );
    }
  }

  void getDataCars() {
    getDataCarsProvider(pageNumber);
    brandProvider.reloedListBrands().then(
          (value) => {
            listBrands = value.dataBrand,
            setState(() {}),
          },
        );
  }

  void getDataCarsProvider(int pageNumber) {
    carProvider.reloedListCarsByCategory(pageNumber, 10, widget.search).then(
          (value) => {
            // listCars = value.dataCar,
            listCars.addAll(value.dataCar),
            setState(() {}),
          },
        );
  }

  void toastMessage(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

buildTextTitleWidget() {
  return const Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Text(
        AppConfig.findYourFavertCar,
        style: AppConfig.textOverview,
      ),
    ),
  );
}
