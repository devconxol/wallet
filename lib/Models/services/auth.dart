import 'package:firebase_auth/firebase_auth.dart';
 import 'package:wallet/models/UserData.dart';
 import 'package:wallet/models/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserData _userFromFirebaseUser( user) {
    return user != null ? UserData(uid: user.uid) : null;
  }

  Stream<UserData> user() {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future registerWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      String accountType = 'personal';

      //Créer un nouvel utilisateur
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User user = userCredential.user;

      // Sauvegarder les données de l'utlisateur dans la base de donnée
      await DatabaseService(uid: user.uid)
          .updateUserData(name, email, accountType);

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future registerBusinessWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      String accountType = 'business';

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User user = userCredential.user;

      await DatabaseService(uid: user.uid)
          .updateUserData(name, email, accountType);

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User user = userCredential.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
