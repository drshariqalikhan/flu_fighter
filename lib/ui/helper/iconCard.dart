import 'package:flutter/material.dart';

class IconCard extends StatelessWidget {
  final myIcon;
  final TextLabel;

 IconCard({this.myIcon,this.TextLabel});

  @override
  Widget build(BuildContext context) {
    return   Card(
        child: Column(
          children: <Widget>[
            Icon(myIcon,size: MediaQuery.of(context).size.height/10,),
            Text(TextLabel)
          ],
        ),
      );
  }
}