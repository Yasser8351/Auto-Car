import 'package:auto_car/config/app_config.dart';
import 'package:auto_car/model/brand_model.dart';
import 'package:flutter/material.dart';

class ListBrandWidget extends StatelessWidget {
  const ListBrandWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<BrandModel> listBrand = [
      BrandModel("Mercedes", AppConfig.mercedes),
      BrandModel("Audi", AppConfig.audi),
      BrandModel("Tesla", AppConfig.tesla),
      BrandModel("Nissan", AppConfig.nissan),
      BrandModel("Ferrari", AppConfig.mercedes),
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
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listBrand.length,
            itemBuilder: (context, index) {
              String image = listBrand[index].image;
              String title = listBrand[index].title;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Image.asset(
                          image,
                          color: Colors.black,
                          fit: BoxFit.cover,
                          height: 40,
                          width: 40,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      title,
                      style: AppConfig.textSpecifications,
                    )
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
