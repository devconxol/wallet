import 'package:flutter/material.dart';

class UserTransaction {
  final String date;
  final String transactionType; // depot ou credit
  final String operationPartner;
  final String category;
  final int amount;

  UserTransaction(
      {this.date, this.transactionType, this.operationPartner, this.amount, this.category});
}
