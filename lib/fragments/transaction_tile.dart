import 'package:flutter/material.dart';
import 'package:wallet/fragments/transaction_form.dart';
import 'package:wallet/models/UserTransaction.dart';

class TransactionTile extends StatelessWidget {
  final UserTransaction transaction;
  final int index;
  final List<UserTransaction> transactions;
  final String uid;
  TransactionTile({this.uid, this.transaction, this.index, this.transactions});

  @override
  Widget build(BuildContext context) {
    void showTransactionPanel(
        String uid, String date, String category, int amount) {
       showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 60.0),
              child: TransactionForm(
                uid: uid,
                title: "Mettre à jour une transaction",
                transactionType: "recette",
                date: date,
                category: category,
                amount: amount,
                btnText: "Mettre à jour",
                index: index,
                transactions: transactions,
              ),
            );
          });
    }

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          onTap: () {
            showTransactionPanel(uid, transaction.date, transaction.category,
                transaction.amount);
            print("onTaps");
          },
          onLongPress: () {
            print("onLongPress");
          },
          title: Text(transaction.category),
          trailing: Text(transaction.amount.toString()),
        ),
      ),
    );
  }
}
