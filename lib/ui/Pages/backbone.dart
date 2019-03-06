import 'package:flutter/material.dart';
import 'package:flutter_figher/model/newsModel.dart';
import 'package:flutter_figher/ui/helper/dashboard.dart';
import 'package:flutter_figher/ui/helper/fluIcon.dart';
import 'package:flutter_figher/ui/helper/news.dart';
import 'package:flutter_figher/ui/helper/regionflu.dart';
import 'appId.dart' show App_ID,AdUnitID;
import 'package:firebase_admob/firebase_admob.dart';



class Backbone extends StatefulWidget {
  final News BackBoneData;
  Backbone({this.BackBoneData});
  @override
  _BackboneState createState() => _BackboneState();
}

class _BackboneState extends State<Backbone> {



BannerAd _bannerAd; 
// InterstitialAd interstitialAd;

static final MobileAdTargetingInfo targetingInfo = new MobileAdTargetingInfo(
  keywords: <String>['medical','health','beauty','soap','sanitizer','pollution','flu','treatment'],
    testDevices: <String>[],
  );

BannerAd createBannerAd() {
  return new BannerAd(
    size: AdSize.smartBanner,
    adUnitId:AdUnitID,
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      if (event == MobileAdEvent.loaded) {
        setState((){
        });
      } else if (event == MobileAdEvent.failedToLoad) {
        setState((){
        });
      }
    },
  );
}

    int currentPage = 1;
    FluIcons fluIcons;

    @override
    initState(){
      print("init callled");
      super.initState();
      fluIcons = new FluIcons();
      FirebaseAdMob.instance.initialize(appId: App_ID).then((response){
       _bannerAd = createBannerAd()..load()..show(anchorType: AnchorType.bottom);
       setState(() {
         
       });
      });
    
    
        
    }

    @override
    void dispose(){
      super.dispose();
      _bannerAd?.dispose();

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
      child:
      Scaffold(
        bottomNavigationBar: Container(
          height: 60.0,
        ),
        body: 
      Scaffold(
          
  
          body: Center(
                child: _getPage(currentPage,widget.BackBoneData),
          ),
            
          bottomNavigationBar: BottomNavigationBar(
       

            items:<BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(fluIcons.news_icon,color: currentPage == 0?Colors.yellow:Colors.white,), title: Text('Flu News')),
          BottomNavigationBarItem(icon: Icon(Icons.home,color: currentPage == 1?Colors.yellow:Colors.white,), title: Text('${widget.BackBoneData.country} Data')),
          BottomNavigationBarItem(icon: Icon(fluIcons.asia_icon,color: currentPage == 2?Colors.yellow:Colors.white,), title: Text('Regional Data')),
            ],
           currentIndex: 1,
           onTap: (position){
             setState(() {
              currentPage =position; 
             });
           }, 

          ), 
         
        ),
      ),
     

            );
          }
        
        }
        


