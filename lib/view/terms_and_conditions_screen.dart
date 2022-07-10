import 'package:auto_car/config/app_config.dart';
import 'package:auto_car/widget/title_and_discreipstion_widget.dart';
import 'package:flutter/material.dart';

//TermsAndConditionsDiscripstion
class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({Key? key}) : super(key: key);
  static const routeName = "TermsAndConditions";

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
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
                  title: AppConfig.termsAndConditionsAr,
                  discreption: AppConfig.termsAndConditionsDiscripstion),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
