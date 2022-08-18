import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../config/app_config.dart';
import 'card_with_image.dart';

class BuildSearchWidget extends StatelessWidget {
  const BuildSearchWidget({Key? key, required this.onTap}) : super(key: key);
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)),
          height: 50,
          width: size.width / 1.3,
          child: TextField(
            // controller: widget.searchlist,
            onSubmitted: (String v) {
              //  widget.onSearch();
            },
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              focusColor: Colors.black,
              fillColor: Colors.black,
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Color.fromARGB(255, 31, 30, 30), width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Color.fromARGB(255, 31, 30, 30), width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.clear,
                  //   size: widget.searchlist.text.isEmpty ? 0 : 20,
                  color: Colors.grey,
                ),
                iconSize: 0, //iconSize: widget.isSearch ? 0 : 18,
                onPressed: () {
                  //  widget.clearSearch();
                },
              ),
              prefixIcon: IconButton(
                alignment: Alignment.topCenter,
                onPressed: () {
                  //   widget.onSearch();
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
              hintText: AppConfig.search,
              hintStyle: const TextStyle(color: Colors.black),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,

                borderRadius: BorderRadius.circular(5),
                // borderSide: const BorderSide(color: Colors.black),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        CardWithImage(
          height: 50,
          width: 50,
          child: Center(
            child: SvgPicture.asset(
              AppConfig.filter,
              height: 30,
              width: 30,
              color: Colors.white,
            ),
          ),
          colors: Colors.black,
          onTap: onTap,
        ),
      ],
    );
  }
}
/*
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wave/screens/home_page/home_page.dart';

class SearchWidget extends StatefulWidget {
  SearchWidget({
    Key? key,
    required this.searchlist,
    required this.isSearch,
    required this.textSearch,
    required this.onSearch,
    required this.clearSearch,
    //  required this.listgetDiscounts
  }) : super(key: key);
  String textSearch;
  bool isSearch;
  TextEditingController searchlist = TextEditingController();
  final Function onSearch;
  final Function clearSearch;

  //GetDiscountsListProvider listgetDiscounts;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    myLog("searchlist", widget.searchlist.text.toString());
    return GestureDetector(
      child: Container(
        height: 50,
        width: size.width / 1.15,
        child: TextField(
          controller: widget.searchlist,
          onSubmitted: (String v) {
            widget.onSearch();
          },
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            focusColor: Colors.black,
            fillColor: Colors.black,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Color.fromARGB(255, 31, 30, 30), width: 1.0),
              borderRadius: BorderRadius.circular(5.0),
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.clear,
                  size: widget.searchlist.text.isEmpty ? 0 : 20,
                  color: Colors.red),
              //iconSize: widget.isSearch ? 0 : 18,
              onPressed: () {
                widget.clearSearch();
              },
            ),
            prefixIcon: IconButton(
              alignment: Alignment.topCenter,
              onPressed: () {
                widget.onSearch();
              },
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
            hintText: AppLocalizations.of(context)!.search,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      onTap: () {
        widget.onSearch();
      },
    );
  
  }
}

*/