/* import 'package:flutter/material.dart';
import 'package:wallet/Fabottoms.dart';


//void main() => runApp(caluculatorpage());

class Calculator extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      theme: ThemeData(
        primarySwatch:Colors.lightBlue,
      ),
      home: CaluculatorPage(),
    );
  }
}

class CaluculatorPage extends StatefulWidget{
  @override
  _CaluculatorPageState createState()=>_CaluculatorPageState();
}

class _CaluculatorPageState extends State<CaluculatorPage>{

final List<String> op=[
    'question',
];
var answer='Answer';
    final List<String> bottoms=[
      
      '7','8','9','Date',
      '4','5','6','+',
      '1','2','3','-',
      '.','0','X','OK',

    ];

  @override
Widget build(BuildContext context){
    var gridView = GridView.builder(
                  itemCount:op.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:1),
                    itemBuilder: (BuildContext context,int index){
                    return Question(
                      operator:op[index],
                      colorop: isOperator(op[index])? Colors.black :Colors.white,
                    );
                    }
                 /*  itemCount: bottoms.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:4),
                  itemBuilder: (BuildContext context,int index){
                    return MyBottoms(
                      text:bottoms[index],
                      color: isOperator(bottoms[index]) ? Colors.deepOrangeAccent : Colors.deepOrangeAccent[50],
                      textcolor: isOperator(bottoms[index])? Colors.white : Colors.deepOrangeAccent,
                    );
                  } */

                );
    return Scaffold(
     // backgroundColor:Colors.grey[70],
      body:Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:<Widget> [
                    /* Container(
                      alignment: Alignment.center
                        child:)  */
                        
                   /*  Container(
                      alignment: Alignment.center,
                      child:) */
                         Text(answer),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: gridView,
                    //color: Colors.black87,
            ),
            ),
          ]
      ),
    );
  }
   bool isOperator(String c ){
    if (c =='+'|| c == '-'|| c=='OK'){
      return true;
    }
    return false;
  }
} */