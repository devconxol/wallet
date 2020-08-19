import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/Models/Users.dart';
import 'package:wallet/fragments/expense_dashboard.dart';
import 'package:wallet/fragments/income_dashboard.dart';
import 'package:wallet/screens/wrapper.dart';
import 'package:wallet/services/auth.dart';
import 'package:wallet/shared/page_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
        routes:  {
          PageRoutes.expenses: (context) => ExpenseDashboard(),
          PageRoutes.incomes: (context) => IncomeDashboard(),
        },
      ),
    );
  }
}

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner:false,
//       title: 'login',
//       theme: ThemeData(
//         primarySwatch:Colors.lightBlue,
//       ),
//       home: SignInPage(),
//     );
//   }

// }
// class SignInPage extends StatefulWidget{
//   @override
//   _SignInPageState createState()=>_SignInPageState();
// }

// class _SignInPageState  extends State <SignInPage> {
//   MediaQueryData queryData;
//   static const Color orangec = Color(0xffFEAC46);

//   @override
//     Widget build(BuildContext context) {
//       queryData=MediaQuery.of(context);
//       return Scaffold(

//       body: SingleChildScrollView(
//         child: CustomPaint(
//           painter: SignInPainter(),
//             child:Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               SizedBox(height: queryData.size.width*0.15),

//               SizedBox(height: queryData.size.width*0.08),
//               Text('          Welcome ',
//                 style: TextStyle(
//                   fontSize: queryData.size.width*0.12,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               Row(
//                 children: <Widget>[
//                   SizedBox(height: queryData.size.width*0.05),
//                   Text(
//                     '          Back',
//                     style: TextStyle(
//                       fontSize: queryData.size.width*0.12,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   )
//                 ],
//               ),

//               Padding(
//                 padding: EdgeInsets.all(queryData.size.width*0.07),
//                 child: Form(
//                   child: Column(
//                     children: <Widget>[
//                       SizedBox(height: queryData.size.width*0.6),
//                       TextFormField(
//                         decoration: InputDecoration(
//                           labelText: 'Email',
//                           hintText: 'Email',
//                           labelStyle: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: queryData.size.width*0.05
//                           ),
//                         ),
//                       ),
//                   SizedBox(height: queryData.size.width*0.03),
//                   TextFormField(
//                     obscureText:true,
//                   decoration: InputDecoration(
//                   labelText: 'Password',
//                   hintText: 'Password',
//                   labelStyle: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: queryData.size.width*0.05,
//                   ),
//                 ),
//               ),
//                      SizedBox(height: queryData.size.width*0.1),
//                      Row(
//                         mainAxisAlignment:MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           Text(
//                             'Sign In',
//                                 style: TextStyle(
//                                   fontSize: queryData.size.width*0.08,
//                                   fontWeight: FontWeight.bold,

//                                 ),

//                           ),
//                                      ClipOval(
//                                     child: Material (
//                                       color:Colors.orange,
//                                       child: InkWell(
//                                         child: Padding(
//                                           padding: EdgeInsets.all(
//                                               queryData.size.width*0.015
//                                           ),
//                                            child: IconButton(

//                                               color: Colors.black,
//                                              icon: Icon(Icons.arrow_forward,),
//                                               onPressed: () {

//                                                 Navigator.of(context).push(
//                                                   MaterialPageRoute(builder:(_)=> Home())
//                                                 );
//                                               }),
//                                   ),
//                               ),
//                                     ),
//                                      ),
//             ],
//             ),
//                       SizedBox(height: queryData.size.width*0.1),
//                       Row(
//                         mainAxisAlignment:MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           InkWell(
//                             onTap: (){
//                               print('you tapped on signUp inkwell');
//                               Navigator.of(context).push(
//                                 MaterialPageRoute(
//                                   builder: (_)=>SignUpPage(),
//                                 ),
//                               );
//                             },
//                             child: Text('Sign Up',
//                               style: TextStyle(
//                                 fontSize: queryData.size.width*0.05,
//                                 decoration: TextDecoration.underline,
//                               ),
//                             ),
//                           ),
//                 InkWell(
//                     onTap: (){
//                       print('you tapped on forgot password inkwell');

//                     },
//                     child: Text('Forgot password?',
//                       style: TextStyle(
//                         fontSize: queryData.size.width*0.05,
//                         decoration: TextDecoration.underline,
//                       ),
//                     ),
//                 ),
//                 ],
//                     ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],

//           ),
//         ),
//     ),

// );

//   }

// }

// class SignInPainter  extends CustomPainter{
//   @override
//   void paint(Canvas canvas,Size size){
//     const Color orangec = Color(0xffFEAC46);
//     const Color greyc = Color(0xff494F58);
//     const Color bluec = Color(0xff59C0E6  );
//   var paint= Paint();
//     paint.color=bluec;

//     Offset c1=Offset (size.width*1.0,size.width*0.1);
//     double radius1 = size.width*1.5;

//     canvas.drawCircle(c1, radius1, paint);

//     paint.color=greyc;

//     Offset c2=Offset (size.width*1.0,size.width*0.05);
//     double radius2 = size.width*1.0;

//     canvas.drawCircle(c2, radius2, paint);

//     paint.color=orangec;

//     Offset c3=Offset (size.width*0.05,size.width*0.00);
//     double radius3 = size.width*0.95;

//     canvas.drawCircle(c3, radius3 , paint);
//   }
//    @override
//   bool shouldRepaint(SignInPainter oldDelegate )=>false;
//   @override
//   bool shouldRebuildSemantics(SignInPainter oldDelegate)=>false;

//   }
