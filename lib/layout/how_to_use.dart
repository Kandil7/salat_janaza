import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:salat_janaza/layout/tt.dart';

class HowToUse extends StatelessWidget {
   HowToUse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('كيفية الاستخدام'),

        ),
        body: Background(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Lottie.asset('assets/images/coming-soon.json'))
            ],
          ),
        )

      ),
    );


  }
}
