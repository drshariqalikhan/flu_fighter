import 'package:flutter/material.dart';
import 'package:flutter_figher/ui/helper/fluIcon.dart';
import 'package:flutter_figher/ui/helper/iconCard.dart';

class Alertclass {
  int Alert_val;

  Alertclass({this.Alert_val});
  static FluIcons fluIcons = new FluIcons() ;

  _alert_level(){
    switch (this.Alert_val) {
      case 0 :
        return "Low";
        break;
      case 1 :
        return "Moderate";
        break;
      case 2 :
        return "High";
        break;
      case 3 :
        return "Extreme";
        break;
      default:
        return "out of range";

    }
  }

   _alert_color(){
    switch (this.Alert_val) {
      case 0 :
        return Colors.green ;
        break;
      case 1 :
        return Colors.yellow;
        break;
      case 2 :
        return Colors.red;
        break;
      case 3 :
        return Colors.purple;
        break;
      default:
        return Colors.white;

    }
  }

  List<IconCard> Cards = [
                IconCard(
                  myIcon: fluIcons.vaccination,
                  TextLabel: 'Get yearly Flu vaccine',
              ),
                IconCard(
                  myIcon: fluIcons.hand_wash,
                  TextLabel: 'wash hands regularly',
              ),
              IconCard(
                  myIcon: fluIcons.mask_cough,
                  TextLabel: 'Wear a face mask if ill',
                ),
                IconCard(
                  myIcon: fluIcons.hand_sanitizer,
                  TextLabel: 'use hand sanitizer after touching any object',
              ),
              IconCard(
                  myIcon: fluIcons.mask,
                  TextLabel: 'Wear a face mask in crowded places',
              ),
              IconCard(
                  myIcon: fluIcons.no_crowd,
                  TextLabel: 'avoid crowded places',
              ),
              IconCard(
                  myIcon: Icons.home,
                  TextLabel: 'Stay Indoors',
              ),
              IconCard(
                  myIcon: fluIcons.stockpile,
                  TextLabel: 'Stockpile food and essentials',
              ),
              
             

              ];

   _alert_advice(){
    switch (this.Alert_val) {
      case 0 :
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: Cards.sublist(0,3),
        );
            

          
        break;
      case 1 :
        return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,

          children: Cards.sublist(0,5),
        );
        break;
      case 2 :
        return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,

          children: Cards.sublist(0,6),
        );
        break;
      case 3 :
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:Cards,
        );
        break;
      default:
        return Card(
          child: Column(
            children: <Widget>[
              Icon(Icons.announcement),
              Text('Wash hands regularly'),
              Text('Wear a face mask if ill'),
            ],
          ),
        ) ;

    }
  }



 List<IconCard> _alert_advicer()
{    switch (this.Alert_val) 
  {

      case 0 :
        return Cards.sublist(0,3);
          
        break;
      case 1 :
        return Cards.sublist(0,5);
        break;
      case 2 :
        return Cards.sublist(0,6);
        break;
      case 3 :
        return Cards;
        break;
      default:
        return Cards.sublist(0,3);

        
  }
}
  




   Map<String,dynamic> Alert_data(){
    return {
      'alert_level':_alert_level(),
      'alert_color':_alert_color(),
      'alert_advice':_alert_advice(),
      'alert_advicer':_alert_advicer()
    };
  }


  


  
}