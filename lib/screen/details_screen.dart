import 'package:auto_car/config/app_style.dart';
import 'package:auto_car/model/car_model.dart';
import 'package:auto_car/provider/offer_details_provider.dart';
import 'package:auto_car/widget/full_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config/app_config.dart';
import '../enum/all_enum.dart';
import '../model/offer_details_model.dart';
import '../widget/card_with_image.dart';
import '../widget/loading_widget.dart';
import '../widget/reytry_error_widget.dart';
import 'invoice_screen.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    Key? key,
    required this.currency,
    required this.offerId,
    required this.listImageSliderCar,
    required this.title,
    required this.price,
    required this.youtupeLink,
    required this.carModel,
  }) : super(key: key);
  static const routeName = "DetailsScreen";

  final List<ImageGallary> listImageSliderCar;

  final title;
  final price;
  final String offerId;
  final String currency;
  final String youtupeLink;
  final Datum carModel;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int activeIndex = 1;

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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String phone = "+971582978584";
    String text = "ارغب في شراء هذة السيارة";

    final splittedKilometer = _offerModel.kilometer.split(' ');

    void launchWatssap(String phone, String message, bool isYoutupe) async {
      String urlLaunch = '';
      if (isYoutupe) {
        urlLaunch = widget.youtupeLink;
      } else {
        urlLaunch =
            "whatsapp://send?phone=$phone&text=$message \n ${widget.carModel.imageUrl}";
      }
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
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () async {
                //share this offers
                await Share.share(
                    widget.carModel.imageUrl + "\n" + AppConfig.shareOffers
                    // : AppConfig.shareOffers,
                    // AppConfig.shareOffers,
                    );
              },
              icon: Icon(
                Icons.share_outlined,
              ),
              color: Colors.white,
            ),
          ],
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_rounded,
            ),
            color: Colors.white,
          ),
          // colors: Theme.of(context).colorScheme.onSecondary,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: size.width * .44,
                child: ElevatedButton(
                  //
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  onPressed: () {
                    launchWatssap(phone, text, false);
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppConfig.whatsapp,
                          height: 20,
                          width: 20,
                        ),
                        const SizedBox(width: 20),
                        const Text(
                          AppConfig.orderNow,
                          style: AppStyle.textWhitenormal20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: size.width * .44,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => InvoiceScreen(
                              carName: _offerModel.modelName,
                              carPrice: _offerModel.price,
                            )));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Text(
                      "${widget.currency} ${widget.price}",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 22,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Stack(
                  children: [
                    // Positioned(
                    //   top: 20,
                    //   left: 100,
                    //   right: 100,
                    //   child: Padding(
                    //     padding:
                    //         const EdgeInsets.only(left: 15, right: 15, top: 30),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         CardWithImage(
                    //           height: 30,
                    //           width: 45,
                    //           child: Icon(
                    //             Icons.arrow_back_rounded,
                    //             color:
                    //                 Theme.of(context).colorScheme.onBackground,
                    //           ),
                    //           colors: Theme.of(context).colorScheme.onSecondary,
                    //           onTap: () {
                    //             Navigator.of(context).pop();
                    //           },
                    //         ),
                    //         CardWithImage(
                    //           height: 30,
                    //           width: 45,
                    //           child: Icon(
                    //             Icons.share_outlined,
                    //             color:
                    //                 Theme.of(context).colorScheme.onBackground,
                    //           ),
                    //           colors: Theme.of(context).colorScheme.onSecondary,
                    //           onTap: () async {
                    //             //share this offers
                    //             await Share.share(AppConfig.shareOffers);
                    //           },
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),

                    Container(
                      // decoration: const BoxDecoration(
                      // color: Colors.amber,
                      //   borderRadius: BorderRadius.only(
                      //     bottomLeft: Radius.circular(50),
                      //   ),
                      // ),
                      height: size.height * .36,
                      width: double.infinity,
                      child: CarouselSlider(
                        items: _listImageGallary
                            .map(
                              (e) => GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: ((context) => FullImage(
                                          listImageGallary: _listImageGallary,
                                          url: e.filePath))));
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      // color: Colors.red,
                                      child: CachedNetworkImage(
                                        width: size.width,
                                        fit: BoxFit.cover,
                                        height: size.height * .5,
                                        filterQuality: FilterQuality.high,
                                        imageUrl: e.filePath.toString(),
                                        placeholder: (context, url) => Center(
                                          child: FadeInImage(
                                            placeholder: AssetImage(
                                                AppConfig.autoCarLogo),
                                            image: AssetImage(
                                                AppConfig.autoCarLogo),
                                            width: double.infinity,
                                            height: 100,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
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
                          height: size.height * .06,
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
                  ],
                ),

                // Stack(
                //   children: [
                //     Positioned(
                //       top: 20,
                //       left: 100,
                //       right: 100,
                //       child: Padding(
                //         padding:
                //             const EdgeInsets.only(left: 15, right: 15, top: 30),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             CardWithImage(
                //               height: 30,
                //               width: 45,
                //               child: Icon(
                //                 Icons.arrow_back_rounded,
                //                 color:
                //                     Theme.of(context).colorScheme.onBackground,
                //               ),
                //               colors: Theme.of(context).colorScheme.onSecondary,
                //               onTap: () {
                //                 Navigator.of(context).pop();
                //               },
                //             ),
                //             CardWithImage(
                //               height: 30,
                //               width: 45,
                //               child: Icon(
                //                 Icons.share_outlined,
                //                 color:
                //                     Theme.of(context).colorScheme.onBackground,
                //               ),
                //               colors: Theme.of(context).colorScheme.onSecondary,
                //               onTap: () async {
                //                 //share this offers
                //                 await Share.share(AppConfig.shareOffers);
                //               },
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //     // Positioned(
                //     //   top: 20,
                //     //   child: Container(
                //     //     color: Colors.amber,
                //     //     height: size.height * .4,
                //     //     width: double.infinity,
                //     //   ),
                //     // ),
                //   ],
                // ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Align(
                          //   alignment: Alignment.centerLeft,
                          //   child: Text(
                          //     "${widget.currency} ${widget.price}",
                          //     textAlign: TextAlign.left,
                          //     style: TextStyle(
                          //         color: Colors.red,
                          //         fontSize: size.width * .1,
                          //         fontWeight: FontWeight.w500),
                          //   ),
                          // ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                                width: size.width * .21,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(0),
                                  ),
                                ),
                                child: Card(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        activeIndex.toString(),
                                        style: TextStyle(
                                            fontSize: size.width * .08,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        '/',
                                        style: TextStyle(
                                            fontSize: size.width * .08,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        _listImageGallary.length.toString(),
                                        style: TextStyle(
                                            fontSize: size.width * .08,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Description",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: size.width * .06,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.end,
                          ////maxLines: 100,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _offerModel.description,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: size.width * .06,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.end,
                          ////maxLines: 100,
                        ),
                      ),
                      const SizedBox(height: 35),
                      buildCarItem("Model", _offerModel.modelName, size),
                      const SizedBox(height: 15),
                      buildCarItem("Year",
                          widget.carModel.year.yearName.toString(), size),
                      const SizedBox(height: 15),
                      buildCarItem("Seats", _offerModel.seats.toString(), size),
                      const SizedBox(height: 15),
                      buildCarItem(
                          "kilometer", _offerModel.kilometer + " km", size),
                      widget.youtupeLink.isEmpty
                          ? SizedBox()
                          : CardWithImage(
                              height: 40,
                              width: 60,
                              child: Icon(
                                Icons.play_arrow_sharp,
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                size: 40,
                              ),
                              colors: Theme.of(context).colorScheme.onPrimary,
                              onTap: () async {
                                showAlertDialog(
                                  context,
                                  () => {launchWatssap(phone, text, true)},
                                  () => Navigator.of(context).pop(),
                                );

                                //share this offers
                                // await Share.share(AppConfig.shareOffers);
                              },
                            ),
                    ],
                  ),
                ),

                SizedBox(height: size.height * .03),

                buildListDetailsSpecifications(context, size, _listFeature, 0),
                //buildListDetailsSpecifications(context, size, _listFeature, 1),
                // buildListDetailsSpecifications(context, size, _listFeature, 2),
              ],
            ),
          ),
        ),
      );
    }
  }
}

