import 'package:auto_car/config/app_config.dart';
import 'package:flutter/material.dart';

import '../widget/title_and_discreipstion_widget.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);
  static const routeName = "AboutScreen";

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
          child: Column(
            children: const [
              TitleAndDiscreipstionWidget(
                  title: AppConfig.aboutAppTitle,
                  discreption: AppConfig.aputAppDiscreption),
              SizedBox(height: 40),
              TitleAndDiscreipstionWidget(
                  title: AppConfig.howContactusTitle,
                  discreption: AppConfig.howContactus),
            ],
          ),
        ),
      ),
    );
  }
}
