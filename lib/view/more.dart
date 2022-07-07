import 'package:auto_car/config/app_config.dart';
import 'package:flutter/material.dart';

class More extends StatelessWidget {
  const More({Key? key}) : super(key: key);

  static const routeName = AppConfig.more;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        elevation: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildCardItem(AppConfig.callUs, Icons.support_agent),
            buildDivider(),
            buildCardItem(AppConfig.aboutUs, Icons.app_settings_alt),
            buildDivider(),
            buildCardItem(AppConfig.faq, Icons.info_outline),
            buildDivider(),
            buildCardItem(
                AppConfig.termsAndConditions, Icons.contact_page_outlined),
            buildDivider(),
          ],
        ),
      ),
    );
  }
}

buildDivider() {
  return const Divider(
    height: 30,
  );
}

buildCardItem(String title, IconData icons) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(icons, size: 27, color: Colors.grey.shade600),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 29, 29, 29),
          ),
        ),
      ],
    ),
  );
}
