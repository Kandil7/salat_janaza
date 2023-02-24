import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:salat_janaza/layout/tt.dart';

import '../colors/colors.dart';
import 'component/component.dart';

class HowToPray extends StatelessWidget {
   HowToPray({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:canvasColor ,
        ),
        body: Background(
          child: Column(
          children: [
          Lottie.asset('assets/images/home.json',width: 300,height: 190),
          Spacer(flex: 1,),
          Container(margin: EdgeInsets.all(10),

              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Text('صلاة الجنازة أربع تكبيرات دون ركوع أو سجود.',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),)
          ),
          Spacer(flex: 1,),
          Container(
              padding: EdgeInsets.all(10
              ),
              width: double.infinity,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Text('بعد التكبيرة الأولى تقرأ الفاتحة.',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),)
          ),
          Spacer(flex: 1,),
          Container(
              padding: EdgeInsets.all(10

              ),
              margin: EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                color: Colors.white.withOpacity(0.7)
              ),
              child: Text('بعد التكبيرة الثانية\n يصلّي على النبي صلى الله عليه وسلم بالصيغة الإبراهيمية كما في اخر التشهد (اللهم صل على محمد وآل محمد كما صليت على إبراهيم وعلى آل إبراهيم إنك حميد مجيد وبارك على محمد وعلى آل محمد كما باركت على إبراهيم وعلى آل إبراهيم إنك حميد مجيد)',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),)
          ),
          Spacer(flex: 1,),
          Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Text('وبعد التكبيرة الثالثة\n يدعو للمتوفى (اللهم أغفر له وارحمه وأعف عنه ..)',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 19
                ),)
          ),
          Spacer(flex: 1,),
          Container(

              margin: EdgeInsets.all(7),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                color: Colors.white.withOpacity(0.7)
              ),
              child: Text("وبعد التكبيرة الرابعة \n يدعو لعموم موتى المسلمين ثم التسليم",
                style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),)
          ),
            Spacer(flex: 1,),





          ],
      ),
        ),

      ),
    );
  }
}
