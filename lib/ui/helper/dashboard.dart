import 'package:flutter/material.dart';
import 'package:flutter_figher/model/newsModel.dart';
import 'package:flutter_figher/ui/helper/DashData.dart';
import 'package:flutter_figher/ui/helper/alertwidget.dart';
import 'package:flutter_figher/ui/helper/marqee.dart';


class Dashboard extends StatefulWidget {
  final News InData;
  Dashboard({this.InData});
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {


  _getAreaColor(int usernum){
    if(usernum < 2){
      return null;
    }
    else if(usernum >5){
      return 'FLU FIGHTER ALERT! MANY SUSPECTED CASES IN 5Km : TAKE MAJOR PRECAUTIONS'; 
    }else{
      return 'FLU FIGHTER ALERT! SUSPECTED CASES DETECTED IN 5Km!';
    }
  }

  
  @override
  Widget build(BuildContext context) {
    var location =widget.InData.code;
    var fludataList =widget.InData.fludata;
    var country_fludata_trend;
    int alert_level;
    Strain mainStrain,otherStrain;
    var country_name;
    var flu_users =widget.InData.fluNear;
    

    for(var f in fludataList){
      if (f.country.toUpperCase() == location.toUpperCase()){
        country_fludata_trend = f.trend.sublist(0,f.trend.length-3);
        alert_level = int.parse(f.alert);
        country_name = f.countryName;
        mainStrain = f.mainStrain;
        otherStrain = f.otherStrain;
        
        //todo other param
      }
    }
    Alertclass a =  new Alertclass(
      Alert_val: alert_level
    );

    
    return Scaffold(
      appBar: AppBar(title: MarqueeWidget( direction: Axis.horizontal,child: Text(_getAreaColor(flu_users)?? country_name.toUpperCase()),),//text:_getAreaColor(flu_users)?? country_name.toUpperCase()) ,
      leading: Image.network('https://www.countryflags.io/$location/shiny/64.png'),
      automaticallyImplyLeading: false,
        ),
      body: SingleChildScrollView(
        child: new DashDataWidget(
          isExpanded: true,
          a: a, 
          country_fludata_trend: country_fludata_trend, 
          mainStrain: mainStrain, 
          otherStrain: otherStrain),
      )
        ,
      
    );
  }
}
