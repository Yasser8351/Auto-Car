import 'package:flutter/material.dart';

import '../config/app_config.dart';

class ReyTryErrorWidget extends StatelessWidget {
  const ReyTryErrorWidget(
      {Key? key,
      required this.title,
      required this.onTap,
      this.isClear = false})
      : super(key: key);
  final String title;
  final Function() onTap;
  final bool isClear;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 22),
                ),
                const SizedBox(height: 40),
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
                      children: [
                        Icon(Icons.refresh, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          isClear ? AppConfig.viewAll : AppConfig.tryAgain,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
