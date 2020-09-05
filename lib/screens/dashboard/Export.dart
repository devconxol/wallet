import 'dart:io';

import 'package:csv/csv.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:wallet/models/UserData.dart';
import 'package:wallet/models/UserTransaction.dart';
import 'package:wallet/models/services/database.dart';
import 'package:wallet/screens/dashboard/acountState.dart';
import 'package:wallet/shared/loading.dart';

class Export extends StatefulWidget {
  @override
  _ExportState createState() => _ExportState();
}

class _ExportState extends State<Export> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);
    final account = Provider.of<AccountState>(context);

      Future<Directory> _getDownloadDirectory() async {
    if (Platform.isAndroid) {
      if (await Permission.storage.request().isGranted) {
  // Either the permission was already granted before or the user just granted it.
      return await DownloadsPathProvider.downloadsDirectory;
}
    }
 
    // in this example we are using only Android and iOS so I can assume
    // that you are not trying it for other platforms and the if statement
    // for iOS is unnecessary
  
    // iOS directory visible to user
    return await getApplicationDocumentsDirectory();
  }

    Future<void> _generateCSV(context, List<UserTransaction> transactions, String accountName) async {
      List<List<String>> csvData = [
        <String>['Date', 'Type de transaction', 'Catégorie', 'Montant' ],
        ...transactions.map((transaction) => [transaction.date, transaction.transactionType, transaction.category, transaction.amount.toString()])
      ];

      String csv = ListToCsvConverter().convert(csvData);

      
      _getDownloadDirectory().then((dir) async {
        
      final String path = dir.path  + '/wallet-$accountName.csv';
      print("path");
      print(path);
      

      final File file =  File(path);
      await file.writeAsString(csv);
      Navigator.pop(context);
      });
    

      // final String dir =  (await getApplicationDocumentsDirectory()).path;


    }

    return StreamBuilder<List<UserTransaction>>(
      stream: DatabaseService(uid: user.uid).userTransactions(account: account.accountName),
      builder: (context, snapshot) {
         if (snapshot.hasData) {
             List<UserTransaction> transactions = snapshot.data
        
                .toList();

                return ListTile(
                        leading: Icon(
                          Icons.share,
                          color: Colors.green,
                        ),
                        title: Text("Export"),
                        onTap: () async{ 
                         await _generateCSV(context, transactions, account.accountName);
                        Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Votre portefeuile ${account.accountName} a été exporté avec succès')));
                        },
                      );

         } else {
           return Loading();
         }

              }
    );
  }
}