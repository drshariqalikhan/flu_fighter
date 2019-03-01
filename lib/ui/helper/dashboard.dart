import 'package:flutter/material.dart';
import 'package:flutter_figher/model/newsModel.dart';
import 'package:flutter_figher/ui/helper/DashData.dart';
import 'package:flutter_figher/ui/helper/alertwidget.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

class Dashboard extends StatefulWidget {
  final News InData;
  Dashboard({this.InData});
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  
  @override
  Widget build(BuildContext context) {
    var location =widget.InData.code;
    var fludataList =widget.InData.fludata;
    var country_fludata_trend;
    int alert_level;
    Strain mainStrain,otherStrain;
    var country_name;
    

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
      appBar: AppBar(title: Text(country_name),automaticallyImplyLeading: false,
      centerTitle: true,),
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