showAlertDialog(BuildContext context, Function() yes, Function() no) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("مشاهدة", style: TextStyle(color: Colors.green)),
    onPressed: yes,
  );
  Widget continueButton = TextButton(
    child: Text("الغاء"),
    onPressed: no,
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("مشاهدة الفيديو"),
    content: Text("هل تريد الانتقال الي يوتيوب ومشاهدة فيديو للسيارة؟"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

buildCarItem(String key, String value, Size size) {
  return Row(
    // mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        // color: Colors.red,
        width: size.width * .2,
        child: Text(
          key,
          style: TextStyle(
              color: Colors.black,
              fontSize: size.width * .06,
              fontWeight: FontWeight.normal),
          // textAlign: TextAlign.start,
        ),
      ),
      SizedBox(width: 10),
      Container(
        width: size.width * .65,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            value,
            overflow: TextOverflow.clip,
            style: TextStyle(
                color: Colors.black,
                fontSize: size.width * .06,
                fontWeight: FontWeight.normal),
            //size.width * .65
          ),
        ),
      ),
    ],
  );
}

buildListDetailsSpecifications(BuildContext context, Size size,
    List<FeaturesType> _listFeature, int index) {
  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    padding: const EdgeInsets.all(10.0),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.9,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10),
    itemCount: _listFeature.length,
    itemBuilder: (ctx, index) {
      String featureName = _listFeature[index].features[0].featureName;
      String featuretype = _listFeature[index].typeName;
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //this is feature type : Security or
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              featuretype,
              style: AppStyle.textBlack18,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width * .32,
                child: Align(
                  alignment: Alignment.centerLeft,
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
