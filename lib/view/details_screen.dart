import 'package:auto_car/widget/button_confirm_custom.dart';
import 'package:auto_car/widget/full_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../config/app_config.dart';
import '../model/image_slider_car_model.dart';
import '../model/specifications_model.dart';
import '../widget/card_with_image.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);
  static const routeName = "DetailsScreen";

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<SpecificationsModel> listSpecifications = [
    SpecificationsModel("تكييف"),
    SpecificationsModel("جنوط المونيوم"),
    SpecificationsModel("نظام الحماية"),
    SpecificationsModel("نظام تثبيت السرعة"),
    SpecificationsModel("حساسات"),
    SpecificationsModel("بلوتوث"),
    SpecificationsModel("دخول بدون مفتاح"),
    SpecificationsModel("مرايات كهربائية"),
    SpecificationsModel("سنترلوك"),
    SpecificationsModel("راديو"),
  ];

  List<ImageSliderCarModel> listImageSliderCar = [
    ImageSliderCarModel(AppConfig.imageCar),
    ImageSliderCarModel(AppConfig.imageCar2),
    ImageSliderCarModel(AppConfig.imageCar3),
    ImageSliderCarModel(AppConfig.imageCar4),
    ImageSliderCarModel(AppConfig.imageCar5),
    ImageSliderCarModel(AppConfig.imageCar6),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "السعر 12000 ",
              style: AppConfig.textOverview,
            ),
            ElevatedButton(
                onPressed: () {},
                child: Row(
                  children: [
                    ButtonConfirmCustom(
                        title: AppConfig.bayNow,
                        color: Colors.black,
                        onTap: () {}),
                    const SizedBox(width: 10),
                    SvgPicture.asset(
                      AppConfig.whatsapp,
                      height: 20,
                      width: 20,
                    ),
                  ],
                )),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: size.height * 1.3,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(151, 241, 241, 241),
                  // color: Color.fromARGB(75, 241, 241, 241),
                  // color: Color(0xffDEDEDE),
                  borderRadius: BorderRadius.all(
                    Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CardWithImage(
                            height: 40,
                            width: 45,
                            child: const Icon(
                              Icons.arrow_back_rounded,
                              color: Colors.black,
                            ),
                            colors: Colors.white,
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          CardWithImage(
                            height: 40,
                            width: 45,
                            child: const Icon(
                              Icons.share_outlined,
                              color: Colors.black,
                            ),
                            colors: Colors.white,
                            onTap: () {
                              //share this offers
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      child: buildImageSlider(context, listImageSliderCar),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    AppConfig.specifications,
                    overflow: TextOverflow.ellipsis,
                    style: AppConfig.textOverview,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 340,
                  child: Center(
                    child: Text(
                      AppConfig.carDetails,
                      overflow: TextOverflow.ellipsis,
                      style: AppConfig.textDetails,
                      textAlign: TextAlign.center,
                      maxLines: 100,
                    ),
                  ),
                ),
              ),
              buildListDetailsSpecifications(size, listSpecifications)
            ],
          ),
        ),
      ),
    );
  }
}

buildListDetailsSpecifications(
    Size size, List<SpecificationsModel> listSpecifications) {
  return SizedBox(
    height: 370,
    child: GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10),
      itemCount: listSpecifications.length,
      itemBuilder: (ctx, index) {
        String title = listSpecifications[index].title;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: AppConfig.textSpecifications,
                  textAlign: TextAlign.end,
                  maxLines: 10,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              height: 35,
              width: 35,
              child: const Icon(
                Icons.check,
                color: Color(0xff689CFA),
              ),
              decoration: const BoxDecoration(
                color: Color(0xffEBF1FC),
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
              ),
            ),
          ],
        );
      },
    ),
  );
}

buildImageSlider(
    BuildContext context, List<ImageSliderCarModel> listImageSliderCar) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: CarouselSlider(
      items: listImageSliderCar
          .map(
            (e) => GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => FullImage(e.imageUrl))));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  children: [
                    FadeInImage(
                      placeholder: const AssetImage(AppConfig.placeholder),
                      //  image:NetworkImage(e.linkEn.toString()),
                      image: AssetImage(e.imageUrl.toString()),
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.fill,
                    )
                  ],
                ),
              ),
            ),
          )
          .toList(),
      options: CarouselOptions(
        height: 200,
        aspectRatio: 16 / 9,
        viewportFraction: 0.95,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 2),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
        disableCenter: true,
      ),
    ),
  );
}
