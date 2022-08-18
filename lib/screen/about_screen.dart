import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../widget/animated_text_wIth_card.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);
  static const routeName = "AboutScreen";

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  var _expand1 = false;
  var _expand2 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            children: [
              AnimatedTextWIthCard(
                title: AppConfig.aboutAppTitle,
                discreption: AppConfig.aputAppDiscreption,
                expand: _expand1,
                onTap: () {
                  setState(() {
                    _expand1 = !_expand1;
                  });
                },
              ),
              const SizedBox(height: 10),
              AnimatedTextWIthCard(
                title: AppConfig.howContactusTitle,
                discreption: AppConfig.howContactus,
                expand: _expand2,
                onTap: () {
                  setState(() {
                    _expand2 = !_expand2;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
