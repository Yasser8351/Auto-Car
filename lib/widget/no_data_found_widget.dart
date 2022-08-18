import 'package:flutter/material.dart';

import '../config/app_config.dart';

class NoDataFoundWidget extends StatelessWidget {
  const NoDataFoundWidget({Key? key, required this.title, required this.onTap})
      : super(key: key);
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: size.height * .1),
          Text(
            title,
            style: const TextStyle(fontSize: 22),
          ),
          SizedBox(height: size.height * .05),
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: size.width * .45,
              height: size.height * .06,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.refresh, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    AppConfig.tryAgain,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}