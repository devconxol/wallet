import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget{

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard>{


  @override
  Widget build(BuildContext context){
    return Container(
      height: 300,
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 5,
        child: Row(
          children:<Widget>[
            Container(
              child: FlatButton(
                onPressed:(){
                  
                },
                child: Center(child:Text("Entrée"))
              )
            ),
            _separator(),
            Container(
              child: FlatButton(
                onPressed:(){
                  
                },
                child: Center(child:Text("Entrée"))
              )
            ),
            _separator(),
            Container(
              child: FlatButton(
                onPressed:(){
                  
                },
                child: Center(child:Text("Entrée"))
              )
            ),
          ]
        ),
      ),
    ); 
  
   }

   
   Widget _separator(){
     return Container(
              width: 2,
              decoration: BoxDecoration(
                color: Colors.grey[200],
              )
            );
   }

}