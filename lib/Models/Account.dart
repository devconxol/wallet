import 'package:flutter/material.dart';
import 'package:wallet/models/UserTransaction.dart';

class Account {
  final String name;
  final int solde;
  final List<UserTransaction> transactions;

  Account({this.name, this.solde, this.transactions});
}
