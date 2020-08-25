import 'package:flutter/material.dart';

class UserTransaction {
   String date;
   String transactionType; // depot ou credit
    String category;
    int amount;

  UserTransaction(
      {this.date, this.transactionType,   this.amount, this.category});



  Map toJson() => {
    'date': date,
    'transactionType': transactionType,
    'category': category,
    'amount': amount,

  }; 


}
