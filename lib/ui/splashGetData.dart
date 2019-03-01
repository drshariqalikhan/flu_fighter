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


class SplashGetData extends StatefulWidget {


  @override
  _SplashGetDataState createState() => _SplashGetDataState();
}

class _SplashGetDataState extends State<SplashGetData> {

  var connectivityResult ;
  Permission permission;
  Location location;
  var currentLocation;


  


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
    //TODO: Add hasflu to API call
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
//             print(snapshot.data)
                    News news_data =snapshot.data;
                    // var user_location =news_data.loc;
                    
                    // List<All> all_news_list = news_data.news.all;
                    // List<All> near_news_list = news_data.news.near; 
                    // List<double> points =news_data.fludata.trend;

                     return Backbone(
                       BackBoneData: news_data,
                     );
                   }else{
                    //  print(snapshot.error);
                     return  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                Text("Welcome to FLU FIGHTER",style: TextStyle(fontWeight: FontWeight.bold),),
                Image.asset('assets/images/speroicon.png'),
                CircularProgressIndicator(),
                ] );
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
