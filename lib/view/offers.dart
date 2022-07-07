import 'package:auto_car/config/app_config.dart';
import 'package:flutter/material.dart';

class Offers extends StatelessWidget {
  const Offers({Key? key}) : super(key: key);
  static const routeName = AppConfig.offers;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        // appBar: AppBar(
        //   title: const Text(AppConfig.offers),
        // ),
        );
  }
}
