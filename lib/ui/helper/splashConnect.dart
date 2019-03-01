import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_figher/ui/splashGetData.dart';


class SplashConnect extends StatefulWidget {
  static const wid =CircularProgressIndicator();
  final Widget altwidget;
  // final bool hasflu;

  SplashConnect({this.altwidget= wid});

  @override
  _SplashConnectState createState() => _SplashConnectState();
}

class _SplashConnectState extends State<SplashConnect> {

  var connectivityResult ;
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: (Connectivity().checkConnectivity()),
      builder: (context,snapshot){
        var res =snapshot.data;
        if(res != ConnectivityResult.none ){

          return widget.altwidget;
          
        }else{
          // setState(() {});
          return SizedBox.expand(
            child: FlatButton(
             
              onPressed: (){Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (BuildContext context){
                    return SplashGetData(
                      // hasFlu: widget.hasflu,
                    );
                  }
                )
              );},
            
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

              // Image.asset('assets/images/speroicon.png'),
              // Text("Welcome to FLU FIGHTER",style: TextStyle(fontWeight: FontWeight.bold),),
              Image.asset('assets/images/speroicon.png'),
              Text("No Internet Detected. Please Tap here to try again",style: TextStyle(fontWeight: FontWeight.bold),),
              

              ],
                
                )
            ),
          );
          
        }
    
      },


    );
  }
}

