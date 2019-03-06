import 'package:flutter/material.dart';
import 'package:flutter_figher/model/newsModel.dart';
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
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

