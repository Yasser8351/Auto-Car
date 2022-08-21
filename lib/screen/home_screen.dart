import 'package:auto_car/config/app_config.dart';
import 'package:auto_car/debugger/my_debuger.dart';
import 'package:auto_car/model/brand_model.dart';
import 'package:auto_car/provider/brand_provider.dart';
import 'package:auto_car/provider/car_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../enum/all_enum.dart';
import '../model/car_model.dart';
import '../widget/list_brand_widget.dart';
import '../widget/list_cars_widget.dart';
import '../widget/loading_widget.dart';
import '../widget/reytry_error_widget.dart';
import '../widget/search_widget_with_logo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.userId}) : super(key: key);
  static const routeName = AppConfig.home;

  final userId;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late BrandProvider brandProvider;
  late CarProvider carProvider;
  bool isSearch = false;

  String search = '';
  int expandedIndex = -1;

  List<BrandsModel> listBrands = [];
  List<Datum> listCars = [];

  @override
  void initState() {
    brandProvider = Provider.of<BrandProvider>(context, listen: false);
    carProvider = Provider.of<CarProvider>(context, listen: false);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    listBrands = Provider.of<BrandProvider>(context, listen: true).listBrands;
    listCars = Provider.of<CarProvider>(context, listen: true).listCars;
    myLogs("listCars", listCars.length);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    //brandProvider

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
        onTap: () {},
      );
    } else {
      if (brandProvider.loadingState == LoadingState.initial ||
          brandProvider.loadingState == LoadingState.loading) {
        return LoadingWidget(
          msg: AppConfig.loading,
          msgColor: Theme.of(context).colorScheme.onSecondary,
          color: Theme.of(context).colorScheme.onBackground,
        );
      } else if (brandProvider.loadingState == LoadingState.error) {
        return ReyTryErrorWidget(
          title: brandProvider.apiResponse.message,
          onTap: () {},
        );
      } else {
        return Scaffold(
          body: Container(
            color: const Color(0xffF8F8F8),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    SearchWidgetWithLogo(
                      onTap: () {
                        setState(() => isSearch = !isSearch);
                      },
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: size.height * .22,
                      child: ListBrandWidget(
                        brandProvider: brandProvider,
                        listBrand: listBrands,
                        onTap: () {},
                        widget: buildListBrand(size, search, expandedIndex),
                      ),
                    ),
                    ListCarsWidget(
                      listCars: listCars,
                      totalRecords: 12,
                      isOffers: false,
                      listCarsById: [],
                      onTap: () {
                        myLogs(listCars.length.toString(),
                            "no data found  --------  loade more");
                        if (listCars.length == 12) {
                        } else {
                          myLogs(listCars.length.toString(),
                              "Home  --------  loade more");
                          carProvider.getCars(2, 10, search);
                          listBrands.addAll(listBrands);
                          //getDataCarsProvider(pageNumber + 1);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    }
  }

  SizedBox buildListBrand(Size size, String search, int expandedIndex) {
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
              },
              child: Padding(
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
}
/* 

    if (brandProvider.loadingState == LoadingState.initial ||
        brandProvider.loadingState == LoadingState.loading) {
      return LoadingWidget(
        msg: AppConfig.loading,
        msgColor: Theme.of(context).colorScheme.onSecondary,
        color: Theme.of(context).colorScheme.onBackground,
      );
    } else if (brandProvider.loadingState == LoadingState.error) {
      return ReyTryErrorWidget(
        title: brandProvider.apiResponse.message,
        onTap: () {
          setState(() => {});
          brandProvider.getCars(1, 10, '').then((value) => {
                setState(() {
                  // brandProvider.loadingState = LoadingState.loading;
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
                brandProvider
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
                            brandProvider.getCars(1, 10, search).then((value) => {
                                  setState(() {
                                    listCars = value.dataCar;
                                    totalRecords = value.totalRecords;
                                  }),
                                });
                          },
                          widget: buildListBrand(size),
                        ),
                      ),
                      brandProvider.loadingState == LoadingState.noDataFound
                          ? NoDataFoundWidget(
                              title: AppConfig.noOfferFound,
                              onTap: () {
                                setState(() {});
                                brandProvider.getCars(1, 10, '').then((value) => {
                                      setState(() {
                                        // brandProvider.loadingState = LoadingState.loading;
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
                                      "HomeScreen  --------  loade more");
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
    brandProvider.reloedListCars(pageNumber, 10, search).then(
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
 */