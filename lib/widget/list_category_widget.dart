import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../model/category_model.dart';

class ListCategoryWidget extends StatelessWidget {
  const ListCategoryWidget(
      {Key? key, required this.listCategory, required this.size})
      : super(key: key);
  final CategoryModel listCategory;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Stack(
        children: [
          // ClipRRect(
          //   borderRadius: const BorderRadius.only(
          //       topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          //   child: FadeInImage(
          //     placeholder: const AssetImage(AppConfig.placeholder),
          //     //image: const AssetImage(AppConfig.cars),
          //     image: NetworkImage(listCategory.imgPath),
          //     width: size.width,
          //     height: size.height * .3,
          //     fit: BoxFit.fill,
          //   ),
          // ),
          FadeInImage(
            placeholder: const AssetImage(AppConfig.placeholder),
            //image: const AssetImage(AppConfig.cars),
            image: NetworkImage(listCategory.imgPath),
            width: size.width,
            height: size.height * .3,
            fit: BoxFit.fitWidth,
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            child: Container(
              width: size.width,
              height: size.height,
              color: Colors.white30,
              child: Padding(
                padding: EdgeInsets.only(top: size.height * .2, left: 10),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        listCategory.typeName.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "10 Items",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
