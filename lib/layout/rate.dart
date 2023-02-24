import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../colors/colors.dart';

class RateMyApp extends StatelessWidget {
   RateMyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(

        appBar: AppBar(
          backgroundColor: canvasColor,
        ),
        body: Center(child: Lottie.asset('assets/images/coming-soon.json')),

      ),
    );
  }
}
