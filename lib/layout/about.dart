import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:salat_janaza/layout/tt.dart';

import '../colors/colors.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(

          backgroundColor: canvasColor,
        ),
        body: Background(
          child: Center(
            child: Column(
              children: [
                Lottie.asset('assets/images/splash.json',width: 200,height: 200),

                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10)

                  ),
                  child: Text('تطبيق صلاة الجنازة يعرض لك صلوات الجنازة القريبة \n من موقعك وكذلك يمكنك اضافة صلاة جنازة جديدة\n '
                      ' لتصل لكل المستخدمين في محيطك',

                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                    color: Colors.white
                  ),),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.1,),


                Container(
                  height: 130,
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(

                    children: [
                      Center(
                        child: Text('قال رسول الله صلى الله عليه وسلم:',
                          style: TextStyle(
                            fontFamily: 'ShantellSans',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),),
                      ),

                      Text('من صلى على الجنازة فله قيراط، ومن تبعها حتى تدفن فله قيراط. رواه البخاري',


                          style: TextStyle(
                            fontFamily: 'ShantellSans',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.red
                          ))
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),

      ),
    );
  }
}
