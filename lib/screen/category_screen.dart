import 'package:auto_car/api/api_response.dart';
import 'package:auto_car/config/app_config.dart';
import 'package:auto_car/config/app_style.dart';
import 'package:auto_car/debugger/my_debuger.dart';
import 'package:auto_car/enum/all_enum.dart';
import 'package:auto_car/model/category_model.dart';
import 'package:auto_car/provider/category_provider.dart';
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
        return Center(
            child: Text(
          isSearch ? AppConfig.noDataFoundInThisResult : AppConfig.noDataFound,
          style: AppStyle.textStyle2,
        ));
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
                                (element) =>
                                    element.typeName.toLowerCase() ==
                                    textSearchController.text.toLowerCase(),
                              )
                              .toList();
                        },
                      );
                    },
                  )
                : SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
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
                          ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 20),
                            itemCount: listCategory.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  //go to detailsScreen
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

  void getDataCategory() {
    categoryProvider.reloedListCategory().then(
          (value) => {
            listCategory = value.dataCategory,
            setState(() {}),
          },
        );
  }
}
