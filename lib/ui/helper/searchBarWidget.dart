import 'package:flutter/material.dart';


class SearchBarWidget extends StatelessWidget {
  final double appBarHt;
  final Function searchFunction;
  final String hintText;
  SearchBarWidget({this.appBarHt, this.searchFunction,this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: appBarHt * 0.75,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child:TextField(
          maxLength: 20,
          onChanged: searchFunction,
          maxLengthEnforced: true,
          decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.white54,),
          counterStyle: TextStyle(fontWeight: FontWeight.bold),
          prefixIcon: Icon(Icons.search),
          ),
        ),
               
        
       
      );
  }
}