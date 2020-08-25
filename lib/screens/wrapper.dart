import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/models/Users.dart';
import 'package:wallet/fragments/expense_dashboard.dart';
import 'package:wallet/fragments/income_dashboard.dart';
import 'package:wallet/models/UserData.dart';
import 'package:wallet/models/services/database.dart';
import 'package:wallet/screens/authenticate/authenticate.dart';
import 'package:wallet/screens/dashboard/expense_dashboard.dart';
import 'package:wallet/screens/home/home.dart';
import 'package:wallet/shared/page_routes.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<UserData>(context);

    if (user == null) {
      return Authenticate();
    } else { 

      return MaterialApp(
        home: ExpenseDashboard(),
        routes: {
          PageRoutes.expenses: (context) => ExpenseDashboard(),
          PageRoutes.incomes: (context) => IncomeDashboard(),
        },
      );
    }
  }
}

// StreamProvider<User>(
//       create: (BuildContext context) => AuthService().user(),
//       child: MaterialApp(
//         home: Wrapper()

//       ),
//     );
