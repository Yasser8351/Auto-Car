import 'package:auto_car/config/app_config.dart';
import 'package:auto_car/model/brand_model.dart';
import 'package:flutter/material.dart';

class ListBrandTextWidget extends StatelessWidget {
  const ListBrandTextWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<BrandModel> listBrand = [
      BrandModel("سيدان", "سيدان"),
      BrandModel("تويوتا", "تويوتا"),
      BrandModel("فورد", "فورد"),
      BrandModel("نيسان", "نيسان"),
    ];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              AppConfig.brands,
              style: AppConfig.textTitle,
            ),
            Text(
              AppConfig.viewAll,
              style: AppConfig.textViewAll,
            )
          ],
        ),
        const SizedBox(height: 40),
        SizedBox(
          height: 50,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              scrollDirection: Axis.horizontal,
              itemCount: listBrand.length,
              itemBuilder: (context, index) {
                //String image = listBrand[index].image;
                String title = listBrand[index].title;
                return Container(
                  decoration: BoxDecoration(
                    // color: const Color(0xffFD4C4C),
                    border: Border.all(
                      width: .5,
                    ),

                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          title,
                          style: AppConfig.textSpecifications,
                        )),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
