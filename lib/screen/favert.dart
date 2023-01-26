import 'dart:developer';

import 'package:auto_car/config/app_config.dart';
import 'package:auto_car/config/app_style.dart';
import 'package:auto_car/database/sqldb.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../debugger/my_debuger.dart';
import '../widget/loading_widget.dart';

class Favert extends StatefulWidget {
  const Favert({Key? key}) : super(key: key);
  static const routeName = AppConfig.favert;

  @override
  State<Favert> createState() => _FavertState();
}

class _FavertState extends State<Favert> {
  List<Map> listCars = [];
  bool isOffers = false;
  bool isLoading = false;
  SQLDatabase sqlDatabase = SQLDatabase();

  @override
  void initState() {
    super.initState();
    isLoading = true;
    getDataFromSqfLite();

    myLogs("getDataFromSqfLite ", listCars);
  }

  Future<void> getDataFromSqfLite() async {
    listCars = await sqlDatabase.getData("SELECT * FROM 'MyFavorite'");

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() {
        isLoading = false;
      });
    });
    if (isLoading) {
      return const LoadingWidget(
          msg: AppConfig.loading, msgColor: Colors.black, color: Colors.black);
    } else {
      return listCars.isEmpty
          ? const Center(
              child: Text(
                AppConfig.noDataInFaverite,
                style: AppStyle.textStyle2,
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SizedBox(
                height: size.height,
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Image.asset(
                      AppConfig.logoSplash,
                      height: MediaQuery.of(context).size.height * .14,
                      width: MediaQuery.of(context).size.width * .7,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppConfig.faverts,
                          overflow: TextOverflow.ellipsis,
                          style: AppConfig.textTitleListCars2,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(10.0),
                        itemCount: listCars.length,
                        shrinkWrap: true,
                        itemBuilder: (ctx, index) {
                          String id = listCars[index]['id'] ?? '';
                          String title = listCars[index]['title'] ?? '';
                          String image = listCars[index]['imageUrl'] ?? '';
                          String price = listCars[index]['price'] ?? '';
                          String youtupeLink = '';

                          myLogs("id", id);
                          return GestureDetector(
                            onTap: () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //   builder: ((context) => DetailsScreen(
                              //     carModel: ,
                              //         listImageSliderCar: [],
                              //         title: title,
                              //         currency: '',
                              //         price: price,
                              //         offerId: id,
                              //         youtupeLink: youtupeLink,
                              //       )),
                              // ));
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    child: CachedNetworkImage(
                                      width: double.infinity,
                                      height: 120,
                                      filterQuality: FilterQuality.high,
                                      imageUrl: image,
                                      fit: BoxFit.fill,
                                      placeholder: (context, url) =>
                                          FadeInImage(
                                        placeholder:
                                            AssetImage(AppConfig.placeholder),
                                        image:
                                            AssetImage(AppConfig.placeholder),
                                        width: double.infinity,
                                        height: 120,
                                        fit: BoxFit.fill,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                  // const ClipRRect(
                                  //   borderRadius: BorderRadius.only(
                                  //       topLeft: Radius.circular(10),
                                  //       topRight: Radius.circular(10)),
                                  //   child: FadeInImage(
                                  //     placeholder:
                                  //         AssetImage(AppConfig.placeholder),
                                  //     image: AssetImage(AppConfig.imageCar),
                                  //     //image: NetworkImage(image!),
                                  //     width: double.infinity,
                                  //     height: 120,
                                  //     fit: BoxFit.fill,
                                  //   ),
                                  // ),
                                  const SizedBox(height: 15),

                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 7),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '',
                                        overflow: TextOverflow.ellipsis,
                                        //style: AppConfig.textTitleListCars,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Text(
                                                title,
                                                style: TextStyle(
                                                  fontSize: 22,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Text(
                                                "2022",
                                                style: TextStyle(
                                                  fontSize: 22,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .error,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            IconButton(
                                              icon: Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                                size: 23,
                                              ),
                                              // colors: Colors.black,
                                              onPressed: () {
                                                sqlDatabase
                                                    .deleteData(
                                                        "Delete FROM 'MyFavorite' where id LIKE '$id' ")
                                                    .then(
                                                      (value) => {
                                                        log(value.toString()),
                                                        if (value == 1)
                                                          {
                                                            // toastMessage(AppConfig
                                                            //     .deleteDataFavoritesSuccessfully)
                                                          }
                                                        else
                                                          {
                                                            // toastMessage(AppConfig
                                                            //     .deleteDataFavoritesSuccessfully)
                                                          },
                                                        getDataFromSqfLite(),
                                                      },
                                                    );
                                              },
                                            ),
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Text(
                                                "\$$price",
                                                style: TextStyle(
                                                  fontSize: 22,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),

                                  isOffers
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "\$$price",
                                              style: const TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            );
    }
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
