import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,

    this.bottomImage = "assets/images/img.png",
  }) : super(key: key);

  final String  bottomImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[





            Image.asset(bottomImage,fit: BoxFit.cover,width: MediaQuery.of(context).size.width,),

            SafeArea(child: child),

          ],
        ),
      ),
    );
  }
}
