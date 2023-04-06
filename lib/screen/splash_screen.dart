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
  bool firstRun = false;
  String userId = '';

  //This methode it returns true if the app is launched for the first time.
  firstRunApp() async {
    firstRun = await IsFirstRun.isFirstRun();
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
    firstRunApp();
    Timer(
        Duration(seconds: 1),
        () => setState(() {
              selected = !selected;
            }));
    Timer(
        Duration(seconds: 2),
        () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => TabScreen(userId: userId),
                ),
              )
            }

        //  Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => TabScreen(userId: userId),
        //   ),
        // ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          setState(() {
            selected = !selected;
          });
        },
        child: Center(
          child: Image.asset(
            AppConfig.placeholder,
            height: size.height * 1,
            width: size.width * .7,
          ),
        ),
      ),
    );
  }
}

/*
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
        Duration(seconds: 2),
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

*/