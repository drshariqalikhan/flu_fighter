import 'package:flutter/material.dart';
import 'package:flutter_figher/model/newsModel.dart';
import 'package:flutter_figher/ui/Pages/backbone.dart';
import 'package:flutter_figher/ui/helper/splashConnect.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:device_id/device_id.dart';
import 'package:onesignal/onesignal.dart';


class SplashGetData extends StatefulWidget {


  @override
  _SplashGetDataState createState() => _SplashGetDataState();
}

class _SplashGetDataState extends State<SplashGetData> {

  var connectivityResult ;
  Permission permission;
  Location location;
  var currentLocation;


   @override
  void initState() {
    super.initState();
    initPlatformState();
  }

   Future<void> initPlatformState() async{
     if(!mounted) return;

     var settings = {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.promptBeforeOpeningPushUrl: true
    };

     await OneSignal.shared
        .init("851420b5-ceed-445c-822e-078a4a19d9d5", iOSSettings: settings);



   }


  Future<News> getData()async{
    location = new Location();
    permission =Permission.AccessCoarseLocation;
    
    //check and get permission
    var perm = await SimplePermissions.checkPermission(permission);
    if (perm==false){
          //request permission
        await SimplePermissions.requestPermission(permission);
        setState(() {});
    }
    //get location
    currentLocation = await location.getLocation();
    var lat = currentLocation['latitude'];
    var lon = currentLocation['longitude']; 

    //get flu from shared pref
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var hasflu = prefs.getBool('hasflu'?? false);
    // print(hasflu);
    //get unique device id
    var UID = await DeviceId.getID;
    //cal api

    final res= await http.get('https://infinite-tor-43156.herokuapp.com/f?lat=$lat&lon=$lon&hasflu=$hasflu&uid=$UID');
    if(res.statusCode == 200){
      // print(res.statusCode);
      return News.fromJson(json.decode(res.body));
    }else{
      return null;
    }
  }

  

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          
          body: Center(
            child: SplashConnect(
              altwidget: FutureBuilder(
                future: getData(),
                  builder: (context,snapshot){
                   if(snapshot.hasData){
                    News news_data =snapshot.data;
                    
                     return Backbone(
                       BackBoneData: news_data,
                     );
                   }else{
                    //  print(snapshot.error);
                     return  Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                        Text("FLU ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40.0),),
                                        Hero( tag: 'Ff',child: Image.asset('assets/images/speroicon.png',height: 60.0,)),
                                        Text(" FIGHTER",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40.0),),
                                          ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: CircularProgressIndicator(),
                                ),
                                  
                              ],
                              );
                   }
                  }
              ),
            ),
          ),

          
        ),
    );
  }

}

Future<bool> saveBoolSP(String key,bool value)async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.setBool(key, value);
}
