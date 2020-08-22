import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:slugify/slugify.dart';
import 'package:wallet/models/Account.dart';
import 'package:wallet/models/UserTransaction.dart';
import 'package:wallet/models/Users.dart';
import 'package:wallet/models/UserData.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference userCollection =
      Firestore.instance.collection("users");

  final CollectionReference bankCollection =
      Firestore.instance.collection("banks");

  final CollectionReference transactionCollection =
      Firestore.instance.collection("transations");

  List<UserTransaction> _transactionsFromSnapshot(List transactions) {
    List<UserTransaction> newTransactions = new List<UserTransaction>();
    transactions.forEach((account) {
      newTransactions.add(UserTransaction(
          date: account["date"],
          amount: account['amount'],
          category: account['category'],
          transactionType: account['transactionType']));
    });

    return newTransactions;
  }

  List<Account> _accountsFromSnapshot(List accounts) {
    print("_accountsFromSnapshot");
    List<Account> newAccounts = new List<Account>();

    accounts.forEach((account) {
      newAccounts.add(Account(
          name: account["name"],
          solde: account['solde'],
          transactions: _transactionsFromSnapshot(account['transactions'])));
    });

    return newAccounts;
  }

  UserData userFromSnapshot(DocumentSnapshot snapshot) {
    UserData user = UserData(
      uid: uid,
      name: snapshot.data()['name'],
      email: snapshot.data()['email'],
      accounts: _accountsFromSnapshot(snapshot.data()['accounts']),
    );

    return user;
  }

  Future updateUserData(String name, String email, String accountType) async {
    return await userCollection.document(uid).setData({
      'uid': uid,
      'name': name,
      'email': email,
      'accountType': accountType,
      'accounts': [
        {'name': 'cash', 'solde': 0, 'transactions': []}
      ]
    });
  }

  Future updateBank(String name) async {
    return await bankCollection.document(Slugify(name)).setData({'name': name});
  }

  Future addTransaction(String date, String bank, String operationType,
      String operationPartner, double amount) async {
    return await transactionCollection.add({
      'date': date,
      'bank': bank,
      'operationType': operationType,
      'amount': amount,
      'operationPartner': operationPartner
    });
  }

  Future addUserTransaction(List<UserTransaction> transactions) async {
    //  firebase.firestore.FieldValue.arrayUnion("greater_virginia")

    List<Map<String, Object>> transactionData = new List<Map<String, Object>>();

    transactions.forEach((transaction) {
      print(transaction.amount);
      String jsonTransaction = jsonEncode(transaction);
      print(jsonTransaction);
      // transactionData.add();
    });
    transactionData.add({
      'date': "12-12-2020",
      'transactionType': "recette",
      'amount': 50000,
      'category': "salaire"
    });

   /* return await userCollection.doc(uid).update({
      "accounts": FieldValue.arrayUnion([
        {'name': 'boa', 'solde': 500, }
      ])
    });*/
  }

  Stream<UserData> userData() {
    return userCollection.doc(uid).snapshots().map(userFromSnapshot);
  }
}
