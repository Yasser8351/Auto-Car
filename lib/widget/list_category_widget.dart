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
      child: Stack(children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          child: FadeInImage(
            placeholder: const AssetImage(AppConfig.placeholder),
            image: NetworkImage(listCategory.image!),
            width: size.width,
            height: size.height * .4,
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          top: 240,
          bottom: 0,
          child: Container(
            width: size.width,
            height: 120,
            color: const Color.fromARGB(75, 0, 0, 0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: Text(
                listCategory.price!.toString(),
                style: AppConfig.textStyle1,
                textAlign: TextAlign.end,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
