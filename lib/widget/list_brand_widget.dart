import 'package:auto_car/config/app_config.dart';
import 'package:auto_car/model/brand_model.dart';
import 'package:auto_car/provider/brand_provider.dart';
import 'package:auto_car/screen/brand_screen.dart';
import 'package:auto_car/widget/reytry_error_widget.dart';
import 'package:flutter/material.dart';

import '../enum/all_enum.dart';
import 'loading_widget.dart';

class ListBrandWidget extends StatefulWidget {
  const ListBrandWidget(
      {Key? key,
      required this.brandProvider,
      required this.listBrand,
      required this.onTap,
      required this.widget})
      : super(key: key);
  final BrandProvider brandProvider;
  final List<BrandsModel> listBrand;
  final Function() onTap;
  final Widget widget;

  @override
  State<ListBrandWidget> createState() => _ListBrandWidgetState();
}

class _ListBrandWidgetState extends State<ListBrandWidget> {
  int expandedIndex = -1;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

/*
    List<BrandsModel> listBrandLocal = [
      BrandsModel(
          id: "1", name: "Rover", nameAr: "Mercedes", logo: AppConfig.brand9),
      BrandsModel(id: "2", name: "BMW", nameAr: "Audi", logo: AppConfig.brand1),
      BrandsModel(
          id: "3", name: "Tesla", nameAr: "tesla", logo: AppConfig.brand2),
      BrandsModel(
          id: "4", name: "Ferrari", nameAr: "Nissan", logo: AppConfig.brand3),
      BrandsModel(
          id: "5", name: "Bugatti", nameAr: "Ferrari", logo: AppConfig.brand4),
      BrandsModel(
          id: "6",
          name: "Mercedes",
          nameAr: "Mercedes",
          logo: AppConfig.brand6),
      BrandsModel(
          id: "7", name: "Audi", nameAr: "Audi", logo: AppConfig.brand7),
      BrandsModel(
          id: "8", name: "tesla", nameAr: "tesla", logo: AppConfig.brand88),
      BrandsModel(
          id: "9", name: "Nissan", nameAr: "Nissan", logo: AppConfig.brand222),
      BrandsModel(
          id: "10",
          name: "Ferrari",
          nameAr: "Ferrari",
          logo: AppConfig.brand101),
      BrandsModel(
          id: "11",
          name: "Mercedes",
          nameAr: "Mercedes",
          logo: AppConfig.brand11),
      BrandsModel(
          id: "12", name: "Audi", nameAr: "Audi", logo: AppConfig.brand12),
      BrandsModel(
          id: "13", name: "tesla", nameAr: "tesla", logo: AppConfig.brand13),
      BrandsModel(
          id: "14", name: "Nissan", nameAr: "Nissan", logo: AppConfig.brand55),
      BrandsModel(
          id: "15",
          name: "Ferrari",
          nameAr: "Ferrari",
          logo: AppConfig.brand12),
      BrandsModel(
          id: "16",
          name: "Mercedes",
          nameAr: "Mercedes",
          logo: AppConfig.brand101),
      BrandsModel(
          id: "17", name: "Audi", nameAr: "Audi", logo: AppConfig.brand9),
      BrandsModel(
          id: "18", name: "tesla", nameAr: "tesla", logo: AppConfig.brand101),
      BrandsModel(
          id: "19", name: "Nissan", nameAr: "Nissan", logo: AppConfig.brand222),
      BrandsModel(
          id: "20", name: "Ferrari", nameAr: "Ferrari", logo: AppConfig.brand2),
      BrandsModel(
          id: "21",
          name: "Mercedes",
          nameAr: "Mercedes",
          logo: AppConfig.brand6),
      BrandsModel(id: "22", name: "Audi", nameAr: "Audi", logo: AppConfig.audi),
      BrandsModel(
          id: "23", name: "tesla", nameAr: "tesla", logo: AppConfig.brand4),
      BrandsModel(
          id: "24", name: "Nissan", nameAr: "Nissan", logo: AppConfig.brand55),
      BrandsModel(
          id: "25", name: "Ferrari", nameAr: "Ferrari", logo: AppConfig.brand3),
      BrandsModel(
          id: "26",
          name: "Mercedes",
          nameAr: "Mercedes",
          logo: AppConfig.brand2),
      BrandsModel(
          id: "27", name: "Audi", nameAr: "Audi", logo: AppConfig.brand3),
      BrandsModel(
          id: "28", name: "tesla", nameAr: "tesla", logo: AppConfig.brand222),
      BrandsModel(
          id: "27", name: "Audi", nameAr: "Audi", logo: AppConfig.brand1),
      BrandsModel(
          id: "28", name: "tesla", nameAr: "tesla", logo: AppConfig.brand7),
      BrandsModel(
          id: "27", name: "Audi", nameAr: "Audi", logo: AppConfig.brand101),
      BrandsModel(
          id: "28", name: "tesla", nameAr: "tesla", logo: AppConfig.tesla),
      BrandsModel(
          id: "27", name: "Audi", nameAr: "Audi", logo: AppConfig.brand4),
      BrandsModel(
          id: "283", name: "tesla", nameAr: "tesla", logo: AppConfig.brand6),
      BrandsModel(
          id: "27", name: "Audi", nameAr: "Audi", logo: AppConfig.brand88),
      BrandsModel(
          id: "282", name: "tesla", nameAr: "tesla", logo: AppConfig.brand55),
    ];
*/
    if (widget.brandProvider.loadingState == LoadingState.initial ||
        widget.brandProvider.loadingState == LoadingState.loading) {
      return LoadingWidget(
        msg: AppConfig.loading,
        msgColor: Theme.of(context).colorScheme.onSecondary,
        color: Theme.of(context).colorScheme.onBackground,
      );
    } else if (widget.brandProvider.loadingState == LoadingState.error) {
      return ReyTryErrorWidget(
        title: widget.brandProvider.apiResponse.message,
        onTap: () {
          setState(
              () => widget.brandProvider.loadingState = LoadingState.loading);
          widget.brandProvider.getBrands();
        },
      );
    } else if (widget.brandProvider.loadingState == LoadingState.noDataFound) {
      return ReyTryErrorWidget(
        title: AppConfig.noDataFound,
        onTap: () {
          setState(
              () => widget.brandProvider.loadingState = LoadingState.loading);
          widget.brandProvider.getBrands();
        },
      );
    } else {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          BrandScreen(listBrands: widget.listBrand),
                    ),
                  );
                },
                child: Text(
                  AppConfig.viewAll,
                  style: AppConfig.textViewAll,
                ),
              ),
              Text(
                AppConfig.brands,
                style: AppConfig.textTitle,
              ),
            ],
          ),
          SizedBox(height: size.height * .028),
          widget.widget,
          // buildListBrand(size)
        ],
      );
    }
  }

  /*
  
  SizedBox buildListBrand(Size size) {
    return SizedBox(
      height: size.height * .11,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.listBrand.length,
          itemBuilder: (context, index) {
            String logo = widget.listBrand[index].logo;
            String title = widget.listBrand[index].name;
            return GestureDetector(
              onTap: (() {
                setState(
                  () {
                    expandedIndex = index;
                  },
                );
              }),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //
                  children: [
                    // Container(
                    //   height: size.height * .07,
                    //   width: size.height * .07,
                    //   decoration: BoxDecoration(
                    //     color: expandedIndex == index
                    //         ? Colors.black
                    //         : Colors.white,
                    //     borderRadius: BorderRadius.circular(10),
                    //   ),
                    //   child: Center(
                    //     child: Image.asset(
                    //       logo,
                    //       //color: Colors.black,
                    //       fit: BoxFit.cover,
                    //       height: 40,
                    //       width: 40,
                    //     ),
                    //   ),
                    // ),
                    Container(
                      height: size.height * .07,
                      width: size.height * .07,
                      decoration: BoxDecoration(
                        color: expandedIndex == index
                            ? Colors.black
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: CachedNetworkImage(
                          width: size.width,
                          fit: BoxFit.contain,
                          height: 400,
                          filterQuality: FilterQuality.low,
                          imageUrl: logo,
                          //color: Colors.black,
                          placeholder: (context, url) => FadeInImage(
                            placeholder: AssetImage(AppConfig.placeholder),
                            image: AssetImage(AppConfig.placeholder),
                            width: double.infinity,
                            height: 120,
                            fit: BoxFit.fill,
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
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
              ),
            );
          },
        ),
      ),
    );
  }
  */

}
