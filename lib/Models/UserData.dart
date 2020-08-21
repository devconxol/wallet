import 'package:flutter/material.dart';
import 'package:wallet/Models/Account.dart';

class UserData {
  final String uid;
  final String name;
  final String email;
  final List<Account> accounts;

  UserData({this.uid, this.name, this.email, this.accounts});

// User.toJson(Map<String, dynamic> parsedJson):
// :  uid = parsedJson['uid'],
//  name = parsedJson['name'],
//   email = parsedJson['email'],
//    account = parsedJson['account'];

}
