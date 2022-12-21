import 'dart:async';

import 'package:auto_car/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:uuid/uuid.dart';

import '../debugger/my_debuger.dart';
import '../sharedpref/user_share_pref.dart';
import 'tab_screen.dart';

class SplahScreen extends StatefulWidget {
  const SplahScreen({Key? key}) : super(key: key);

  @override
  State<SplahScreen> createState() => _SplahScreenState();
}

class _SplahScreenState extends State<SplahScreen> {
  bool selected = false;
  bool userStatus = false;
  final uuid = Uuid();
  String userId = '';

  // getUserStatus() async {
  //   myLogs("currentStatus", "currentStatus");

  //   SharedPrefUser prefs = SharedPrefUser();
  //   bool currentStatus = await prefs.isLogin();
  //   myLogs("currentStatus", currentStatus);
  //   setState(() {
  //     userStatus = currentStatus;
  //   });
  // }

  //This methode it returns true if the app is launched for the first time.
  firstRun() async {
    bool firstRun = await IsFirstRun.isFirstRun();
    myLogs("firstRun", firstRun);

    if (firstRun) {
      userId = uuid.v4() + DateTime.now().toString();
      await SharedPrefUser().saveId(userId);
      myLogs("uuid Fom methoed firstTime()", userId);
    } else {
      _getUSerFromSharedPref();
    }
  }

  _getUSerFromSharedPref() async {
    var temp = await SharedPrefUser().getUid();
    setState(() {
      userId = temp;
      myLogs("uuid Fom methoed getUser()", userId);
    });
  }

  @override
  void initState() {
    super.initState();
    firstRun();
    Timer(
        Duration(seconds: 1),
        () => setState(() {
              selected = !selected;
            }));
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => TabScreen(userId: userId),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
        });
      },
      child: Center(
        child: Image.asset(
          AppConfig.iconApp2,
          height: size.height * 1,
          width: size.width * .7,
          // child: AnimatedAlign(
          //   alignment: selected ? Alignment.centerRight : Alignment.centerLeft,
          //   duration: const Duration(seconds: 3),
          //   curve: Curves.fastOutSlowIn,
          //   child: Image.asset(
          //     AppConfig.iconApp2,
          //     height: 150,
          //     width: 150,
          //   ),
          // ),
        ),
      ),
    );
  }
}

/*
import 'package:dolabi_yasser/screens/login_screen.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../mylog.dart';
import '../sharedpref/user_share_pref.dart';

import 'tabs_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  bool userStatus = false;
  late UserModel userModel;
  @override
  void initState() {
    super.initState();

    getUserStatus();
    _getUSerFromSharedPref();
  }

  getUserStatus() async {
    SharedPrefUser prefs = SharedPrefUser();
    bool currentStatus = await prefs.isLogin();
    myLog("currentStatus", currentStatus);
    if (currentStatus) {
      String? token = await prefs.getToken();
      //CompanyRequest().getWhatsappPhone(token: token);
    }

    setState(() {
      userStatus = currentStatus;
    });
  }

  _getUSerFromSharedPref() async {
    var temp = await SharedPrefUser().getUser();
    setState(() {
      userModel = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    var userName = userModel.user.name;
    return Container(
      color: Colors.white,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.10),
        child: EasySplashScreen(
          durationInSeconds: 3,
          navigator:
              userStatus ? TabsScreen(name: userName) : const LoginScreen(),
          // title: const Text(
          //   'دولابي',
          //   style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
          // ),
          logo: Image.asset(
            'images/main_logo.png',
            color: Theme.of(context).colorScheme.primary,
          ),
          logoSize: 150,
          loaderColor: Colors.white,
          backgroundColor: Colors.white,
          // loaderColor: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

*/
