import 'dart:developer';

import 'package:auto_car/provider/car_provider.dart';
import 'package:auto_car/provider/category_provider.dart';
import 'package:auto_car/screen/category_screen.dart';
import 'package:auto_car/screen/favert.dart';
import 'package:auto_car/screen/home.dart';
import 'package:auto_car/screen/more.dart';
import 'package:auto_car/screen/tab_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import 'config/app_config.dart';
import 'provider/brand_provider.dart';
import 'provider/offer_details_provider.dart';
import 'screen/about_screen.dart';
import 'screen/send_notifaction_screen.dart';
import 'screen/terms_and_conditions_screen.dart';
import 'screen/version_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);

    await FirebaseMessaging.onMessageOpenedApp;
    await FirebaseMessaging.instance.getInitialMessage();
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    /*
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) async {
        await Future.delayed(const Duration(seconds: 3));
        if (message.data['screen'] != 'orders') return;
        var token = await SharedPredRepresentative().getToken();
        if (token == null || token.isEmpty) return;
        try {
          final response = await http.post(
            Uri.parse('https://app.wasel-sd.com/api/global/GetOrderWithId'),
            headers: ApiHandler.getHeader(token: token),
            body: {
              'order_id': message.data['id'],
            },
          );
          final order =
              NewOrder.fromJson(json.decode(response.body)['data'][0]);
          navigatorKey.currentState?.push(
            MaterialPageRoute(builder: (_) => OrderDetailScreen(order: order)),
          );
        } catch (e, s) {
          print(e);
          print(s);
        }
      },
    );
    */
  } catch (e) {
    log("error :" + e.toString());

    /* 
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      log('onMessage message data');
      log(message.data.toString());
      log('onMessage');
      // if (value.data.isEmpty ||
      //     (await SharedPredRepresentative().getToken()) == null) return;
    });
    */
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CarProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => BrandProvider()),
        ChangeNotifierProvider(create: (context) => OfferDetailsProvider()),
      ],
      child: OverlaySupport(
        child: MaterialApp(
          title: AppConfig.appName,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // const Color(0xff7B838E)   grey
            // const Color(0xffFD4C4C)   red.shade
            fontFamily: 'markazi',
            primaryColor: Colors.black,
            colorScheme: const ColorScheme(
              primary: Colors.black,
              onPrimary: Color(0xffFD4C4C),
              background: Colors.black54,
              onBackground: Colors.black,
              secondary: Color.fromARGB(255, 206, 3, 162),
              onSecondary: Colors.white,
              error: Colors.grey,
              onError: Color.fromARGB(255, 250, 150, 0),
              surface: Color.fromARGB(255, 46, 231, 0),
              onSurface: Color.fromARGB(137, 175, 0, 0),
              brightness: Brightness.light,
            ),
          ),

          home: TabScreen(userId: ''),

          // home: const HomeScreen(
          //     userId:
          //         'e8aa0eb5-46c7-4e60-a32b-e96fd57f16252022-08-21 10:25:36.316499'),
          // home: const SplahScreen(),
          //      routes: {
          //   "red": (_) => More(),
          //   "green": (_) => CategoryScreen(),
          // },
          routes: {
            Home.routeName: (ctx) => const Home(userId: ''),
            CategoryScreen.routeName: (ctx) => const CategoryScreen(),
            Favert.routeName: (ctx) => const Favert(),
            //  Offers.routeName: (ctx) => const Offers(),
            More.routeName: (ctx) => const More(),
            AboutScreen.routeName: (ctx) => const AboutScreen(),
            VersionScreen.routeName: (ctx) => const VersionScreen(),

            // DetailsScreen.routeName: (ctx) => const DetailsScreen(gallary: ),
            TermsAndConditions.routeName: (ctx) => const TermsAndConditions(),
            SnedNotifcationScreen.routeName: (ctx) =>
                const SnedNotifcationScreen(),
          },
        ),
      ),
    );
  }
}
