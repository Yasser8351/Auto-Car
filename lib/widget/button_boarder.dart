import 'package:flutter/material.dart';

class BorderButtonCustom extends StatefulWidget {
  final String title;
  final Color color;
  final IconData? icon;
  final bool showMargin;
  final Function() onTap;
  const BorderButtonCustom({
    Key? key,
    required this.title,
    required this.color,
    this.icon,
    this.showMargin = false,
    required this.onTap,
  }) : super(key: key);

  @override
  State<BorderButtonCustom> createState() => _BorderButtonCustomState();
}

class _BorderButtonCustomState extends State<BorderButtonCustom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: widget.color),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () => widget.onTap(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    color: widget.color,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(width: widget.icon == null ? 0 : 5),
            widget.icon == null
                ? const SizedBox.shrink()
                : Icon(
                    widget.icon,
                    color: widget.color,
                  ),
          ],
        ),
      ),
    );
  }
}
