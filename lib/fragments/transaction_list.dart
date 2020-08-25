import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:wallet/fragments/transaction_form.dart';
import 'package:wallet/models/UserTransaction.dart';
import 'package:wallet/models/Users.dart';
import 'package:wallet/fragments/transaction_tile.dart';
import 'package:wallet/shared/loading.dart';

class TransactionList extends StatefulWidget {
  final List<UserTransaction> transactions;
  final String uid;

  TransactionList({this.uid, this.transactions});

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.transactions.length,
      itemBuilder: (context, index) {
        return TransactionTile(
            uid: widget.uid,
            transaction: widget.transactions[index],
            transactions: widget.transactions,
            index: index);
      },
    );
  }
}
