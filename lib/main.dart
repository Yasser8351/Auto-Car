import 'package:auto_car/view/favert.dart';
import 'package:auto_car/view/home.dart';
import 'package:auto_car/view/more.dart';
import 'package:auto_car/view/offers.dart';
import 'package:auto_car/view/tab_screen.dart';
import 'package:flutter/material.dart';

import 'view/about_screen.dart';
import 'view/details_screen.dart';
import 'view/terms_and_conditions_screen.dart';
import 'view/version_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //fontFamily: 'Changa',
        //primarySwatch: Colors.blue,
        primaryColor: Colors.black,
        colorScheme: const ColorScheme(
          primary: Colors.black,
          onPrimary: Colors.white,
          background: Colors.yellow,
          onBackground: Colors.black,
          secondary: Color.fromARGB(255, 206, 3, 162),
          // secondary: const Color(0xffF8F8F8),
          onSecondary: Colors.white,
          error: Colors.grey,
          onError: Color.fromARGB(255, 250, 150, 0),
          surface: Color.fromARGB(255, 46, 231, 0),
          onSurface: Color.fromARGB(137, 175, 0, 0),
          brightness: Brightness.light,
        ),
      ),
      home: const TabScreen(),
      routes: {
        Home.routeName: (ctx) => const Home(),
        Favert.routeName: (ctx) => const Favert(),
        Offers.routeName: (ctx) => const Offers(),
        More.routeName: (ctx) => const More(),
        AboutScreen.routeName: (ctx) => const AboutScreen(),
        VersionScreen.routeName: (ctx) => const VersionScreen(),
        DetailsScreen.routeName: (ctx) => const DetailsScreen(),
        TermsAndConditions.routeName: (ctx) => const TermsAndConditions(),
      },
    );
  }
}
