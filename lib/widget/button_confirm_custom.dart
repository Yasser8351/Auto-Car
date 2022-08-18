import 'package:flutter/material.dart';

class ButtonConfirmCustom extends StatelessWidget {
  final String title;
  final Color color;

  final bool showMargin;
  final Function() onTap;
  const ButtonConfirmCustom({
    Key? key,
    required this.title,
    required this.color,
    this.showMargin = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: 45,
      margin: showMargin
          ? EdgeInsets.symmetric(
              horizontal: size.width * 0.07,
              vertical: size.height * 0.035,
            )
          : null,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () => onTap(),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
