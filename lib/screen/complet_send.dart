import 'package:auto_car/config/app_config.dart';
import 'package:auto_car/screen/tab_screen.dart';
import 'package:flutter/material.dart';

import '../sharedpref/user_share_pref.dart';

class CompletSend extends StatefulWidget {
  const CompletSend({Key? key}) : super(key: key);

  @override
  State<CompletSend> createState() => _CompletSendState();
}

class _CompletSendState extends State<CompletSend> {
  String userId = '';
  _getUSerFromSharedPref() async {
    var temp = await SharedPrefUser().getUid();
    setState(() {
      userId = temp;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_sharp,
              size: 80,
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                AppConfig.sendInvoiceCompleted,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shadowColor: Color.fromARGB(255, 90, 68, 3),
                primary: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => TabScreen(userId: userId)));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppConfig.backToHome,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
