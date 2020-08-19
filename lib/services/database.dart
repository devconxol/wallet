import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:slugify/slugify.dart';
import 'package:wallet/Models/Account.dart';
import 'package:wallet/Models/UserTransaction.dart';
import 'package:wallet/Models/Users.dart';

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
    List<Account> newAccounts = new List<Account>();
 
    accounts.forEach((account) {
 
      newAccounts.add(Account(
          name: account["name"],
          solde: account['solde'],
          transactions: _transactionsFromSnapshot(account['transactions'])));
    });
 
    return newAccounts;
  }

  

  User _userFromSnapshot(DocumentSnapshot snapshot) {
    User user = User(
      uid: uid,
      name: snapshot.data['name'],
      email: snapshot.data['email'],
      accounts: _accountsFromSnapshot(snapshot.data['accounts']),
    );
 
    return user;
  }

  Future updateUserData(String name, String email) async {
    return await userCollection
        .document(uid)
        .setData({'uid': uid, 'name': name, 'email': email});
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

  Stream<User> get user {
    return userCollection.document(uid).snapshots().map(_userFromSnapshot);
  }

   
}
