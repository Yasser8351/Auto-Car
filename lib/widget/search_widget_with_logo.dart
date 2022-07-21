import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../config/app_config.dart';

class SearchWidgetWithLogo extends StatelessWidget {
  const SearchWidgetWithLogo({Key? key, required this.onTap}) : super(key: key);
  final Function() onTap;

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
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SvgPicture.asset(
              AppConfig.searchSvg,
              height: 22,
              width: 22,
              color: Colors.black,
            ),
            // child: Icon(Icons.search, size: 30),
          ),
        ),
      ],
    );
  }
}
