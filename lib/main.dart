import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/Models/Users.dart';
import 'package:wallet/fragments/expense_dashboard.dart';
import 'package:wallet/fragments/income_dashboard.dart';
import 'package:wallet/models/UserData.dart';
import 'package:wallet/models/services/auth.dart';
import 'package:wallet/models/services/database.dart';
import 'package:wallet/screens/authenticate/authenticate.dart';
import 'package:wallet/screens/authenticate/register.dart';
import 'package:wallet/screens/wrapper.dart';
import 'package:wallet/shared/page_routes.dart';

void main() {
  runApp(WalletApp());
}

class WalletApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>(
      create: (BuildContext context) => AuthService().user(),
      child: MaterialApp(home: Wrapper()),
    );
  }
}

/*




*/
/*
class MyAppp extends StatefulWidget {
  @override
  _MyApppState createState() => _MyApppState();
}

class _MyApppState extends State<MyAppp> {
  StreamSubscription<User> authenticationStreamSubscription;
  Stream<UserData> userDataStream;

  StreamSubscription<User> setLoggedInUserStream() {
    authenticationStreamSubscription =
        AuthService().user().listen((firebaseUser) {
      print('listening');
      userDataStream = DatabaseService(uid: firebaseUser?.uid).userData();
    });
  }

  @override
  void initState() {
    super.initState();
    authenticationStreamSubscription = setLoggedInUserStream();
  }

  @override
  void dispose() {
    super.dispose();
    authenticationStreamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserData>.value(
        value: userDataStream,
        child: MaterialApp(
            // Provide a function to handle named routes. Use this function to
            // identify the named route being pushed, and create the correct
            // Screen.
            onGenerateRoute: (settings) {
              // If you push the PassArguments route
              if (settings.name == PassArgumentsScreen.routeName) {
                // Cast the arguments to the correct type: ScreenArguments.
                final ScreenArguments args = settings.arguments;

                // Then, extract the required data from the arguments and
                // pass the data to the correct screen.
                return MaterialPageRoute(
                  builder: (context) {
                    return PassArgumentsScreen(
                      title: args.title,
                      message: args.message,
                    );
                  },
                );
              }
              // The code only supports PassArgumentsScreen.routeName right now.
              // Other values need to be implemented if we add them. The assertion
              // here will help remind us of that higher up in the call stack, since
              // this assertion would otherwise fire somewhere in the framework.
              assert(false, 'Need to implement ${settings.name}');
              return null;
            },
            title: 'Navigation with Arguments',
            home: Wrapper(),
            routes: {
              ExtractArgumentsScreen.routeName: (context) =>
                  ExtractArgumentsScreen(),
            }));
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // A button that navigates to a named route that. The named route
            // extracts the arguments by itself.
            RaisedButton(
              child: Text("Navigate to screen that extracts arguments"),
              onPressed: () {
                // When the user taps the button, navigate to a named route
                // and provide the arguments as an optional parameter.
                Navigator.pushNamed(
                  context,
                  ExtractArgumentsScreen.routeName,
                  arguments: ScreenArguments(
                    'Extract Arguments Screen',
                    'This message is extracted in the build method.',
                  ),
                );
              },
            ),
            // A button that navigates to a named route. For this route, extract
            // the arguments in the onGenerateRoute function and pass them
            // to the screen.
            RaisedButton(
              child: Text("Navigate to a named that accepts arguments"),
              onPressed: () {
                // When the user taps the button, navigate to a named route
                // and provide the arguments as an optional parameter.
                Navigator.pushNamed(
                  context,
                  PassArgumentsScreen.routeName,
                  arguments: ScreenArguments(
                    'Accept Arguments Screen',
                    'This message is extracted in the onGenerateRoute function.',
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// A Widget that extracts the necessary arguments from the ModalRoute.
class ExtractArgumentsScreen extends StatelessWidget {
  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute settings and cast
    // them as ScreenArguments.
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Center(
        child: Text(args.message),
      ),
    );
  }
}

// A Widget that accepts the necessary arguments via the constructor.
class PassArgumentsScreen extends StatelessWidget {
  static const routeName = '/passArguments';

  final String title;
  final String message;

  // This Widget accepts the arguments as constructor parameters. It does not
  // extract the arguments from the ModalRoute.
  //
  // The arguments are extracted by the onGenerateRoute function provided to the
  // MaterialApp widget.
  const PassArgumentsScreen({
    Key key,
    @required this.title,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
}

// You can pass any object to the arguments parameter. In this example,
// create a class that contains both a customizable title and message.
class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}
*/
