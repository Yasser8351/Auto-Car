//This comment is Contents List Cars With Painated using flutter 3.0.2 SDK

import 'package:auto_car/config/app_config.dart';
import 'package:auto_car/database/sqldb.dart';
import 'package:auto_car/model/car_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:paginated_list/paginated_list.dart';

import '../config/app_style.dart';
import '../debugger/my_debuger.dart';
import '../screen/details_screen.dart';
import 'card_with_image.dart';
import 'my_favorite_button.dart';

// ignore: must_be_immutable
class ListCarsWidget extends StatefulWidget {
  ListCarsWidget(
      {Key? key,
      required this.isOffers,
      required this.listCars,
      required this.listCarsById,
      required this.onTap,
      required this.totalRecords})
      : super(key: key);
  final List<Datum> listCars;
  List<Map<String, dynamic>> listCarsById;
  final int totalRecords;

  final bool isOffers;
  final Function() onTap;

  @override
  State<ListCarsWidget> createState() => _ListCarsWidgetState();
}

class _ListCarsWidgetState extends State<ListCarsWidget> {
  SQLDatabase sqlDatabase = SQLDatabase();

  String sqlInsertOffers = "insert into 'MyFavorite' ('title,price,imageUrl')";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return PaginatedList(
      shrinkWrap: true,
      loadingIndicator: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: widget.totalRecords == widget.listCars.length
            ? SizedBox()
            : Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.background),
              ),
      ),
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      items: widget.listCars,
      isRecentSearch: false,
      isLastPage: false,
      onLoadMore: (index) {
        widget.onTap();
      },
      builder: (data, index) {
        var id = widget.listCars[index].id;
        var image =
            'http://207.180.223.113:8975/Resources/Images/210bd027-d020-4c0e-8fa0-f1b951c8fcc7_jannis-lucas-jBmNhftLcrY-unsplash.jpg'; // var image = widget.listCars[index].brandModel.brand.logoPath;
        var price = widget.listCars[index].price;
        var title = widget.listCars[index].brandModel.modelName;
        var year = widget.listCars[index].year.yearName;

        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => DetailsScreen(
                    listImageSliderCar: [],
                    title: title,
                    price: price,
                    offerId: id,
                  )),
            ));
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSecondary,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    child: CachedNetworkImage(
                      width: double.infinity,
                      filterQuality: FilterQuality.low,
                      height: 220,
                      fit: BoxFit.fill,
                      imageUrl: image,
                      placeholder: (context, url) => FadeInImage(
                        placeholder: AssetImage(AppConfig.placeholder),
                        image: AssetImage(AppConfig.placeholder),
                        width: double.infinity,
                        height: 120,
                        fit: BoxFit.fill,
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: CardWithImage(
                      height: 35,
                      width: 35,
                      child: GestureDetector(
                        onTap: () async {
                          insertData(id, title, price.toString(), image);
                        },
                        child: MyFavoriteButton(
                          iconSize: 35,
                          isFavorite: id == widget.listCarsById ? true : false,
                          valueChanged: (_isFavorite) async {
                            if (_isFavorite) {
                              insertData(id, title, price.toString(), image);
                            } else {
                              deleteData(id);
                            }
                          },
                        ),
                      ),
                      colors: Theme.of(context).colorScheme.onSecondary,
                      onTap: () {},
                    ),
                  ),
                  Positioned(
                    // top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        //color: Color.fromARGB(15, 0, 0, 0),
                        // color: Colors.black38,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      width: size.width,
                      height: 90,
                      child: Image.asset(AppConfig.background10),
                    ),
                  ),
                  Positioned(
                    // top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      width: size.width,
                      height: 90,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: CardDecoration(
                                        height: 35,
                                        width: 50,
                                        child: Text(
                                          year.toString(),
                                          style: AppStyle.textWhite24,
                                        ),
                                        colors: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                        onTap: () {}),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: SizedBox(),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Text(
                                      "\$$price",
                                      style: AppStyle.textWhite24,
                                    ),
                                    // child: Text(
                                    //   "\$$price",
                                    //   style: AppStyle.textWhite24,
                                    // ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: Text(
                                      title,
                                      // "فورد بيكاب",
                                      style: AppStyle.textWhite24,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    /**/
  }

  void deleteData(String id) {
    sqlDatabase
        .deleteData("Delete FROM 'MyFavorite' where id LIKE '$id' ")
        .then(
          (value) => {
            if (value == 1)
              {toastMessage(AppConfig.deleteDataFavoritesSuccessfully)}
            else
              {toastMessage(AppConfig.deleteDataFavoritesSuccessfully)},
          },
        );
  }

  void findIdInFavert(int index) {
    for (var map in widget.listCarsById) {
      if (map.containsKey("id")) {
        if (map["id"] == index) {
          myLogs("id = ", index);
        } else {}
        myLogs("id", "is not in favert");
      }
    }
  }

  void insertData(String? id, String? title, String? price, String? image) {
    sqlDatabase
        .insertData(
          "INSERT INTO 'MyFavorite' ('id','title','price','imageUrl') VALUES ('$id','$title','${price.toString()}','$image')",
        )
        .then(
          (value) => {
            // if (value == 1)
            //   {toastMessage(AppConfig.itemAleradyInFaverite)}
            // else
            //   {toastMessage(AppConfig.addDataFavoritesSuccessfully)},
          },
        );
  }

  void toastMessage(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

//This comment is Contents List Cars With Painated using flutter 3.0.2 SDK
/*
import 'package:auto_car/config/app_config.dart';
import 'package:auto_car/database/sqldb.dart';
import 'package:auto_car/model/car_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:paginated_list/paginated_list.dart';
import '../config/app_style.dart';
import '../debugger/my_debuger.dart';
import '../screen/details_screen.dart';
import 'card_with_image.dart';
import 'my_favorite_button.dart';

// ignore: must_be_immutable
class ListCarsWidget extends StatefulWidget {
  ListCarsWidget(
      {Key? key,
      required this.isOffers,
      required this.listCars,
      required this.listCarsById,
      required this.onTap,
      required this.totalRecords})
      : super(key: key);
  final List<Datum> listCars;
  List<Map<String, dynamic>> listCarsById;
  final int totalRecords;

  final bool isOffers;
  final Function() onTap;

  @override
  State<ListCarsWidget> createState() => _ListCarsWidgetState();
}

class _ListCarsWidgetState extends State<ListCarsWidget> {
  SQLDatabase sqlDatabase = SQLDatabase();

  String sqlInsertOffers = "insert into 'MyFavorite' ('title,price,imageUrl')";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return PaginatedList(
      shrinkWrap: true,
      loadingIndicator: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: widget.totalRecords == widget.listCars.length
            ? SizedBox()
            : Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.background),
              ),
      ),
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      items: widget.listCars,
      isRecentSearch: false,
      isLastPage: false,
      onLoadMore: (index) {
        widget.onTap();
      },
      builder: (data, index) {
        var id = widget.listCars[index].id;
        var image = widget.listCars[index].brandModel.brand.logoPath;
        var price = widget.listCars[index].price;
        var title = widget.listCars[index].brandModel.modelName;
        var year = widget.listCars[index].year.yearName;
        // List<ImageGallary> listImageGallaries =
        //     widget.listCars[index].imageGallaries;

        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => DetailsScreen(
                    listImageSliderCar: [],
                    title: title,
                    price: price,
                    offerId: id,
                  )),
            ));
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSecondary,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    child: CachedNetworkImage(
                      width: double.infinity,
                      filterQuality: FilterQuality.low,
                      height: 220,
                      fit: BoxFit.fill,
                      imageUrl: image,
                      placeholder: (context, url) => FadeInImage(
                        placeholder: AssetImage(AppConfig.placeholder),
                        image: AssetImage(AppConfig.placeholder),
                        width: double.infinity,
                        height: 120,
                        fit: BoxFit.fill,
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: CardWithImage(
                      height: 35,
                      width: 35,
                      child: GestureDetector(
                        onTap: () async {
                          insertData(id, title, price.toString(), image);
                        },
                        child: MyFavoriteButton(
                          iconSize: 35,
                          isFavorite: id == widget.listCarsById ? true : false,
                          valueChanged: (_isFavorite) async {
                            if (_isFavorite) {
                              insertData(id, title, price.toString(), image);
                            } else {
                              deleteData(id);
                            }
                          },
                        ),
                      ),
                      colors: Theme.of(context).colorScheme.onSecondary,
                      onTap: () {},
                    ),
                  ),
                  Positioned(
                    // top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        //color: Color.fromARGB(15, 0, 0, 0),
                        // color: Colors.black38,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      width: size.width,
                      height: 90,
                      child: Image.asset(AppConfig.background10),
                    ),
                  ),
                  Positioned(
                    // top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      width: size.width,
                      height: 90,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: CardDecoration(
                                        height: 35,
                                        width: 50,
                                        child: Text(
                                          year.toString(),
                                          style: AppStyle.textWhite24,
                                        ),
                                        colors: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                        onTap: () {}),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: SizedBox(),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Text(
                                      "\$$price",
                                      style: AppStyle.textWhite24,
                                    ),
                                    // child: Text(
                                    //   "\$$price",
                                    //   style: AppStyle.textWhite24,
                                    // ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: Text(
                                      title,
                                      // "فورد بيكاب",
                                      style: AppStyle.textWhite24,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void deleteData(String id) {
    sqlDatabase
        .deleteData("Delete FROM 'MyFavorite' where id LIKE '$id' ")
        .then(
          (value) => {
            if (value == 1)
              {toastMessage(AppConfig.deleteDataFavoritesSuccessfully)}
            else
              {toastMessage(AppConfig.deleteDataFavoritesSuccessfully)},
          },
        );
  }

  void findIdInFavert(int index) {
    for (var map in widget.listCarsById) {
      if (map.containsKey("id")) {
        if (map["id"] == index) {
          myLogs("id = ", index);
        } else {}
        myLogs("id", "is not in favert");
      }
    }
  }

  void insertData(String? id, String? title, String? price, String? image) {
    sqlDatabase
        .insertData(
          "INSERT INTO 'MyFavorite' ('id','title','price','imageUrl') VALUES ('$id','$title','${price.toString()}','$image')",
        )
        .then(
          (value) => {
            // if (value == 1)
            //   {toastMessage(AppConfig.itemAleradyInFaverite)}
            // else
            //   {toastMessage(AppConfig.addDataFavoritesSuccessfully)},
          },
        );
  }

  void toastMessage(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
*/