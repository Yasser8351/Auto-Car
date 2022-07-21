import 'dart:developer';

import 'package:auto_car/config/app_config.dart';
import 'package:auto_car/provider/car_provider.dart';
import 'package:auto_car/widget/search_widget_with_logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../enum/all_enum.dart';
import '../model/car_model.dart';
import '../widget/filter_search_widget.dart';
import '../widget/list_brand_text_widget.dart';
import '../widget/list_cars_widget.dart';
import '../widget/loading_widget.dart';
import '../widget/reytry_error_widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static const routeName = AppConfig.home;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late CarProvider carProvider;
  List<CarModel> listCars = [];
  bool isSearch = false;

  @override
  void initState() {
    carProvider = Provider.of<CarProvider>(context, listen: false);
    carProvider
        .getCars()
        .then((value) => {listCars = value.dataCar, setState(() {})});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (carProvider.loadingState == LoadingState.initial ||
        carProvider.loadingState == LoadingState.loading) {
      return const LoadingWidget(
          msg: AppConfig.loading, msgColor: Colors.black, color: Colors.black);
    } else if (carProvider.loadingState == LoadingState.error) {
      return ReyTryErrorWidget(
        title: carProvider.apiResponse.message,
        onTap: () {
          setState(() {
            carProvider.loadingState = LoadingState.loading;
          });
          log(carProvider.loadingState.toString());
          carProvider.reloedListCars().then(
                (value) => {
                  listCars = value.dataCar,
                  setState(() {}),
                },
              );
        },
      );
    } else if (carProvider.loadingState == LoadingState.noDataFound) {
      return ReyTryErrorWidget(
        title: AppConfig.noDataFound,
        onTap: () {
          setState(() {
            carProvider.loadingState = LoadingState.loading;
          });
          carProvider.reloedListCars().then(
                (value) => {
                  listCars = value.dataCar,
                  setState(() {}),
                },
              );
        },
      );
    } else {
      return SingleChildScrollView(
        child: isSearch
            ? FilterSearchWidget(onTap: () {
                setState(() {
                  isSearch = !isSearch;
                });
              })
            : Container(
                color: const Color(0xffF8F8F8),
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
                      const SizedBox(height: 10),
                      const ListBrandTextWidget(),
                      const SizedBox(height: 40),
                      ListCarsWidget(listCars: listCars, isOffers: false)
                    ],
                  ),
                ),
              ),
      );
    }
  }
}

buildTextTitleWidget() {
  return const Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Text(
        AppConfig.findYourFavertCar,
        style: AppConfig.textTitleHome,
      ),
    ),
  );
}


/* 

import 'dart:developer';

import 'package:auto_car/config/app_config.dart';
import 'package:auto_car/provider/car_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../enum/all_enum.dart';
import '../model/car_model.dart';
import '../widget/build_search_widget.dart';
import '../widget/filter_search_widget.dart';
import '../widget/list_brand_widget.dart';
import '../widget/list_cars_widget.dart';
import '../widget/loading_widget.dart';
import '../widget/reytry_error_widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static const routeName = AppConfig.home;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late CarProvider carProvider;
  List<CarModel> listCars = [];
  bool isSearch = false;

  @override
  void initState() {
    carProvider = Provider.of<CarProvider>(context, listen: false);
    carProvider
        .getCars()
        .then((value) => {listCars = value.dataCar, setState(() {})});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (carProvider.loadingState == LoadingState.initial ||
        carProvider.loadingState == LoadingState.loading) {
      return const LoadingWidget(
          msg: AppConfig.loading, msgColor: Colors.black, color: Colors.black);
    } else if (carProvider.loadingState == LoadingState.error) {
      return ReyTryErrorWidget(
        title: carProvider.apiResponse.message,
        onTap: () {
          setState(() {
            carProvider.loadingState = LoadingState.loading;
          });
          log(carProvider.loadingState.toString());
          carProvider.reloedListCars().then(
                (value) => {
                  listCars = value.dataCar,
                  setState(() {}),
                },
              );
        },
      );
    } else if (carProvider.loadingState == LoadingState.noDataFound) {
      return ReyTryErrorWidget(
        title: AppConfig.noDataFound,
        onTap: () {
          setState(() {
            carProvider.loadingState = LoadingState.loading;
          });
          carProvider.reloedListCars().then(
                (value) => {
                  listCars = value.dataCar,
                  setState(() {}),
                },
              );
        },
      );
    } else {
      return SingleChildScrollView(
        child: isSearch
            ? FilterSearchWidget(onTap: () {
                setState(() {
                  isSearch = !isSearch;
                });
              })
            : Container(
                color: const Color(0xffF8F8F8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      buildTextTitleWidget(),
                      const SizedBox(height: 20),
                      BuildSearchWidget(onTap: () {
                        setState(() {
                          isSearch = !isSearch;
                        });
                      }),
                      const SizedBox(height: 40),
                      const ListBrandWidget(),
                      const SizedBox(height: 40),
                      ListCarsWidget(listCars: listCars, isOffers: false)
                    ],
                  ),
                ),
              ),
      );
    }
  }
}

buildTextTitleWidget() {
  return const Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Text(
        AppConfig.findYourFavertCar,
        style: AppConfig.textTitleHome,
      ),
    ),
  );
}


buildSearchWidget(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Container(
        height: 50,
        width: size.width / 1.3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Icon(
                Icons.search,
                color: Colors.grey,
              ),
              SizedBox(width: 10),
              Text(
                AppConfig.findCar,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(width: 10),
      CardWithImage(
        height: 50,
        width: 50,
        child: Center(
          child: SvgPicture.asset(
            AppConfig.filter,
            height: 30,
            width: 30,
            color: Colors.white,
          ),
        ),
        colors: Colors.black,
        onTap: () {},
      ),
    ],
  );

}


 */