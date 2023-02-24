import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:salat_janaza/layout/login/login_screen.dart';
import 'package:salat_janaza/services/database_helper.dart';

import '../colors/colors.dart';
import 'home.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}


class _SplashScreen extends State<SplashScreen>{
  int splashtime = 7;
  // duration of splash screen on second

  @override
  void initState() {

    Future.delayed(Duration(seconds: splashtime), () async {
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context){
            return HomePage();

    }));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Container(
            alignment: Alignment.center,
            child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //vertically align center
                children:<Widget>[
                  Spacer(flex: 1,),
                  Lottie.asset('assets/images/splash.json'),
                  Spacer(flex: 1,),
                  Text('صلاة الجنازة',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),),
                  Spacer(flex: 1,),


                ]
            )
        )
    );
  }
}