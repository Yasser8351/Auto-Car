import 'package:auto_car/config/app_style.dart';
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
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            child: FadeInImage(
              placeholder: const AssetImage(AppConfig.placeholder),
              //image: const AssetImage(AppConfig.cars),
              image: NetworkImage(listCategory.imgPath),
              width: size.width,
              height: size.height * .3,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: 160,
            bottom: 0,
            left: 0,
            child: Container(
              width: size.width,
              height: 120,
              color: Colors.white60,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                child: Text(
                  //"سيارة بيكاب",
                  listCategory.typeName.toString(),
                  style: AppStyle.textBlack25,
                  textAlign: TextAlign.end,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
