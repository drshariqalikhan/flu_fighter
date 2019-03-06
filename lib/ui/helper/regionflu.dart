import 'package:flutter/material.dart';
import 'package:flutter_figher/model/newsModel.dart';
import 'package:flutter_figher/ui/helper/DashData.dart';
import 'package:flutter_figher/ui/helper/alertwidget.dart';
import 'package:flutter_figher/ui/helper/searchBarWidget.dart';

List<Fludatum> all_regions, search_list;


class RegionFluWidget extends StatefulWidget {

  final News InData;

  RegionFluWidget({this.InData});
  @override
  _RegionFluWidgetState createState() => _RegionFluWidgetState();
}

class _RegionFluWidgetState extends State<RegionFluWidget> {

  @override
  void initState() {
    super.initState();
    search_list = widget.InData.fludata;
    search_list.sort((a,b)=>a.countryName.compareTo(b.countryName));
  }
  @override
  Widget build(BuildContext context) {
    all_regions = widget.InData.fludata;
    all_regions.sort((a,b)=>a.countryName.compareTo(b.countryName));
     
    return DefaultTabController(
      length: 1,
      child: Scaffold(

        appBar: AppBar(
        automaticallyImplyLeading: false,
          title:SearchBarWidget(appBarHt: 50.0,hintText: 'search country',searchFunction: (s)=>searchNews(s)),
          ),
        body:  TabBarView(
          children: <Widget>[                
                   
                    ListView.builder(
                      itemCount: search_list.length,
                      itemBuilder: (context,index){
                        Alertclass a =  new Alertclass(
                        Alert_val: int.parse(search_list[index].alert)); 
                        return ExpansionTile(
                          title: Center(child: Text(search_list[index].countryName),),
                          
                          leading:  Text('${a.Alert_data()['alert_level']}',style: TextStyle(fontSize: 10.0,color: a.Alert_data()['alert_color'])),
                          children: <Widget>[
                             
                

                             SingleChildScrollView(
                               child: DashDataWidget(
                                 a: a,
                                 country_fludata_trend: search_list[index].trend,
                                 mainStrain: search_list[index].mainStrain,
                                 otherStrain: search_list[index].otherStrain,
                               ),
                             ),

                            
                            
                          ],

                        );

                      },

                    )
                    
                    ],),
                          
                                      
                                
                            
                          ),
    );
                      }
searchNews(s) {
  search_list=[];
  s= s.toString().toUpperCase();
  for (var el in all_regions){
    if (el.countryName.toUpperCase().contains(s)){
      search_list.add(el);
    }
   setState(() {
     
   }); 

  }
 }
}