import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import '../debugger/my_debuger.dart';

class SnedNotifcationScreen extends StatefulWidget {
  const SnedNotifcationScreen({Key? key}) : super(key: key);
  static const routeName = AppConfig.snedNotifcation;

  @override
  State<SnedNotifcationScreen> createState() => _SnedNotifcationScreenState();
}

class _SnedNotifcationScreenState extends State<SnedNotifcationScreen> {
  final _form = GlobalKey<FormState>();

  bool _isLoading = false;

  final _passwordFocus = FocusNode();

  final _userNameController = TextEditingController();

  final _passwordController = TextEditingController();
  void toastMessage(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    ///forground work
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        toastMessage(message.notification!.body.toString());
        log("forground work");
        log(message.notification!.body.toString());
        log(message.notification!.title.toString());
        // Navigator.of(context).pushNamed(message.notification!.body.toString());
      }

      //  LocalNotificationService.display(message);
    });

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        myLogs("message", message.data.toString());
        myLogs("message", message.from);
        final routeFromMessage = message.data["route"];
        myLogs("routeFromMessage", routeFromMessage);

        // Navigator.of(context).pushNamed(message.data.b);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    var siz = size.height * .04;

    log(siz.toString());
    return Scaffold(
      appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _form,
              child: Column(
                children: [
                  SizedBox(height: size.height * .04),
                  TextFormField(
                    textAlign: TextAlign.left,
                    controller: _userNameController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        labelText: 'العنوان',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        )),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_passwordFocus);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the email';
                      }
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                  SizedBox(height: size.height * .04),
                  TextFormField(
                    textAlign: TextAlign.left,
                    controller: _passwordController,
                    // obscureText: _obscureText,
                    focusNode: _passwordFocus,
                    decoration: InputDecoration(
                        labelText: 'التفاصيل',
                        prefixIcon: const Icon(Icons.lock_clock_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        )),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the password';
                      }
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                  SizedBox(height: size.height * .06),
                  Container(
                    height: 50.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.primary),
                    child: TextButton(
                      child: _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white))
                          : const Text(
                              AppConfig.snedNotifcation,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.0),
                            ),
                      onPressed: () {
                        final isValid = _form.currentState!.validate();
                        if (!isValid) {
                          return;
                        }
                        _form.currentState!.save();
                        callOnFcmApiSendPushNotifications(
                            title: _userNameController.text,
                            body: _passwordController.text);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> callOnFcmApiSendPushNotifications(
      {required String title, required String body}) async {
    setState(() {
      _isLoading = true;
    });
    const postUrl = 'https://fcm.googleapis.com/fcm/send';
    final data = {
      "to": "/topics/test",
      "notification": {
        "title": title,
        "body": body,
        "image":
            "https://wheelz.me/wp-content/uploads/2020/05/2021-Kia-Picanto-facelift1-12.jpg",
      },
      "data": {
        "type": '0rder',
        "id": '28',
        "click_action": 'FLUTTER_NOTIFICATION_CLICK',
      }
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization':
          //'key=YOUR_SERVER_KEY'
          'key=AAAAIRnHHpk:APA91bFbtvY4AtEhJ9t7_l66JIdcmPYxh1ZVLdF6MgPDSTQljb4pnv620CdiGCkMTavbYUxGRVXbSablDf7wDKEFqpaBBsztZSiBwuXOl_rwT00FuqF4q79ivy0oeMvrQmzHp-MZWY5G'
    };

    final response = await http.post(Uri.parse(postUrl),
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);

    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
      });
      // on success do sth
      return true;
    } else {
      setState(() {
        _isLoading = false;
      });
      // on failure do sth
      return false;
    }
  }
}
