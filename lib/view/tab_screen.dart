import 'package:auto_car/config/app_config.dart';
import 'package:flutter/material.dart';

import 'category_screen.dart';
import 'favert.dart';
import 'home.dart';
import 'more.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectIndex = 3;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  final List<Widget> _pages = [
    const More(),
    const CategoryScreen(),
    const Favert(),
    const Home(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Auto Car"),
      // ),
      body: _pages[_selectIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectIndex,
        onTap: _navigateBottomBar,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: AppConfig.more,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: AppConfig.category,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: AppConfig.favert,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppConfig.home,
          ),
        ],
      ),
    );
  }
}
