import 'package:auto_car/config/app_config.dart';
import 'package:auto_car/widget/list_cars_widget.dart';
import 'package:flutter/material.dart';

import '../widget/build_search_widget.dart';

class Offers extends StatelessWidget {
  const Offers({Key? key}) : super(key: key);
  static const routeName = AppConfig.offers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            SizedBox(height: 60),
            BuildSearchWidget(),
            SizedBox(height: 20),
            ListCarsWidget(listCars: [], isOffers: true),
          ],
        ),
      ),
    );
  }
}
