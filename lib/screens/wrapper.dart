import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/Models/Users.dart';
import 'package:wallet/fragments/expense_dashboard.dart';
import 'package:wallet/screens/authenticate/authenticate.dart';
import 'package:wallet/screens/dashboard/expense_dashboard.dart';
import 'package:wallet/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return ExpenseDashboard();
    }
  }
}
