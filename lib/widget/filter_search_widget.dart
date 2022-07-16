import 'package:auto_car/model/filter_model.dart';
import 'package:flutter/material.dart';

import '../config/app_config.dart';

class FilterSearchWidget extends StatelessWidget {
  const FilterSearchWidget({Key? key, required this.onTap}) : super(key: key);
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<FilterModel> listFilter = [
      FilterModel(AppConfig.leesPrice),
      FilterModel(AppConfig.topPrice),
      FilterModel(AppConfig.oldeOffer),
      FilterModel(AppConfig.lastOffer),
      FilterModel(AppConfig.topViews),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            onPressed: onTap,
            child: const Icon(
              Icons.close,
              size: 40,
              color: Colors.black,
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: size.height / 1.45,
                child: ListView.builder(
                  itemCount: listFilter.length,
                  itemBuilder: (context, index) {
                    final title = listFilter[index].title;
                    return ListTile(
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            title,
                            style: AppConfig.textSpecifications,
                          ),
                          const Divider(),
                          //const Spacer(),
                        ],
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: onTap,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                  child: Text(
                    AppConfig.showResultSearch,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
