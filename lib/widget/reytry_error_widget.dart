import 'package:flutter/material.dart';

import '../config/app_config.dart';

class ReyTryErrorWidget extends StatelessWidget {
  const ReyTryErrorWidget({Key? key, required this.title, required this.onTap})
      : super(key: key);
  final title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title),
            const Icon(Icons.refresh),
            ElevatedButton(
                onPressed: () {
                  onTap;
                },
                child: const Text(AppConfig.tryAgain)),
            // ButtonConfirmCustom(
            //     title: AppConfig.tryAgain, color: Colors.black, onTap: () {})
          ],
        ),
      ),
    );
  }
}
