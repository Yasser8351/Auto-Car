import 'package:flutter/material.dart';

import '../config/app_config.dart';

class SearchWidgetWithLogo extends StatelessWidget {
  const SearchWidgetWithLogo({Key? key, required this.onTap}) : super(key: key);
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Image.asset(
            AppConfig.autoCarLogo,
            height: size.height * .07,
            width: size.width * .5,
          ),
          GestureDetector(
            onTap: onTap,
            child: Image.asset(
              AppConfig.searchPng,
              height: size.height * .030,
              // width: size.width * .028,
              color: Colors.black,
            ),
          ),
          // GestureDetector(
          //   onTap: onTap,
          //   child: SvgPicture.asset(
          //     AppConfig.searchSvg,
          //     height: size.height * .028,
          //     width: size.width * .028,
          //     color: Colors.black,
          //   ),
          // ),
        ],
      ),
    );
  }
}
