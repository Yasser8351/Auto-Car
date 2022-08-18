import 'dart:async';

import 'package:auto_car/config/app_config.dart';
import 'package:flutter/material.dart';

import 'tab_screen.dart';

// class SplahScreen extends StatefulWidget {
//   const SplahScreen({Key? key}) : super(key: key);

// //  const SplahScreen({key? key})
//   @override
//   State<SplahScreen> createState() => _SplahScreenState();
// }

// class _SplahScreenState extends State<SplahScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Timer(
//     //   Duration(seconds: 2),
//     //   () => Navigator.pushReplacement(
//     //     context,
//     //     MaterialPageRoute(
//     //       builder: (context) => HomePage(),
//     //     ),
//     //   ),
//     // );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.primary,
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           //color: Colors.white,
//           color: Theme.of(context).colorScheme.primary,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Image.asset(
//               AppConfig.iconApp,
//               height: 200,
//               width: 200,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class SplahScreen extends StatefulWidget {
  const SplahScreen({Key? key}) : super(key: key);

  @override
  State<SplahScreen> createState() => _SplahScreenState();
}

class _SplahScreenState extends State<SplahScreen> {
  bool selected = false;
  @override
  void initState() {
    super.initState();

    Timer(
        Duration(seconds: 1),
        () => setState(() {
              selected = !selected;
            })
        // () => Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => TabScreen(),
        //   ),

        );
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => TabScreen(),
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
        child: Container(
          width: size.width,
          height: 250.0,
          child: AnimatedAlign(
            alignment: selected ? Alignment.centerRight : Alignment.centerLeft,
            duration: const Duration(seconds: 3),
            curve: Curves.fastOutSlowIn,
            child: Image.asset(
              AppConfig.iconApp2,
              height: 150,
              width: 150,
            ),
          ),
        ),
      ),
    );
  }
}
