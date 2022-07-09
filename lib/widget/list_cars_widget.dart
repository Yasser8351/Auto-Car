import 'package:auto_car/config/app_config.dart';
import 'package:flutter/material.dart';

import 'card_with_image.dart';

class ListCarsWidget extends StatefulWidget {
  const ListCarsWidget({Key? key}) : super(key: key);

  @override
  State<ListCarsWidget> createState() => _ListCarsWidgetState();
}

class _ListCarsWidgetState extends State<ListCarsWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height / 2.2,
      child: GridView.builder(
        //physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(10.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.5,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10),
        itemCount: 10,
        itemBuilder: (ctx, index) => SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Column(
              children: [
                const ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: FadeInImage(
                    placeholder: AssetImage(AppConfig.placeholder),
                    image: AssetImage(AppConfig.imageCar),
                    // image: NetworkImage(
                    //   "https://www.nissanusa.com/content/dam/Nissan/us/homepage/hero/ariya/2023/2023-nissan-ariya-electric-crossover-suv.jpg",
                    // ),
                    width: 200,
                    height: 110,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Nican",
                      overflow: TextOverflow.ellipsis,
                      style: AppConfig.textTitleListCars,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "1500",
                          style: AppConfig.textTitle,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const CardWithImage(
                            height: 40,
                            width: 40,
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            )),
                      ),

                      // IconButton(
                      //     icon: const Icon(Icons.shopping_cart),
                      //     onPressed: () {
                      //       // cart.addItem(
                      //       //   list[index].id.toString(),
                      //       //   list[index].name,
                      //       //   double.parse(list[index].price),
                      //       // );
                      //       ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      //       ScaffoldMessenger.of(context).showSnackBar(
                      //         SnackBar(
                      //           content: const Text("تم اضافة المنتج الي السلة"),
                      //           duration: const Duration(seconds: 2),
                      //           action: SnackBarAction(
                      //             label: "إلغاء",
                      //             onPressed: () {
                      //               // cart.cancelOrder(list[index].id.toString());
                      //             },
                      //           ),
                      //         ),
                      //       );
                      //     },
                      //     color: Theme.of(context).primaryColor),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
