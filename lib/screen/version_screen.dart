import 'package:auto_car/config/app_config.dart';
import 'package:flutter/material.dart';

class VersionScreen extends StatefulWidget {
  const VersionScreen({Key? key}) : super(key: key);
  static const routeName = "VersionScreen";

  @override
  State<VersionScreen> createState() => _VersionScreenState();
}

class _VersionScreenState extends State<VersionScreen> {
  String version = AppConfig.version;
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
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
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
                  height: 150,
                  width: double.infinity,
                  //  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Version  $version ',
                style: const TextStyle(
                  fontFamily: 'Changa',
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                '© 2022  ',
                style: TextStyle(
                    fontFamily: 'Changa', color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
