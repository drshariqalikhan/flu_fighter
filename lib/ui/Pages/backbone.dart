import 'package:flutter/material.dart';
import 'package:flutter_figher/model/newsModel.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter_figher/ui/helper/dashboard.dart';
import 'package:flutter_figher/ui/helper/fluIcon.dart';
import 'package:flutter_figher/ui/helper/news.dart';
import 'package:flutter_figher/ui/helper/regionflu.dart';

class Backbone extends StatefulWidget {
  final News BackBoneData;
  Backbone({this.BackBoneData});
  @override
  _BackboneState createState() => _BackboneState();
}

class _BackboneState extends State<Backbone> {
    int currentPage = 1;
    FluIcons fluIcons;

    @override
    initState(){
      super.initState();
      fluIcons = new FluIcons();
    }


    _getPage(int Page, News Dat) 
{
  switch (Page) {
    case 0:
      //NewsWidget
      return NewsWidget(
        InData: widget.BackBoneData,
      );
    case 1:
      //dashboard Widget
      return Dashboard(
        InData: widget.BackBoneData,
      );
    case 2:
      //Regional FLu widget
      return RegionFluWidget(
        InData: widget.BackBoneData,
      );
  }

}

  @override
  Widget build(BuildContext context) {    
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(

      body: Center(
        child: _getPage(currentPage,widget.BackBoneData),
              ),
              bottomNavigationBar: FancyBottomNavigation(
                initialSelection: 1,
                tabs: [
                  TabData(iconData: fluIcons.news_icon,title: "Flu News"),
                  TabData(iconData: Icons.assessment,title: "${widget.BackBoneData.country} Flu"),
                  TabData(iconData:  fluIcons.asia_icon,title: "Regional Flu"),
                ],
                onTabChangedListener: (position){
                  setState(() {
                    currentPage =position;
                    
                  });
                },
              ),
              
            ),
              
            );
          }
        
        }
        
