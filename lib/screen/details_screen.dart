import 'package:auto_car/config/app_style.dart';
import 'package:auto_car/provider/offer_details_provider.dart';
import 'package:auto_car/widget/full_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config/app_config.dart';
import '../enum/all_enum.dart';
import '../model/offer_details_model.dart';
import '../widget/card_with_image.dart';
import '../widget/loading_widget.dart';
import '../widget/reytry_error_widget.dart';
import 'invoice_screen.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen(
      {Key? key,
      required this.offerId,
      required this.listImageSliderCar,
      required this.title,
      required this.price})
      : super(key: key);
  static const routeName = "DetailsScreen";

  final List<ImageGallary> listImageSliderCar;

  final title;
  final price;
  final String offerId;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int activeIndex = 0;

  late OfferDetailsProvider detailsprovider;
  List<ImageGallary> _listImageGallary = [];
  List<FeaturesType> _listFeature = [];
  OfferModel _offerModel = OfferModel(
      id: "",
      description: "",
      kilometer: "",
      price: 0.0,
      seats: 0,
      modelName: '');
/*  List<SpecificationsModel> _listFeature = [
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
  */

  @override
  void initState() {
    detailsprovider = Provider.of<OfferDetailsProvider>(context, listen: false);
    detailsprovider.geOffersDetails(widget.offerId).then((value) => {
          _listImageGallary = detailsprovider.listImageGallary,
          _listFeature = detailsprovider.listFeature,
          _offerModel = detailsprovider.offerModel,
          setState(() {})
        });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  // List<ImageSliderCarModel> listImageSliderCar = [
  //   ImageSliderCarModel(AppConfig.imageCar),
  //   ImageSliderCarModel(AppConfig.imageCar2),
  //   ImageSliderCarModel(AppConfig.imageCar3),
  //   ImageSliderCarModel(AppConfig.imageCar4),
  //   ImageSliderCarModel(AppConfig.imageCar5),
  //   ImageSliderCarModel(AppConfig.imageCar6),
  // ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String phone = "+971582978584";
    String text = "ارغب في شراء هذة السيارة";

    final splittedKilometer = _offerModel.kilometer.split(' ');

    void launchWatssap(String phone, String message) async {
      //String urlLaunch = "whatsapp://send?phone=$phone";
      String urlLaunch = "whatsapp://send?phone=$phone&text=$message";
      if (await canLaunchUrl(Uri.parse(urlLaunch))) {
        // ignore: deprecated_member_use
        launch((urlLaunch));
      }
    }

    if (detailsprovider.loadingState == LoadingState.initial ||
        detailsprovider.loadingState == LoadingState.loading) {
      return const LoadingWidget(
          msg: AppConfig.loading, msgColor: Colors.black, color: Colors.black);
    } else if (detailsprovider.loadingState == LoadingState.error) {
      return ReyTryErrorWidget(
        title: detailsprovider.apiResponse.message,
        onTap: () {
          setState(() {});
          detailsprovider.geOffersDetails(widget.offerId).then((value) => {
                _listImageGallary = detailsprovider.listImageGallary,
                _listFeature = detailsprovider.listFeature,
                _offerModel = detailsprovider.offerModel,
                setState(() {})
              });
          // getDataCategory();
        },
      );
    } else if (detailsprovider.loadingState == LoadingState.noDataFound) {
      return ReyTryErrorWidget(
        title: AppConfig.noDataFound,
        onTap: () {
          //  getDataCategory();
        },
      );
    } else {
      return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => InvoiceScreen(
                            carName: _offerModel.modelName,
                            carPrice: _offerModel.price,
                          )));
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        AppConfig.invoice,
                        style: AppStyle.textWhitenormal20,
                      ),
                      const SizedBox(width: 20),
                      Icon(
                        Icons.insert_page_break_outlined,
                        color: Theme.of(context).colorScheme.onSecondary,
                        size: 20,
                      )
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  launchWatssap(phone, text);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        AppConfig.contactUs,
                        style: AppStyle.textWhitenormal20,
                      ),
                      const SizedBox(width: 20),
                      SvgPicture.asset(
                        AppConfig.whatsapp,
                        height: 20,
                        width: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(151, 241, 241, 241),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                  ),
                ),
                height: 400,
                width: double.infinity,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      child: CarouselSlider(
                        items: _listImageGallary
                            .map(
                              (e) => GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: ((context) =>
                                          FullImage(e.filePath))));
                                },
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(60),
                                      ),
                                      child: CachedNetworkImage(
                                        width: size.width,
                                        fit: BoxFit.cover,
                                        height: 400,
                                        filterQuality: FilterQuality.low,
                                        imageUrl: e.filePath.toString(),
                                        placeholder: (context, url) => Center(
                                          child: FadeInImage(
                                            placeholder: AssetImage(
                                                AppConfig.placeholder),
                                            image: AssetImage(
                                                AppConfig.placeholder),
                                            width: double.infinity,
                                            height: 120,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                    Positioned(
                                      top: 40,
                                      left: 100,
                                      right: 100,
                                      child: Image.asset(
                                        AppConfig.logo,
                                        height: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                        options: CarouselOptions(
                          onPageChanged: (index, reason) {
                            setState(() {
                              activeIndex = index;
                            });
                          },
                          height: 400,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1.01,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 5),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          scrollDirection: Axis.horizontal,
                          disableCenter: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 40, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CardWithImage(
                            height: 40,
                            width: 45,
                            child: Icon(
                              Icons.arrow_back_rounded,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                            colors: Theme.of(context).colorScheme.onSecondary,
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          CardWithImage(
                            height: 40,
                            width: 45,
                            child: Icon(
                              Icons.share_outlined,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                            colors: Theme.of(context).colorScheme.onSecondary,
                            onTap: () async {
                              //share this offers
                              await Share.share(AppConfig.shareOffers);
                            },
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 100,
                      right: 10,
                      //padding: const EdgeInsets.symmetric(vertical: 90, horizontal: 15),
                      child: Column(
                        children: [
                          CardWithImage(
                            height: 40,
                            width: 60,
                            child: Icon(
                              Icons.play_arrow_sharp,
                              color: Theme.of(context).colorScheme.onSecondary,
                              size: 40,
                            ),
                            colors: Theme.of(context).colorScheme.onPrimary,
                            onTap: () async {
                              //share this offers
                              // await Share.share(AppConfig.shareOffers);
                            },
                          ),
                          const SizedBox(height: 10),
                          CardWithImage(
                            height: 45,
                            width: 60,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  splittedKilometer[0],
                                  // _offerModel.kilometer,
                                  // "230",
                                  style: AppStyle.textStyle6,
                                ),
                                Text(
                                  "KM/H",
                                  style: AppStyle.textStyle4,
                                ),
                              ],
                            ),
                            colors: Theme.of(context).colorScheme.onSecondary,
                            onTap: () async {
                              //share this offers
                              //  await Share.share(AppConfig.shareOffers);
                            },
                          ),
                          const SizedBox(height: 10),
                          CardWithImage(
                            height: 40,
                            width: 60,
                            child: const Center(
                                child: Text(
                              "DISIEL",
                              style: AppStyle.textStyle3,
                            )),
                            colors: Theme.of(context).colorScheme.onSecondary,
                            onTap: () async {
                              //share this offers
                              //  await Share.share(AppConfig.shareOffers);
                            },
                          ),
                          const SizedBox(height: 10),
                          CardWithImage(
                            height: 45,
                            width: 60,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "1.3L",
                                  style: AppStyle.textStyle3,
                                ),
                                Text(
                                  "ENGINE",
                                  style: AppStyle.textStyle4,
                                ),
                              ],
                            ),
                            colors: Theme.of(context).colorScheme.onSecondary,
                            onTap: () async {
                              //share this offers
                              //  await Share.share(AppConfig.shareOffers);
                            },
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 320,
                      bottom: 0,
                      left: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(60),
                          ),
                        ),
                        width: size.width,
                        height: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    //"\$ 60,000",
                                    _offerModel.price.toString(),
                                    // widget.price.toString(),
                                    style: AppStyle.textStyle5,
                                    textAlign: TextAlign.end,
                                  ),
                                  AnimatedSmoothIndicator(
                                    effect: WormEffect(
                                      dotHeight: 11,
                                      dotWidth: 10,
                                      activeDotColor: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      // dotColor: Theme.of(context)
                                      //     .colorScheme
                                      //     .onPrimary,
                                      type: WormType.thin,
                                      // strokeWidth: 5,
                                    ),
                                    activeIndex: activeIndex,
                                    count: _listImageGallary.length,
                                  ),
                                  Text(
                                    _offerModel.modelName,
                                    //"فورد اكسبدشن",
                                    // widget.title,
                                    style: AppStyle.textStyle5,
                                    textAlign: TextAlign.end,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // buildImageSlider(
              //   context,
              //   listImageSliderCar,
              //   size,
              //   () => setState,
              // ),
              const SizedBox(height: 25),
              const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    AppConfig.specifications,
                    overflow: TextOverflow.ellipsis,
                    style: AppConfig.textOverview,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    _offerModel.description,
                    // AppConfig.carDetails,
                    style: AppConfig.textDetails,
                    textAlign: TextAlign.end,
                    ////maxLines: 100,
                  ),
                ),
              ),
              SizedBox(height: size.height * .05),
              buildListDetailsSpecifications(context, size, _listFeature, 0),
              //buildListDetailsSpecifications(context, size, _listFeature, 1),
              // buildListDetailsSpecifications(context, size, _listFeature, 2),
            ],
          ),
        ),
      );
    }
  }
}

buildListDetailsSpecifications(BuildContext context, Size size,
    List<FeaturesType> _listFeature, int index) {
  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    padding: const EdgeInsets.all(10.0),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.9,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10),
    itemCount: _listFeature.length,
    itemBuilder: (ctx, index) {
      String featureName = _listFeature[index].features[index].featureName;
      String featuretype = _listFeature[index].typeName;
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //this is feature type : Security or
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              featuretype,
              style: AppStyle.textStyle6,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    featureName,
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
                child: Icon(
                  Icons.check,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
