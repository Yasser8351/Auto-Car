import 'package:auto_car/config/app_config.dart';
import 'package:auto_car/model/brand_model.dart';
import 'package:auto_car/provider/brand_provider.dart';
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
      return Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Row(
            //       children: [
            //         Icon(CupertinoIcons.car_detailed),
            //         // Icon(Icons.bar_chart_rounded),
            //         SizedBox(width: size.width * .05),
            //         Text(
            //           AppConfig.brands,
            //           style: AppConfig.textTitle,
            //         ),
            //       ],
            //     ),
            //     TextButton(
            //       onPressed: () {
            //         Navigator.of(context).push(
            //           MaterialPageRoute(
            //             builder: (context) =>
            //                 BrandScreen(listBrands: widget.listBrand),
            //           ),
            //         );
            //       },
            //       child: Text(
            //         AppConfig.viewAll,
            //         style: AppConfig.textViewAll,
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(height: size.height * .028),

            widget.widget,
            // buildListBrand(size)
          ],
        ),
      );
    }
  }
}
