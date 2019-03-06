import 'package:flutter/material.dart';
import 'package:flutter_figher/ui/splashGetData.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashGetFlu extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
                  Text("FLU ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
                   Hero(tag: 'Ff',child:Image.asset('assets/images/speroicon.png',height: 20.0,),),
                   Text(" FIGHTER",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
                    ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: _fluQuesWidget(context),
          ),
            
        ],
      ),
      
    );
  }

  Widget _fluQuesWidget(BuildContext context){
    return Card( 
      color: Colors.teal,
      child:Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Do you have a cough, cold or fever?",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30.0),),
        ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(child: Text("YES") ,onPressed: ()async{
                //save 'true' to shared pref
                SharedPreferences prefs = await SharedPreferences.getInstance(); 
                await prefs.setBool('hasflu', true);
                Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (BuildContext context){
                    return SplashGetData();
                  }
                )
              );
              },),
              FlatButton(child: Text("NO") ,onPressed: ()async{
                //save 'false' to shared pref
                SharedPreferences prefs = await SharedPreferences.getInstance(); 
                await prefs.setBool('hasflu', false);
                Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (BuildContext context){
                    return SplashGetData();
                  }
                )
              );
              },),
      ],
    
    )]
    )
    );
          
  }

}