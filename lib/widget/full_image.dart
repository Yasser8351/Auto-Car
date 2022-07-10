import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FullImage extends StatelessWidget {
  String url;
  FullImage(this.url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: SizedBox(
        height: size.height * .60,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(url),
          //child: AssetImage(url.assetName),
        ),
      ),
    );
  }
}
