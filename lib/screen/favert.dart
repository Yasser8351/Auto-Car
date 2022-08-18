import 'dart:developer';

import 'package:auto_car/config/app_config.dart';
import 'package:auto_car/config/app_style.dart';
import 'package:auto_car/database/sqldb.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../debugger/my_debuger.dart';
import '../widget/card_with_image.dart';
import '../widget/loading_widget.dart';
import 'details_screen.dart';

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
              padding: const EdgeInsets.only(top: 40),
              child: SizedBox(
                height: size.height,
                child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(10.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1 / 1.35,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10),
                    itemCount: listCars.length,
                    itemBuilder: (ctx, index) {
                      String id = listCars[index]['id'] ?? '';
                      String title = listCars[index]['title'] ?? '';
                      String image = listCars[index]['imageUrl'] ?? '';
                      String price = listCars[index]['price'] ?? '';

                      myLogs("id", id);
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
                                  filterQuality: FilterQuality.low,
                                  imageUrl: image,
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) => FadeInImage(
                                    placeholder:
                                        AssetImage(AppConfig.placeholder),
                                    image: AssetImage(AppConfig.placeholder),
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
                                padding: EdgeInsets.symmetric(horizontal: 7),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Picanto",
                                    // title,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppConfig.textTitleListCars,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 0),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 7),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        "\$$price",
                                        style: AppConfig.textTitle,
                                      ),
                                    ),
                                    CardWithImage(
                                      height: 35,
                                      width: 35,
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 23,
                                      ),
                                      colors: Colors.black,
                                      onTap: () {
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
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      );
                    }),
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
