import 'package:flutter/material.dart';
//import 'package:flutter/semantics.dart';
import 'default_background.dart';
//import 'main.dart';


class Transactions extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
 
  } 

}


class TransactionsPage extends StatefulWidget{
  @override
  _TransactionsPageState createState()=> _TransactionsPageState();
    
  
}

class _TransactionsPageState  extends State <TransactionsPage>{
MediaQueryData queryData;
  @override
  Widget build(BuildContext context) {
Size size = MediaQuery.of(context).size;
    queryData=MediaQuery.of(context);
    Padding(
   padding: EdgeInsets.all(queryData.size.width*0.07),
      child: Column(
        children:<Widget> [
          TextField(
            decoration:InputDecoration(
              labelText: ""
            )
          )

        ],

      ),
      );
     
    return Scaffold(
      appBar: AppBar (
        title: Text('Transactions'),
      ),
      body: Container( 
        height: queryData.size.height,
        child: 
            Stack(
            children: [
              CustomPaint(
                painter: DefaultBackground(),
                child: Container(),
              ),
            ]),
       ),
     );
  }
  }
  


