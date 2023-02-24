import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:lottie/lottie.dart';

import '../colors/colors.dart';

class ShareApp extends StatelessWidget {
  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text:'تطبيق صلاة الجنازة يعرض لك صلوات الجنازة القريبة من موقعك '
            'و كذالك يمكنك إضافة صلاة جنازة جديدة لتصل لكل'
            ' المستخدمين في محيطك.'

       , linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }

  Future<void> shareFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null || result.files.isEmpty) return null;

    await FlutterShare.shareFile(
      title: 'Example share',
      text: 'Example share text',
      filePath: result.files[0] as String,
    );
  }

@override
Widget build(BuildContext context) {
  return
   Directionality(
     textDirection: TextDirection.rtl,
     child: Scaffold(
       backgroundColor: scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: canvasColor,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Lottie.asset('assets/images/share.json'),
              Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                  child: ElevatedButton(onPressed: share, child: Text('Share')))
            ],
          ),
        ),

  ),
   );
}}
