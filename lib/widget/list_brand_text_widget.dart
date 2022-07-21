import 'package:auto_car/config/app_style.dart';
import 'package:auto_car/model/brand_model.dart';
import 'package:flutter/material.dart';

import '../config/app_config.dart';

class ListBrandTextWidget extends StatefulWidget {
  const ListBrandTextWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ListBrandTextWidget> createState() => _ListBrandTextWidgetState();
}

class _ListBrandTextWidgetState extends State<ListBrandTextWidget> {
  int expandedIndex = -1;
  @override
  Widget build(BuildContext context) {
    List<BrandModel> listBrand = [
      BrandModel("سيدان", "سيدان"),
      BrandModel("تويوتا", "تويوتا"),
      BrandModel("فورد", "فورد"),
      BrandModel("نيسان", "نيسان"),
      BrandModel("سيدان", "سيدان"),
      BrandModel("تويوتا", "تويوتا"),
      BrandModel("فورد", "فورد"),
      BrandModel("نيسان", "نيسان"),
    ];
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 10),
                    scrollDirection: Axis.horizontal,
                    itemCount: listBrand.length,
                    itemBuilder: (context, index) {
                      //String image = listBrand[index].image;
                      String title = listBrand[index].title;
                      return GestureDetector(
                        onTap: (() {
                          setState(
                            () {
                              expandedIndex = index;
                            },
                          );
                        }),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: .5,
                                color: expandedIndex == index
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                title,
                                style: TextStyle(
                                  // color: Color.fromARGB(255, 139, 139, 145),
                                  color: expandedIndex == index
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(width: .5, color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          AppConfig.recentlyArrived,
                          style: AppStyle.textWhite,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        )
      ],
    );
  }
}
