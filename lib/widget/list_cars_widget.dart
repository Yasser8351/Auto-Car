//This comment is Contents List Cars With Painated using flutter 3.0.2 SDK
/*
import 'dart:developer';

import 'package:auto_car/config/app_config.dart';
import 'package:auto_car/database/sqldb.dart';
import 'package:auto_car/model/car_model.dart';
import 'package:auto_car/provider/car_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:paginated_list/paginated_list.dart';

import '../config/app_style.dart';
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
      required this.totalRecords,
      required this.carProvider})
      : super(key: key);
  final List<Datum> listCars;
  List<Map<String, dynamic>> listCarsById;
  final int totalRecords;
  final CarProvider carProvider;

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
        child: widget.totalRecords <= widget.listCars.length
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
        var image = widget.listCars[index].imageUrl;
        //var image = AppConfig.imageFromNetwork;
        var price = widget.listCars[index].price;
        var title = widget.listCars[index].brandModel.modelName;
        var year = widget.listCars[index].year.yearName;
        var youtupeLink = widget.listCars[index].ytLink;

        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => DetailsScreen(
                    listImageSliderCar: [],
                    title: title,
                    price: price,
                    offerId: id,
                    youtupeLink: youtupeLink,
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
                      filterQuality: FilterQuality.high,
                      height: size.height * .26,
                      fit: BoxFit.fill,
                      imageUrl: image,
                      placeholder: (context, url) => FadeInImage(
                        placeholder: AssetImage(AppConfig.placeholder),
                        image: AssetImage(AppConfig.placeholder),
                        width: double.infinity,
                        height: size.height * .2,
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
                          // updateFavorite
                          log("GestureDetector");
                          widget.carProvider.updateFavorite(
                              widget.listCars[index].id,
                              !widget.listCars[index].isFavorite);
                          insertData(id, title, price.toString(), image);
                        },
                        child: MyFavoriteButton(
                          iconSize: 35,
                          isFavorite: widget.listCars[index].isFavorite,
                          valueChanged: (_isFavorite) async {
                            if (_isFavorite) {
                              insertData(id, title, price.toString(), image);
                              widget.carProvider.updateFavorite(
                                  widget.listCars[index].id, true);
                            } else {
                              deleteData(id);
                              widget.carProvider.updateFavorite(
                                  widget.listCars[index].id, false);
                            }
                          },
                        ),
                      ),
                      colors: Theme.of(context).colorScheme.onSecondary,
                      onTap: () async {
                        // updateFavorite
                        log("GestureDetector");
                        widget.carProvider.updateFavorite(
                            widget.listCars[index].id,
                            !widget.listCars[index].isFavorite);
                        insertData(id, title, price.toString(), image);
                      },
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
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: Text(
                                      title,
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
          (value) => {},
        );
  }

  void insertData(String? id, String? title, String? price, String? image) {
    sqlDatabase
        .insertData(
          "INSERT INTO 'MyFavorite' ('id','title','price','imageUrl') VALUES ('$id','$title','${price.toString()}','$image')",
        )
        .then(
          (value) => {},
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
//This comment is Contents List Cars With Painated using flutter 3.0.2 SDK

import 'dart:developer';

import 'package:auto_car/config/app_config.dart';
import 'package:auto_car/database/sqldb.dart';
import 'package:auto_car/model/car_model.dart';
import 'package:auto_car/provider/car_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:paginated_list/paginated_list.dart';

import '../screen/details_screen.dart';
import 'my_favorite_button.dart';

// ignore: must_be_immutable
class ListCarsWidget extends StatefulWidget {
  ListCarsWidget(
      {Key? key,
      required this.isSearch,
      required this.isOffers,
      required this.listCars,
      required this.listCarsById,
      required this.onTap,
      required this.totalRecords,
      required this.carProvider})
      : super(key: key);
  final List<Datum> listCars;
  List<Map<String, dynamic>> listCarsById;
  final int totalRecords;
  final CarProvider carProvider;

  final bool isOffers;
  final bool isSearch;
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
      // padding: EdgeInsets.only(top: 10),
      shrinkWrap: true,
      loadingIndicator: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: widget.isSearch
            ? SizedBox()
            : widget.totalRecords <= widget.listCars.length
                ? SizedBox()
                : Center(
                    child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.background),
                  ),
      ),
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 0, left: 10, right: 10),
      items: widget.listCars,
      isRecentSearch: false,
      isLastPage: false,
      onLoadMore: (index) {
        widget.onTap();
      },
      builder: (data, index) {
        var id = widget.listCars[index].id;
        var image = widget.listCars[index].imageUrl;
        //var image = AppConfig.imageFromNetwork;
        var currency = widget.listCars[index].currency;
        var price = widget.listCars[index].price;
        var title = widget.listCars[index].brandModel.modelName;
        var year = widget.listCars[index].year.yearName;
        var youtupeLink = widget.listCars[index].ytLink;

        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => DetailsScreen(
                    carModel: widget.listCars[index],
                    listImageSliderCar: [],
                    title: title,
                    price: price,
                    currency: currency.currencyName,
                    offerId: id,
                    youtupeLink: youtupeLink,
                  )),
            ));
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                // color: Theme.of(context).colorScheme.onSecondary,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Column(
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
                      filterQuality: FilterQuality.high,
                      height: size.height * .26,
                      fit: BoxFit.cover,
                      imageUrl: image,
                      placeholder: (context, url) => FadeInImage(
                        placeholder: AssetImage(AppConfig.placeholder),
                        image: AssetImage(AppConfig.placeholder),
                        width: double.infinity,
                        height: size.height * .2,
                        fit: BoxFit.fill,
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // CardWithImage(
                        //   height: size.height * .035,
                        //   width: size.width * .09,
                        //   child:
                        GestureDetector(
                          onTap: () async {
                            // updateFavorite
                            log("GestureDetector");
                            widget.carProvider.updateFavorite(
                                widget.listCars[index].id,
                                !widget.listCars[index].isFavorite);
                            insertData(id, title, price.toString(), image);
                          },
                          child: MyFavoriteButton(
                            iconSize: size.height * .04,
                            isFavorite: widget.listCars[index].isFavorite,
                            valueChanged: (_isFavorite) async {
                              if (_isFavorite) {
                                insertData(id, title, price.toString(), image);
                                widget.carProvider.updateFavorite(
                                    widget.listCars[index].id, true);
                              } else {
                                deleteData(id);
                                widget.carProvider.updateFavorite(
                                    widget.listCars[index].id, false);
                              }
                            },
                          ),
                        ),
                        // colors: Theme.of(context).colorScheme.onSecondary,
                        // onTap: () async {
                        //   // updateFavorite
                        //   log("GestureDetector");
                        //   widget.carProvider.updateFavorite(
                        //       widget.listCars[index].id,
                        //       !widget.listCars[index].isFavorite);
                        //   insertData(id, title, price.toString(), image);
                        // },

                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 15),
                        //   child: Text(
                        //     "${currency.currencyName} $price",
                        //     textAlign: TextAlign.left,
                        //     style: TextStyle(
                        //         color: Colors.white,
                        //         fontSize: size.width * .065,
                        //         fontWeight: FontWeight.normal),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "$title",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: size.width * .065,
                            fontWeight: FontWeight.normal),
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
          (value) => {},
        );
  }

  void insertData(String? id, String? title, String? price, String? image) {
    sqlDatabase
        .insertData(
          "INSERT INTO 'MyFavorite' ('id','title','price','imageUrl') VALUES ('$id','$title','${price.toString()}','$image')",
        )
        .then(
          (value) => {},
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
