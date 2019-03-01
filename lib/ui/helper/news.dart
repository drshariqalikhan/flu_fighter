import 'package:flutter/material.dart';
import 'package:flutter_figher/model/newsModel.dart';
import 'package:flutter_figher/ui/helper/searchBarWidget.dart';
import 'package:url_launcher/url_launcher.dart';


List<NewsElement> all_news,near_news, search_list;


class NewsWidget extends StatefulWidget {

  final News InData;

  NewsWidget({this.InData});
  @override
  _NewsWidgetState createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
 List<NewsElement> items;
 TextEditingController controller = new TextEditingController();
  String filter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items =widget.InData.news;
    items.sort((a,b)=>DateTime.parse(a.articleDate).compareTo(DateTime.parse(b.articleDate)));
    items = items.reversed.toList();
    controller.addListener(() {
        setState(() {
          filter = controller.text;
            });
            });

  }


  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextField(
        
          decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white54,),
            counterStyle: TextStyle(fontWeight: FontWeight.bold),
            prefixIcon: Icon(Icons.search), 
            hintText: "Search news",
          ),
          controller: controller,
        ),
      ),
      body: ListView.builder(
        
        itemCount: items.length,
        itemBuilder: (context,index){
          var des = items[index].descrip;
          if (des ==null){des = "no description";}

          return filter == null || filter == "" ? new ExpansionTile(title: new Text(items[index].title),children: tiledeatils(index,des),) : des.toLowerCase().contains(filter.toLowerCase()) ? new ExpansionTile(title: new Text(items[index].title),children: tiledeatils(index,des),) : new Container();
        },
      ),

    );
  }

  List<Widget> tiledeatils(index,descrip){
    return[ 
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(descrip,textAlign: TextAlign.justify,),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(items[index].articleDate.split('T')[0]),
            IconButton(icon: Icon(Icons.launch),onPressed: ()async{
            if(await canLaunch(items[index].articleUrl))
            {await launch(items[index].articleUrl);}
            else{throw 'cannot launch';}},)
          ],
        ),
      ),
     
                            
    ];
  }

}


// class _NewsWidgetState extends State<NewsWidget> {

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     search_list = widget.InData.news;
//     search_list.sort((a,b)=>DateTime.parse(a.articleDate).compareTo(DateTime.parse(b.articleDate)));
//     search_list = search_list.reversed.toList();
//   }
//   @override
//   Widget build(BuildContext context) {
//     all_news = widget.InData.news;
//     all_news.sort((a,b)=>DateTime.parse(a.articleDate).compareTo(DateTime.parse(b.articleDate)));
//     all_news = all_news.reversed.toList();
//     // near_news =widget.InData.news.near;

    
  
//     return DefaultTabController(
//       length: 1,
//       child: Scaffold(

//         appBar: AppBar(
//         automaticallyImplyLeading: false,
//           title:SearchBarWidget(appBarHt: 50.0,hintText: 'search news',searchFunction: (s)=>searchNews(s)),),
//         body:  TabBarView(
//           children: <Widget>[                
                   
//                     ListView.builder(
//                       itemCount: search_list.length,
//                       itemBuilder: (context,index){
//                         var des = search_list[index].descrip;
//                         if (des ==null){
//                           des = "no description";
//                         }
//                         return ExpansionTile(
//                           title: Text(search_list[index].title),
//                           children: <Widget>[
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 children: <Widget>[
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(des),
//                                 ),  
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: <Widget>[

//                                       Text(search_list[index].articleDate.split('T')[0]),
//                                       IconButton(icon: Icon(Icons.launch),onPressed: ()async{
//                                         if(await canLaunch(search_list[index].articleUrl))
//                                         {await launch(search_list[index].articleUrl);}
//                                         else{throw 'cannot launch';}},)
//                                     ],
//                                   ),
//                                 ),
//                                 ],
//                               ),
//                             ),
                            

                            
//                           ],

//                         );

//                       },

//                     )
                    
//                     ],),
                          
                                      
                                
                            
//                           ),
//     );
//                       }
// searchNews(s) {
//   search_list=[];
//   s= s.toString().toUpperCase();
//   for (var el in all_news){
//     if (el.descrip.toUpperCase().contains(s)|| el.title.toUpperCase().contains(s))
//     {
//       // search_list=[];
//       // print(el.descrip);
//       search_list.add(el);
//     }
//     }

//   setState(() {
  
//   });
// }
 
// }