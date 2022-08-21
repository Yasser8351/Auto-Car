import 'package:auto_car/config/app_config.dart';
import 'package:auto_car/debugger/my_debuger.dart';
import 'package:auto_car/model/brand_model.dart';
import 'package:auto_car/provider/brand_provider.dart';
import 'package:auto_car/provider/car_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../enum/all_enum.dart';
import '../model/car_model.dart';
import '../sharedpref/user_share_pref.dart';
import '../widget/list_brand_widget.dart';
import '../widget/list_cars_widget.dart';
import '../widget/loading_widget.dart';
import '../widget/no_data_found_widget.dart';
import '../widget/reytry_error_widget.dart';
import '../widget/search_widget_with_logo.dart';
import '../widget/text_faild_search_widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.userId}) : super(key: key);
  static const routeName = AppConfig.home;

  final userId;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
  String search = '';
  int expandedIndex = -1;

  String userId = '';

  _getUSerFromSharedPref() async {
    var temp = await SharedPrefUser().getID();
    setState(() {
      userId = temp;
    });
    myLogs("userId Form Home Screen :", userId);
  }

  @override
  void initState() {
    _getUSerFromSharedPref();
    FirebaseMessaging.instance.subscribeToTopic("test");
    carProvider = Provider.of<CarProvider>(context, listen: false);
    carProvider.getCars(1, 10, search).then((value) => {
          setState(() {
            listCars = value.dataCar;
            totalRecords = value.totalRecords;
          }),
        });
    brandProvider = Provider.of<BrandProvider>(context, listen: false);
    brandProvider.getBrands().then((value) => {
          setState(() {
            listBrands = value.dataBrand;
          }),
        });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      //_showTopFlash(style: FlashBehavior.fixed);
      myLogs("onMessageOpenedApp", message);
      //toastMessage('onMessageOpenedApp');

      // Navigator.of(context).pushNamed(More.routeName);
      // Future.delayed(const Duration(seconds: 3));
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    ///forground work
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        showTopSnackBar(
          animationDuration: Duration(seconds: 7),
          context,
          Material(
            child: Column(
              children: [
                Text(AppConfig.newNotifcation, style: AppConfig.textDetails),
                SizedBox(height: 10),
                CustomSnackBar.success(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  message:
                      "${message.notification!.title} \n  ${message.notification!.body}",
                ),
                // Image.network(AppConfig.imageFromNetwork, height: 100)
              ],
            ),
          ),
        );

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

  SizedBox buildListBrand(Size size) {
    return SizedBox(
      height: size.height * .11,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: listBrands.length,
          itemBuilder: (context, index) {
            String logo = listBrands[index].logo;
            String title = listBrands[index].name;
            return GestureDetector(
              onTap: () {
                setState(() => {search = title});
                carProvider.getCars(1, 10, search).then((value) => {
                      setState(() {
                        listCars = value.dataCar;
                        totalRecords = value.totalRecords;
                        expandedIndex = index;
                      }),
                    });
              },
              child: Padding(
                //
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: size.height * .07,
                      width: size.width * .144,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: expandedIndex == index
                                ? Colors.black
                                : Colors.white),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: CachedNetworkImage(
                          width: size.width,
                          fit: BoxFit.contain,
                          height: size.height * .54,
                          filterQuality: FilterQuality.low,
                          imageUrl: logo,
                          //color: Colors.white,
                          placeholder: (context, url) => FadeInImage(
                            placeholder: AssetImage(AppConfig.placeholder),
                            image: AssetImage(AppConfig.placeholder),
                            width: double.infinity,
                            height: size.height * .163,
                            fit: BoxFit.cover,
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      title,
                      style: AppConfig.textSpecifications,
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
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
          setState(() => {});
          carProvider.getCars(1, 10, '').then((value) => {
                setState(() {
                  // carProvider.loadingState = LoadingState.loading;
                  listCars = value.dataCar;
                  totalRecords = value.totalRecords;
                }),
              });
          brandProvider.getBrands().then((value) => {
                setState(() {
                  listBrands = value.dataBrand;
                }),
              });
        },
      );
    } else {
      return Builder(
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
                setState(() => {});
                // getDataCars();
                carProvider
                    .getCars(1, 10, textSearchController.text)
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
                      const SizedBox(height: 10),
                      SizedBox(
                        height: size.height * .22,
                        child: ListBrandWidget(
                          brandProvider: brandProvider,
                          listBrand: listBrands,
                          onTap: () {
                            setState(() {
                              search = search;
                            });
                            carProvider.getCars(1, 10, search).then((value) => {
                                  setState(() {
                                    listCars = value.dataCar;
                                    totalRecords = value.totalRecords;
                                  }),
                                });
                          },
                          widget: buildListBrand(size),
                        ),
                      ),
                      carProvider.loadingState == LoadingState.noDataFound
                          ? NoDataFoundWidget(
                              title: AppConfig.noOfferFound,
                              onTap: () {
                                setState(() {});
                                carProvider.getCars(1, 10, '').then((value) => {
                                      setState(() {
                                        // carProvider.loadingState = LoadingState.loading;
                                        expandedIndex = -1;
                                        listCars = value.dataCar;
                                        totalRecords = value.totalRecords;
                                      }),
                                    });
                              },
                            )
                          : ListCarsWidget(
                              listCars: listCars,
                              totalRecords: totalRecords,
                              isOffers: false,
                              listCarsById: _id,
                              onTap: () {
                                myLogs(listCars.length.toString(),
                                    "no data found  --------  loade more");
                                if (listCars.length == totalRecords) {
                                } else {
                                  myLogs(listCars.length.toString(),
                                      "Home  --------  loade more");
                                  getDataCarsProvider(pageNumber + 1);
                                }
                              },
                            ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
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
    carProvider.reloedListCars(pageNumber, 10, search).then(
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
        dismissDirection: DismissDirection.endToStart,
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        duration: const Duration(seconds: 5),
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
