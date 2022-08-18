// import 'dart:developer';

// import 'package:auto_car/config/app_config.dart';
// import 'package:auto_car/provider/car_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../enum/all_enum.dart';
// import '../model/car_model.dart';
// import '../widget/build_search_widget.dart';
// import '../widget/filter_search_widget.dart';
// import '../widget/list_brand_widget.dart';
// import '../widget/list_cars_widget.dart';
// import '../widget/loading_widget.dart';
// import '../widget/reytry_error_widget.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//   static const routeName = "HomeScreen";

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   late CarProvider carProvider;
//   List<CarModel> listCars = [];
//   bool isFilter = false;

//   @override
//   void initState() {
//     carProvider = Provider.of<CarProvider>(context, listen: false);
//     carProvider
//         .getCars()
//         .then((value) => {listCars = value.dataCar, setState(() {})});

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     if (carProvider.loadingState == LoadingState.initial ||
//         carProvider.loadingState == LoadingState.loading) {
//       return const LoadingWidget(
//           msg: AppConfig.loading, msgColor: Colors.black, color: Colors.black);
//     } else if (carProvider.loadingState == LoadingState.error) {
//       return ReyTryErrorWidget(
//         title: carProvider.apiResponse.message,
//         onTap: () {
//           setState(() {
//             carProvider.loadingState = LoadingState.loading;
//           });
//           log(carProvider.loadingState.toString());
//           carProvider.reloedListCars().then(
//                 (value) => {
//                   listCars = value.dataCar,
//                   setState(() {}),
//                 },
//               );
//         },
//       );
//     } else if (carProvider.loadingState == LoadingState.noDataFound) {
//       return ReyTryErrorWidget(
//         title: AppConfig.noDataFound,
//         onTap: () {
//           setState(() {
//             carProvider.loadingState = LoadingState.loading;
//           });
//           carProvider.reloedListCars().then(
//                 (value) => {
//                   listCars = value.dataCar,
//                   setState(() {}),
//                 },
//               );
//         },
//       );
//     } else {
//       return SingleChildScrollView(
//         child: isFilter
//             ? FilterSearchWidget(onTap: () {
//                 setState(() {
//                   isFilter = !isFilter;
//                 });
//               })
//             : Container(
//                 color: const Color(0xffF8F8F8),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   child: Column(
//                     children: [
//                       const SizedBox(height: 50),
//                       buildTextTitleWidget(),
//                       const SizedBox(height: 20),
//                       BuildSearchWidget(
//                         onTap: () {
//                           setState(() {
//                             isFilter = !isFilter;
//                           });
//                         },
//                       ),
//                       const SizedBox(height: 40),
//                       const ListBrandWidget(),
//                       const SizedBox(height: 40),
//                       ListCarsWidget(
//                         listCars: listCars,
//                         isOffers: false,
//                         listCarsById: [],
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//       );
//     }
//   }
// }

// buildTextTitleWidget() {
//   return const Align(
//     alignment: Alignment.centerLeft,
//     child: Padding(
//       padding: EdgeInsets.symmetric(horizontal: 0),
//       child: Text(
//         AppConfig.findYourFavertCar,
//         style: AppConfig.textTitleHome,
//       ),
//     ),
//   );
// }
/*

import 'dart:developer';

import 'package:auto_car/config/app_config.dart';
import 'package:auto_car/debugger/my_debuger.dart';
import 'package:auto_car/provider/car_provider.dart';
import 'package:auto_car/widget/search_widget_with_logo.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../database/sqldb.dart';
import '../enum/all_enum.dart';
import '../model/car_model.dart';
import '../widget/list_brand_text_widget.dart';
import '../widget/list_cars_widget.dart';
import '../widget/loading_widget.dart';
import '../widget/reytry_error_widget.dart';
import '../widget/text_faild_search_widget.dart';

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
  List<Map<String, dynamic>> _id = [];
  TextEditingController textSearchController = TextEditingController();

  Future<void> getDataFromSqfLite() async {
    SQLDatabase sqlDatabase = SQLDatabase();

    _id = await sqlDatabase.getData("SELECT id FROM 'MyFavorite'");
    // if (_id.contains(1)) {
    //   log("1");
    //   log("Map id ${_id[0]['id']}");
    // } else {
    //   log("not faund Map id ${_id[1]['id']}");
    // }

    // setState(() {});
  }

  @override
  void initState() {
    FirebaseMessaging.instance.subscribeToTopic("test");
    getDataFromSqfLite();

    carProvider = Provider.of<CarProvider>(context, listen: false);
    carProvider.getCars().then((value) => {
          setState(() {
            listCars = value.dataCar;
          }),
        });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      myLogs("onMessageOpenedApp", message);
      toastMessage('onMessageOpenedApp');

      // Navigator.of(context).pushNamed(More.routeName);
      // Future.delayed(const Duration(seconds: 3));
    });

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        myLogs("message", message.data.toString());
        myLogs("message", message.from);
        final routeFromMessage = message.data["route"];
        myLogs("routeFromMessage", routeFromMessage);

        Navigator.of(context).pushNamed(routeFromMessage);
      }
    });

    ///forground work
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        log("forground work");
        log(message.notification!.body.toString());
        log(message.notification!.title.toString());
      }

      //  LocalNotificationService.display(message);
    });

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
          getDataCars();
        },
      );
    } else if (carProvider.loadingState == LoadingState.noDataFound) {
      return ReyTryErrorWidget(
        title: AppConfig.noDataFound,
        onTap: () {
          setState(() {
            carProvider.loadingState = LoadingState.loading;
          });
          getDataCars();
        },
      );
    } else {
      return SingleChildScrollView(
        child: isSearch
            ? TextFaildSearchWidget(
                textSearchController: textSearchController,
                onTap: () {
                  setState(
                    () {
                      isSearch = !isSearch;
                    },
                  );
                },
                onTapSearch: () {
                  setState(
                    () {
                      isSearch = !isSearch;
                      if (textSearchController.text.isEmpty) {
                        getDataCars();
                      }

                      listCars = listCars
                          .where(
                            (element) =>
                                element.title == textSearchController.text,
                          )
                          .toList();
                    },
                  );
                },
              )
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
                      ListCarsWidget(
                        listCars: listCars,
                        isOffers: false,
                        listCarsById: _id,
                      )
                    ],
                  ),
                ),
              ),
      );
    }
  }

  void getDataCars() {
    carProvider.reloedListCars().then(
          (value) => {
            listCars = value.dataCar,
            setState(() {}),
          },
        );
  }

  void toastMessage(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.black,
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
        style: AppConfig.textTitleHome,
      ),
    ),
  );
}

*/