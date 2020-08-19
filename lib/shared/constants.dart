import 'package:flutter/material.dart';
import 'package:wallet/Models/UserTransaction.dart';
import 'package:wallet/fragments/transaction_form.dart';

const textInputDecoration = InputDecoration(
  hintText: 'Email',
  filled: true,
  fillColor: Colors.white,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0)),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.orangeAccent, width: 2.0)),
);

List<int> amountsFromUserData(List<UserTransaction> userTransactions) {
    List<int> amounts = new List<int>();
    userTransactions.forEach((transaction) {
      amounts.add(transaction.amount);
    });
    return amounts;
  }


