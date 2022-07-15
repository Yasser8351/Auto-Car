import 'package:auto_car/config/app_config.dart';
import 'package:auto_car/debugger/my_debuger.dart';
import 'package:auto_car/provider/car_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../enum/all_enum.dart';
import '../model/car_model.dart';
import '../widget/build_search_widget.dart';
import '../widget/list_brand_widget.dart';
import '../widget/list_cars_widget.dart';
import '../widget/loading_widget.dart';
import '../widget/reytry_error_widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static const routeName = AppConfig.home;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late CarProvider carProvider;
  List<CarModel> listCars = [];

  @override
  void initState() {
    carProvider = Provider.of<CarProvider>(context);
    carProvider.getCars().then((value) => {
          listCars = value.data,
          myLog("Home Screen", "${listCars.length}", value.toString())
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (carProvider.loadingState == LoadingState.initial ||
        carProvider.loadingState == LoadingState.loading) {
      return const LoadingWidget(
          msg: AppConfig.loading, msgColor: Colors.red, color: Colors.black);
    } else if (carProvider.loadingState == LoadingState.error) {
      return const ReyTryErrorWidget(title: AppConfig.somthingWrong);
    } else if (carProvider.loadingState == LoadingState.noDataFound) {
      return const ReyTryErrorWidget(title: AppConfig.noDataFound);
    } else {
      return SingleChildScrollView(
        child: Container(
          height: size.height * 2.1,
          color: const Color(0xffF8F8F8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(height: 50),
                buildTextTitleWidget(),
                const SizedBox(height: 20),
                const BuildSearchWidget(),
                const SizedBox(height: 40),
                const ListBrandWidget(),
                const SizedBox(height: 40),
                ListCarsWidget(listCars: listCars, isOffers: false)
              ],
            ),
          ),
        ),
      );
    }
  }
}

buildTextTitleWidget() {
  return const Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Text(
        AppConfig.findYourFavertCar,
        style: AppConfig.textTitle,
      ),
    ),
  );
}

/*
buildSearchWidget(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Container(
        height: 50,
        width: size.width / 1.3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Icon(
                Icons.search,
                color: Colors.grey,
              ),
              SizedBox(width: 10),
              Text(
                AppConfig.findCar,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(width: 10),
      CardWithImage(
        height: 50,
        width: 50,
        child: Center(
          child: SvgPicture.asset(
            AppConfig.filter,
            height: 30,
            width: 30,
            color: Colors.white,
          ),
        ),
        colors: Colors.black,
        onTap: () {},
      ),
    ],
  );

}

*/