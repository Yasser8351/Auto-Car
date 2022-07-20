import 'package:auto_car/config/app_config.dart';
import 'package:auto_car/config/app_style.dart';
import 'package:auto_car/database/sqldb.dart';
import 'package:flutter/material.dart';

import '../widget/card_with_image.dart';
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
  SQLDatabase sqlDatabase = SQLDatabase();

  @override
  void initState() {
    super.initState();
    getDataFromSqfLite();
  }

  Future<void> getDataFromSqfLite() async {
    listCars = await sqlDatabase.getData("SELECT * FROM 'MyFavorite'");

    setState(() {});

    // myLog("Favert", "listCars", listCars.toString());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(DetailsScreen.routeName);
      },
      child: listCars.isEmpty
          ? const Center(
              child: Text(
                AppConfig.noDataInFaverite,
                style: AppStyle.textStyle2,
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 60),
              child: SizedBox(
                // height: isOffers ? size.height : size.height / 2.2,
                height: size.height,

                child: GridView.builder(
                    // physics: isOffers
                    //     ? const BouncingScrollPhysics()
                    //     : const NeverScrollableScrollPhysics(),
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(10.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1 / 1.5,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10),
                    itemCount: listCars.length,
                    itemBuilder: (ctx, index) {
                      int id = listCars[index]['id'] ?? 0;
                      String title = listCars[index]['title'] ?? '';
                      String image = listCars[index]['imageUrl'] ?? '';
                      String price = listCars[index]['price'] ?? '';

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
                              child: image.isEmpty
                                  ? Image.asset(AppConfig.placeholder)
                                  : FadeInImage(
                                      placeholder: const AssetImage(
                                          AppConfig.placeholder),
                                      //image: AssetImage(AppConfig.imageCar),
                                      image: NetworkImage(image),
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.fill,
                                    ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 7),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  title,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppConfig.textTitleListCars,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
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
                            const SizedBox(height: 10),
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
                                              "Delete FROM 'MyFavorite' where id = $id")
                                          .then(
                                            (value) => {
                                              if (value == 1)
                                                {
                                                  toastMessage(AppConfig
                                                      .deleteDataFavoritesSuccessfully)
                                                }
                                              else
                                                {
                                                  toastMessage(AppConfig
                                                      .deleteDataFavoritesSuccessfully)
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
                      );
                    }),
              ),
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
