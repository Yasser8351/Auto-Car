import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../config/app_config.dart';

// ignore: must_be_immutable
class FullImage extends StatelessWidget {
  String url;
  FullImage(this.url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          alignment: Alignment.center,
          children: [
            CachedNetworkImage(
              width: double.infinity,
              height: size.height / 2.5,
              filterQuality: FilterQuality.low,
              imageUrl: url,
              fit: BoxFit.fill,
              placeholder: (context, url) => FadeInImage(
                placeholder: AssetImage(AppConfig.placeholder),
                image: AssetImage(AppConfig.placeholder),
                width: double.infinity,
                height: 120,
                fit: BoxFit.fill,
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            // Image.network(url),
            Image.asset(
              AppConfig.logo,
              height: size.height * .040,
              //color: Colors.white.withOpacity(1.8),
              // opacity: ,
              //  width: double.infinity,
              //color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
