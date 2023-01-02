import 'package:auto_car/model/offer_details_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../config/app_config.dart';

// ignore: must_be_immutable
class FullImage extends StatelessWidget {
  String url;
  List<ImageGallary> listImageGallary;
  FullImage({Key? key, required this.url, required this.listImageGallary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CarouselSlider(
          items: listImageGallary
              .map(
                (e) => GestureDetector(
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: ((context) =>
                    //         FullImage(e.filePath, listImageGallary))));
                  },
                  child: Stack(
                    children: [
                      Center(
                        child: CachedNetworkImage(
                          width: size.width * 2,
                          fit: BoxFit.contain,
                          height: size.width,
                          filterQuality: FilterQuality.high,
                          imageUrl: e.filePath.toString(),
                          placeholder: (context, url) => FadeInImage(
                            placeholder: AssetImage(AppConfig.placeholder),
                            image: AssetImage(AppConfig.placeholder),
                            width: double.infinity,
                            height: 120,
                            fit: BoxFit.fill,
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      // Positioned(
                      //   top: 170,
                      //   left: 100,
                      //   right: 100,
                      //   child: Image.asset(
                      //     AppConfig.logo,
                      //     height: 20,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              )
              .toList(),
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              // setState(() {
              //   activeIndex = index;
              // });
            },
            height: 400,
            aspectRatio: 16 / 9,
            viewportFraction: 1.01,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            scrollDirection: Axis.horizontal,
            disableCenter: true,
          ),
        ),

        // child: Stack(
        //   alignment: Alignment.center,
        //   children: [
        //     CachedNetworkImage(
        //       width: double.infinity,
        //       height: size.height / 2.5,
        //       filterQuality: FilterQuality.high,
        //       imageUrl: url,
        //       fit: BoxFit.fill,
        //       placeholder: (context, url) => Center(
        //         child: FadeInImage(
        //           placeholder: AssetImage(AppConfig.placeholder),
        //           image: AssetImage(AppConfig.placeholder),
        //           width: double.infinity,
        //           height: double.infinity,
        //           // fit: BoxFit.contain,
        //         ),
        //       ),
        //       errorWidget: (context, url, error) => Icon(Icons.error),
        //     ),
        //     // Image.network(url),
        //     Image.asset(
        //       AppConfig.logo,
        //       height: size.height * .040,
        //       //color: Colors.white.withOpacity(1.8),
        //       // opacity: ,
        //       //  width: double.infinity,
        //       //color: Colors.white,
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
