import 'package:flutter/material.dart';
import 'package:flutter_figher/ui/splashGetData.dart';
import 'package:flutter_figher/ui/splashGetFlu.dart';

import 'package:screenshot_and_share/generated/i18n.dart';
import 'package:screenshot_and_share/screenshot_share.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: SplashGetFlu(),

    );
  }
}

