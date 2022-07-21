import 'package:flutter/material.dart';

import '../config/app_config.dart';

class SearchWidgetWithLogo extends StatelessWidget {
  const SearchWidgetWithLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          AppConfig.logo,
          height: size.height * .05,
          width: size.width * .4,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Icon(Icons.search, size: 30),
        ),
      ],
    );
  }
}
