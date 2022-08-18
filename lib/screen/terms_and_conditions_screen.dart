import 'package:auto_car/config/app_config.dart';
import 'package:flutter/material.dart';

import '../widget/animated_text_wIth_card.dart';

//TermsAndConditionsDiscripstion
class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({Key? key}) : super(key: key);
  static const routeName = "TermsAndConditions";

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  var _expand1 = false;

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
                title: AppConfig.termsAndConditionsAr,
                discreption: AppConfig.termsAndConditionsDiscripstion,
                expand: _expand1,
                onTap: () {
                  setState(() {
                    _expand1 = !_expand1;
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
