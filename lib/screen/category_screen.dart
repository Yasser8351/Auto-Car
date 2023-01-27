import 'package:auto_car/api/api_response.dart';
import 'package:auto_car/config/app_config.dart';
import 'package:auto_car/debugger/my_debuger.dart';
import 'package:auto_car/enum/all_enum.dart';
import 'package:auto_car/model/category_model.dart';
import 'package:auto_car/provider/category_provider.dart';
import 'package:auto_car/screen/offers_by_category.dart';
import 'package:auto_car/widget/text_faild_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/list_category_widget.dart';
import '../widget/loading_widget.dart';
import '../widget/reytry_error_widget.dart';
import '../widget/search_widget_with_logo.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);
  static const routeName = AppConfig.category;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late CategoryProvider categoryProvider;

  List<CategoryModel> listCategory = [];
  late ApiResponse apiResponse;

  TextEditingController textSearchController = TextEditingController();

  List<ServicesModel> listServices = [
    ServicesModel(title: "Shipping\nServices", image: AppConfig.logoSplash),
    ServicesModel(title: "Custom\nClearance", image: AppConfig.logoSplash),
    ServicesModel(title: "1 monthe\ndelivery", image: AppConfig.logoSplash),
    ServicesModel(title: "Full\nOwnership", image: AppConfig.logoSplash),
  ];

  bool isSearch = false;

  @override
  void initState() {
    categoryProvider = Provider.of<CategoryProvider>(context, listen: false);

    // getDataFromProvider();
    super.initState();
  }

  getDataFromProvider() async {
    apiResponse = await categoryProvider.getListCategory();
    setState(() {
      listCategory = apiResponse.dataCategory;
    });
  }

  @override
  void didChangeDependencies() {
    listCategory =
        Provider.of<CategoryProvider>(context, listen: true).listCategory;
    myLogs("listCategory", listCategory.length);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (categoryProvider.loadingState == LoadingState.initial ||
        categoryProvider.loadingState == LoadingState.loading) {
      return const LoadingWidget(
          msg: AppConfig.loading, msgColor: Colors.black, color: Colors.black);
    } else if (categoryProvider.loadingState == LoadingState.error) {
      return ReyTryErrorWidget(
        title: categoryProvider.apiResponse.message,
        onTap: () {
          setState(() {
            categoryProvider.loadingState = LoadingState.loading;
          });
          getDataCategory();
        },
      );
    } else if (categoryProvider.loadingState == LoadingState.noDataFound) {
      return ReyTryErrorWidget(
        title: AppConfig.noDataFound,
        onTap: () {
          setState(() {
            categoryProvider.loadingState = LoadingState.loading;
          });
          getDataCategory();
        },
      );
    } else {
      if (listCategory.isEmpty) {
        return ReyTryErrorWidget(
          isClear: true,
          title: isSearch
              ? AppConfig.noDataFoundInThisResult
              : AppConfig.noDataFound,
          onTap: () {
            setState(() {
              textSearchController.text = '';
            });
            getDataCategory();
          },
        );
      } else {
        return Scaffold(
          body: SingleChildScrollView(
            child: isSearch
                ? TextFaildSearchWidget(
                    textSearchController: textSearchController,
                    onTap: () {
                      setState(
                        () {
                          isSearch = !isSearch;
                        },
                      );
                    },
                    onTapSearch: () {
                      setState(
                        () {
                          isSearch = !isSearch;
                          if (textSearchController.text.isEmpty) {
                            getDataCategory();
                          }

                          listCategory = listCategory
                              .where(
                                (element) => element.typeName
                                    .toLowerCase()
                                    .contains(textSearchController.text
                                        .toLowerCase()),
                              )
                              .toList();
                        },
                      );
                    },
                  )
                : SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 10),
                      child: Column(
                        children: [
                          const SizedBox(height: 25),
                          SearchWidgetWithLogo(
                            onTap: () {
                              setState(() {
                                isSearch = !isSearch;
                              });
                            },
                          ),
                          SizedBox(
                            height: size.height * .155,
                            child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: 10),
                              // shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: listServices.length,
                              itemBuilder: (context, index) {
                                String logo = listServices[index].image;
                                String title = listServices[index].title;
                                return Padding(
                                  //
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        radius: 30,
                                        child: Image.asset(logo),
                                      ),
                                      // Container(
                                      //   height: size.height * .034,
                                      //   width: size.width * .2,
                                      //   child: Center(
                                      SizedBox(height: 10),
                                      Text(
                                        title,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                      //   ),
                                      //   decoration: BoxDecoration(
                                      //     // border: Border.all(
                                      //     //     color: colorScheme.onPrimary),
                                      //     color: null,
                                      //     borderRadius: BorderRadius.only(
                                      //       bottomLeft: Radius.circular(15),
                                      //       topRight: Radius.circular(15),
                                      //     ),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: listCategory.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => OffersByCategory(
                                          search: listCategory[index].id)));
                                },
                                child: ListCategoryWidget(
                                  listCategory: listCategory[index],
                                  size: size,
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
          ),
        );
      }
    }
  }

  getDataCategory() {
    categoryProvider.reloedListCategory().then(
          (value) => {
            listCategory = value.dataCategory,
            setState(() {}),
          },
        );
  }
}

class ServicesModel {
  final String title;
  final String image;

  ServicesModel({required this.title, required this.image});
}
