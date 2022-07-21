import 'package:auto_car/api/api_response.dart';
import 'package:auto_car/config/app_config.dart';
import 'package:auto_car/enum/all_enum.dart';
import 'package:auto_car/model/category_model.dart';
import 'package:auto_car/provider/category_provider.dart';
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

  @override
  void initState() {
    categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    getDataFromProvider();
    super.initState();
  }

  getDataFromProvider() async {
    apiResponse = await categoryProvider.getListCategory();
    setState(() {
      listCategory = apiResponse.dataCategory;
    });
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
          categoryProvider.reloedListCategory().then(
                (value) => {
                  listCategory = value.dataCategory,
                  setState(() {}),
                },
              );
        },
      );
    } else if (categoryProvider.loadingState == LoadingState.noDataFound) {
      return ReyTryErrorWidget(
        title: AppConfig.noDataFound,
        onTap: () {
          setState(() {
            categoryProvider.loadingState = LoadingState.loading;
          });
          categoryProvider.reloedListCategory().then(
                (value) => {
                  listCategory = value.dataCategory,
                  setState(() {}),
                },
              );
        },
      );
    } else {
      var height = size.height / 2.278 * listCategory.length;

      return Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  const SearchWidgetWithLogo(),
                  SizedBox(
                    height: height,
                    //height: size.height * listCategory.length / 3,
                    // height: size.height * listCategory.length / 4,
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 20),
                      itemCount: listCategory.length,
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
                    ),
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
