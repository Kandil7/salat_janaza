import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../colors/colors.dart';

class ContactWithUs extends StatelessWidget {
  const ContactWithUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Uri facebook =Uri.parse('https://www.facebook.com/profile.php?id=100090376186396&mibextid=ZbWKwL');
    final Uri khamsat = Uri.parse('https://khamsat.com/user/anwar_safy');
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: canvasColor,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(
              flex: 1,
            ),
            GestureDetector(
              onTap: (){
                launchUrl(facebook);
              },

                child: Center(child: Image.asset('images/face.png'))),
            Spacer(
              flex: 1,
            ),
            GestureDetector(
              onTap: (){
                launchUrl(khamsat);
              },
              child: Center(
                  child: Image.asset(
                'images/khamsat.png',
                width: 250,
                height: 250,
              )),
            ),
            Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
