import 'package:auto_car/widget/button_confirm_custom.dart';
import 'package:flutter/material.dart';

import '../config/app_config.dart';

class ReyTryErrorWidget extends StatelessWidget {
  const ReyTryErrorWidget({Key? key, required this.title}) : super(key: key);
  final title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Text(title),
          const Icon(Icons.refresh),
          ButtonConfirmCustom(
              title: AppConfig.tryAgain, color: Colors.black, onTap: () {})
        ],
      ),
    );
  }
}
