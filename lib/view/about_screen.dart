import 'package:auto_car/config/app_config.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);
  static const routeName = "AboutScreen";

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String version = "1.0.0";

  // getVersion() async {
  //   var temp = await PackageInfo.fromPlatform();
  //   setState(() {
  //     version = temp.version;
  //   });
  // }

  @override
  void initState() {
    //getVersion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                // var revire = InAppReview.instance;
                // revire.openStoreListing();
              },
              child: Image.asset(
                AppConfig.logo,
                height: 200,
              ),
            ),
            Text(
              'الاصدار  $version ',
              style: const TextStyle(fontFamily: 'Changa', color: Colors.white),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              '© 2022',
              style: TextStyle(
                  fontFamily: 'Changa', color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
