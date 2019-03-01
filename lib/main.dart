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

//  void main() => runApp(App());

// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData.dark(),
//       home: Test(),
      
//     );
//   }
// }

// class Test extends StatefulWidget {
//   @override
//   _TestState createState() => _TestState();
// }

// class _TestState extends State<Test> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('data'),),
//       body: Center(child: Text('some data')),
//       floatingActionButton: FloatingActionButton(
//         onPressed: ()async{
//         await ScreenshotShare.takeScreenshotAndShare();

               

//         },
//       ),
      
//     );
//   }
// }