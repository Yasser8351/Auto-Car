import 'package:auto_car/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widget/card_with_image.dart';
import '../widget/list_brand_widget.dart';
import '../widget/list_cars_widget.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  static const routeName = AppConfig.home;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        height: size.height,
        color: const Color(0xffF8F8F8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(height: 50),
              buildTextTitleWidget(),
              const SizedBox(height: 20),
              buildSearchWidget(context),
              const SizedBox(height: 40),
              const ListBrandWidget(),
              const SizedBox(height: 40),
              const ListCarsWidget()
            ],
          ),
        ),
      ),
    );
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
