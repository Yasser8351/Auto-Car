import 'package:auto_car/config/app_config.dart';
import 'package:flutter/material.dart';

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
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  AppConfig.aboutAppTitle,
                  style: AppConfig.textTitle,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  AppConfig.aputAppDiscreption,
                  style: AppConfig.textSpecifications,
                  textAlign: TextAlign.end,
                ),
              ),
              SizedBox(height: 40),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  AppConfig.howContactusTitle,
                  style: AppConfig.textTitle,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  AppConfig.howContactus,
                  style: AppConfig.textSpecifications,
                  textAlign: TextAlign.end,
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
