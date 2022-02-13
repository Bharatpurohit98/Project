import 'package:flutter/material.dart';

class Sale extends StatefulWidget {
  const Sale({ Key? key }) : super(key: key);

  @override
  _SaleState createState() => _SaleState();
}

class _SaleState extends State<Sale> {
  @override
  Widget build(BuildContext context) {     
    return Scaffold(
      appBar: AppBar(
         iconTheme: IconThemeData(
         color: Colors.black,),
        backgroundColor: Colors.cyan,  
          title: Text('Sale',style: TextStyle(color: Colors.black),),
      ),
      body: Column(children: <Widget>[
        Row(//Row2
        children: [
          Container(
            padding: EdgeInsets.all(5),
            
          )
        ],),
         Row(//Row2
           children: [Container(
          padding: EdgeInsets.all(5),
          child: TextField(
          decoration: const InputDecoration(
          border: OutlineInputBorder(), 
          hintText: 'type'
           
        ),
      ),
        )]
          ),
      ]));
  } 
}   