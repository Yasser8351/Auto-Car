import 'package:flutter/material.dart';

import '../config/app_config.dart';

class TitleAndDiscreipstionWidget extends StatelessWidget {
  const TitleAndDiscreipstionWidget({
    Key? key,
    required this.title,
    required this.discreption,
  }) : super(key: key);

  final String title;
  final String discreption;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            title,
            style: AppConfig.textTitle,
            textAlign: TextAlign.justify,
          ),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            discreption,
            style: AppConfig.textSpecifications,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
