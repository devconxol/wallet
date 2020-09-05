import 'package:flutter/material.dart';

class AccountState with ChangeNotifier {
  String accountName = "cash";

  void changeAccount(String account){
    print("ChangeNotifier");
    print(account);
    accountName = account;
    notifyListeners();

  }

}