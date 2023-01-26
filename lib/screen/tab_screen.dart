import 'package:auto_car/config/app_config.dart';
import 'package:auto_car/debugger/my_debuger.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'category_screen.dart';
import 'favert.dart';
import 'home.dart';
import 'more.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key, required this.userId}) : super(key: key);
  final String userId;

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectIndex = 0;
  DateTime timeBackPressed = DateTime.now();

  void _navigateBottomBar(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  final List<Widget> _pages = [
    const Home(userId: false),
    const Favert(),
    const CategoryScreen(),
    const More(),
  ];

  @override
  void initState() {
    super.initState();
    _pages.add(Home(userId: widget.userId));
    myLogs('userId from TabScreen', widget.userId);
    FirebaseMessaging.instance.subscribeToTopic('test');
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: WillPopScope(
              onWillPop: () async {
                final differenc = DateTime.now().difference(timeBackPressed);
                final exitApp = differenc >= Duration(seconds: 2);

                timeBackPressed = DateTime.now();

                if (exitApp) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Theme.of(context).primaryColor,
                      duration: const Duration(seconds: 2),
                      content: Text(
                        AppConfig.exitApp,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  );
                  return false;
                } else {
                  return true;
                }
              },
              child: Scaffold(
                body: _pages[_selectIndex],
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: _selectIndex,
                  onTap: _navigateBottomBar,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: AppConfig.home,
                      activeIcon: Icon(Icons.home,
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.favorite_border),
                      label: AppConfig.favert,
                      activeIcon: Icon(Icons.favorite_border,
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.search),
                      label: 'Search',
                      activeIcon: Icon(Icons.search,
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline_sharp),
                      activeIcon: Icon(Icons.person_outline_sharp,
                          color: Theme.of(context).colorScheme.onPrimary),
                      label: AppConfig.more,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
