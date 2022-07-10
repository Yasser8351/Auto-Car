import 'package:auto_car/config/app_config.dart';
import 'package:auto_car/view/about_screen.dart';
import 'package:auto_car/view/version_screen.dart';
import 'package:flutter/material.dart';

import 'home.dart';

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
            const SizedBox(height: 50),
            buildCardItem(context, AppConfig.callUs, Icons.support_agent,
                () => Navigator.of(context).pushNamed(Home.routeName)),
            buildDivider(),
            buildCardItem(context, AppConfig.aboutApp, Icons.app_settings_alt,
                () => Navigator.of(context).pushNamed(AboutScreen.routeName)),
            buildDivider(),
            buildCardItem(context, AppConfig.versionApp, Icons.info_outline,
                () => Navigator.of(context).pushNamed(VersionScreen.routeName)),
            buildDivider(),
            buildCardItem(context, AppConfig.shareApp, Icons.share_outlined,
                () => Navigator.of(context).pushNamed(Home.routeName)),
            buildDivider(),
            buildCardItem(
                context,
                AppConfig.privacyPolicy,
                Icons.verified_user_outlined,
                () => Navigator.of(context).pushNamed(Home.routeName)),
            buildDivider(),
            buildCardItem(
                context,
                AppConfig.termsAndConditions,
                Icons.contact_page_outlined,
                () => Navigator.of(context).pushNamed(Home.routeName)),
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

buildCardItem(
    BuildContext context, String title, IconData icons, Function() onTap) {
  return GestureDetector(
    onTap: () => onTap(),
    child: Padding(
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
    ),
  );
}
