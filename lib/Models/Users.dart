import 'package:flutter/material.dart';
import 'package:wallet/models/Account.dart';

class User {
  final String uid;
  final String name;
  final String email;
  final List<Account> accounts;

  User({this.uid, this.name, this.email, this.accounts});

  Map toJson() => {
    'uid': uid,
    'name': name,

  };

  // <int>

// User.toJson(Map<String, dynamic> parsedJson):
// :  uid = parsedJson['uid'],
//  name = parsedJson['name'],
//   email = parsedJson['email'],
//    account = parsedJson['account'];

}
