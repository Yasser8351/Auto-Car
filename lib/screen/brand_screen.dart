import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../model/brand_model.dart';

class BrandScreen extends StatefulWidget {
  const BrandScreen({Key? key, required this.listBrands}) : super(key: key);
  static const routeName = "BrandScreen";

  final List<BrandsModel> listBrands;

  @override
  State<BrandScreen> createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop("text");
        },
        child: Padding(
          padding: EdgeInsets.only(top: size.height * .032),
          child: Container(
            color: Theme.of(context).colorScheme.onSecondary,
            //color: Theme.of(context).colorScheme.onPrimary,
            height: size.height,
            width: size.width,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: GridView.builder(
                // physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(0.0),
                shrinkWrap: true,
                addAutomaticKeepAlives: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisExtent: 95,
                  childAspectRatio: .5,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                ),
                itemCount: widget.listBrands.length,
                itemBuilder: (ctx, index) {
                  // String title = widget.listBrands[index].nameAr;
                  String logo = widget.listBrands[index].logo;
                  return Container(
                    width: 200,
                    height: 40,
                    decoration: myBoxDecoration(context, index),
                    // color: Colors.white,
                    child: Center(
                      child: CachedNetworkImage(
                        imageUrl: logo,
                        width: 100,
                        height: 70,
                        fit: BoxFit.contain,
                        placeholder: (context, url) => FadeInImage(
                          placeholder: AssetImage(AppConfig.placeholder),
                          image: AssetImage(AppConfig.placeholder),
                        ),
                      ),
                    ),
                  );
                  // return Column(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Image.asset(
                  //       logo,
                  //       width: 100,
                  //       height: 100,
                  //     ),
                  //     buildDivider(),
                  //   ],
                  // );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

buildDivider() {
  return const Divider(
    height: 30,
  );
}

BoxDecoration myBoxDecoration(BuildContext context, int index) {
  index++;
  return BoxDecoration(
    color: Colors.white,
    border: Border(
      left: BorderSide(
        //                   <--- left side
        color: Theme.of(context).colorScheme.onPrimary,
        width: 1,
      ),
      top: BorderSide(
        //                   <--- bottm side
        color: Theme.of(context).colorScheme.onPrimary,
        width: 1,
      ),
    ),
  );
}
