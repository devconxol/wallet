import 'package:flutter/material.dart';
import 'package:wallet/models/UserTransaction.dart';

class TransactionTile extends StatelessWidget {
  final UserTransaction transaction;
  TransactionTile({this.transaction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          title: Text(transaction.category),
          trailing: Text(transaction.amount.toString()),
        ),
      ),
    );
  }
}
