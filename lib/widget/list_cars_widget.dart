import 'dart:developer';

import 'package:auto_car/config/app_config.dart';
import 'package:auto_car/database/sqldb.dart';
import 'package:auto_car/model/car_model.dart';
import 'package:auto_car/view/details_screen.dart';
import 'package:flutter/material.dart';

import 'card_with_image.dart';

class ListCarsWidget extends StatefulWidget {
  const ListCarsWidget(
      {Key? key, required this.isOffers, required this.listCars})
      : super(key: key);
  final List<CarModel> listCars;
  final bool isOffers;

  @override
  State<ListCarsWidget> createState() => _ListCarsWidgetState();
}

class _ListCarsWidgetState extends State<ListCarsWidget> {
  SQLDatabase sqlDatabase = SQLDatabase();

  //String sqlInsertOffers = "insert into 'MyFavorite' ('title')";
  String sqlInsertOffers = "insert into 'MyFavorite' ('title,price,imageUrl')";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var height = size.height / 6 * widget.listCars.length;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(DetailsScreen.routeName);
      },
      child: SizedBox(
        height: height,
        child: GridView.builder(
            // physics: widget.isOffers
            //     ? const BouncingScrollPhysics()
            //     : const NeverScrollableScrollPhysics(),
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(10.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.5,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10),
            itemCount: widget.listCars.length,
            itemBuilder: (ctx, index) {
              var id = widget.listCars[index].id;
              var image = widget.listCars[index].image;
              var price = widget.listCars[index].price;
              var title = widget.listCars[index].title;
              var category = widget.listCars[index].rating!.rate.toString();
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      child: FadeInImage(
                        placeholder: const AssetImage(AppConfig.placeholder),
                        // image: AssetImage(AppConfig.imageCar),
                        image: NetworkImage(image!),
                        width: 120,
                        height: 120,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          title!,
                          overflow: TextOverflow.ellipsis,
                          style: AppConfig.textTitleListCars,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          category,
                          overflow: TextOverflow.ellipsis,
                          //style: AppConfig.textTitleListCars,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              Icons.favorite_border,
                              color: Colors.white,
                              size: 23,
                            ),
                            colors: Colors.black,
                            onTap: () async {
                              // log(id.toString());
                              sqlDatabase
                                  .insertData(
                                    "INSERT INTO 'MyFavorite' ('id','title','price','imageUrl') VALUES ('$id','$title','${price.toString()}','$image')",
                                  )
                                  .then(
                                    (value) => {
                                      log("value " + value.toString()),
                                      if (value == 1)
                                        {
                                          toastMessage(
                                              AppConfig.itemAleradyInFaverite)
                                        }
                                      else
                                        {
                                          toastMessage(AppConfig
                                              .addDataFavoritesSuccessfully)
                                        },
                                    },
                                  );
                            },
                          ),
                        ],
                      ),
                    ),
                    widget.isOffers
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "\$$price",
                                style: const TextStyle(
                                    decoration: TextDecoration.lineThrough),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              );
            }),
      ),
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
