import 'package:flutter/material.dart';
import 'package:flutter_figher/model/newsModel.dart';
import 'package:flutter_figher/ui/helper/alertwidget.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

import 'package:screenshot_and_share/generated/i18n.dart';
import 'package:screenshot_and_share/screenshot_share.dart';
import 'package:flutter_figher/ui/helper/iconCard.dart';


class DashDataWidget extends StatelessWidget {
  const DashDataWidget({
    Key key,
    @required this.a,
    @required this.country_fludata_trend,
    @required this.mainStrain,
    @required this.otherStrain,
    this.isExpanded = false,
  }) : super(key: key);

  final Alertclass a;
  final country_fludata_trend;
  final Strain mainStrain;
  final Strain otherStrain;
  final isExpanded;

  @override
  Widget build(BuildContext context) {
    List<IconCard> alert_list = a.Alert_data()['alert_advicer'];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ListTile(
            leading: Text('Threat level:'), 
            title:Text('${a.Alert_data()['alert_level']}',style: TextStyle(fontSize: 30.0,color: a.Alert_data()['alert_color'])),
            trailing: IconButton(icon: Icon(Icons.share,),onPressed: ()async{await ScreenshotShare.takeScreenshotAndShare();}),),
            
          ExpansionTile(
            initiallyExpanded: isExpanded,
            leading: CircleAvatar(child: Image.asset('assets/images/speroicon.png')),
            title: Text("Expert Advice"),
            children: <Widget>[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: alert_list,
                ),
              )
            ],
          ),

           Sparkline(
             data: country_fludata_trend,
             lineColor: Colors.transparent,
             fillMode: FillMode.below,
             fillGradient: new LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.red[800], Colors.red[200]],),
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: <Widget>[
                Text('ONE YEAR FLU TREND',style: TextStyle(fontSize: 10.0),),
                Text('source: World health Organisation',style: TextStyle(fontSize: 5.0),),
               ],
             ),
             ListTile(title: Text(mainStrain.name,style: TextStyle(fontSize: 20.0),),leading: Text('Main Strain:'),),
             ListTile(title: Text(otherStrain.name,style: TextStyle(fontSize: 20.0),),leading: Text('Other Strain:'),),
             
 

        ],
      ),
    );
  }
}