import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:slugify/slugify.dart';
import 'package:wallet/models/Account.dart';
import 'package:wallet/models/UserTransaction.dart';
import 'package:wallet/models/UserData.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  final CollectionReference bankCollection =
      Firestore.instance.collection("banks");

  final CollectionReference transactionCollection =
      Firestore.instance.collection("transations");

   

  List<UserTransaction> _transactionsFromSnapshot(dynamic transactions) {
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

  List<UserTransaction> _transactionsFromAccountSnapshot(
      DocumentSnapshot account) {
 
    List<UserTransaction> newTransactions = new List<UserTransaction>();

    account.get("transactions").forEach((account) {
 
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
    print(snapshot.data());
    UserData user = UserData(
      uid: uid,
      name: snapshot.data()['name'],
      email: snapshot.data()['email'],
      // accounts: _accountsFromSnapshot(snapshot.get("accounts")),
    );

    return user;
  }

  Account _userAccountSnapshot(DocumentSnapshot snapshot) {
    Account account = Account(
      name: snapshot.data()['name'],
      solde: snapshot.data()['solde'],
      transactions:
          _transactionsFromAccountSnapshot(snapshot.data()['accounts']),
    );

    return account;
  }

  //  Account _userAccountsSnapshot(DocumentSnapshot snapshot) {
  //   Account account = Account(
  //     name: snapshot.data()['name'],
  //     solde: snapshot.data()['solde'],
  //     transactions:
  //         _transactionsFromAccountSnapshot(snapshot.data()['accounts']),
  //   );

  //   return account;
  // }

  Future updateUserData(String name, String email, String accountType) async {
    await userCollection.doc(uid).set({
      'uid': uid,
      'name': name,
      'email': email,
      'accountType': accountType,
    }).then((_) => userCollection
        .doc(uid)
        .collection("accounts")
        .doc("cash").set({"name": "cash", "transactions": []}));
  }
  Future addAccount(String accountName) async {
    print('addAccount');
    print(accountName);


    return await userCollection
        .doc(uid)
        .collection("accounts")
        .doc(accountName).set({"name": accountName, "transactions": []});
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



  Future addUserTransaction(
      {
        String account,
        String date,
      String transactionType,
      String category,
      int amount,
      int index}) async {
        print("account");
        print(account);
    //  firebase.firestore.FieldValue.arrayUnion("greater_virginia")

    /*dynamic transactionData = [];
    transactions.forEach((transaction) {
      String jsonTransaction = jsonEncode(transaction);
      print(jsonTransaction);
      transactionData.add({
        'date': transaction.date,
        'transactionType': transaction.transactionType,
        'amount': transaction.amount,
        'category': transaction.category
      });

      // transactionData.add();
    });
    print(transactionData);*/

    // transactionData.add({
    //   'date': "12-12-2020",
    //   'transactionType': "recette",
    //   'amount': 50000,
    //   'category': "salaire"
    // });

    return await userCollection
        .doc(uid)
        .collection("accounts")
        .doc(account)
        .update({
      "transactions": FieldValue.arrayUnion([
        {
          'date': date,
          'transactionType': transactionType,
          'amount': amount,
          'category': category
        }
      ])
    });

    /*.set({
      'date': "12-12-2020",
      'transactionType': "recette",
      'amount': 50000,
      'category': "salaire"
    });
*/
    /*.update({
      "accounts": FieldValue.arrayUnion([
        {'name': 'boa', 'solde': 500, "transactions": transactionData}
      ])
    });*/
  }

  Future updateTransaction(List<UserTransaction> transactions) async {
    dynamic jsonTransactions = [];

    transactions.forEach((transaction) {
      jsonTransactions.add({
        'date': transaction.date,
        'amount': transaction.amount,
        'category': transaction.category,
        'transactionType': transaction.transactionType
      });
    });

    //print(jsonTransactions);
    Future data = userCollection.doc(uid).get();
 
    return await userCollection
        .doc(uid)
        .collection("accounts")
        .doc("cash")
        .update({"transactions": jsonTransactions});
  }

  Stream<UserData> userData() {
    return userCollection.doc(uid).snapshots().map(userFromSnapshot);
  }


  Stream<Account> userAccount() {
    return userCollection
        .doc(uid)
        .collection("accounts")
        .doc("cash")
        .snapshots()
        .map(_userAccountSnapshot);
  }

 Stream  userAccounts() {
    return 
      FirebaseFirestore.instance.collection("users")
        .doc(uid)
        .collection("accounts").snapshots();
  }
  Stream<List<UserTransaction>> userTransactions({String account = "cash"}) {
    print("userTransactions");
    print(account);
    
    return userCollection
        .doc(uid)
        .collection("accounts")
        .doc(account)
        .snapshots()
        .map(_transactionsFromAccountSnapshot);
  }
}
