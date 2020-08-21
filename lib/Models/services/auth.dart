import 'package:firebase_auth/firebase_auth.dart';
import 'package:wallet/Models/Users.dart';
import 'package:wallet/models/UserData.dart';
import 'package:wallet/models/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> user() {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  Future registerWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      String accountType = 'personal';

      //Créer un nouvel utilisateur
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      FirebaseUser user = result.user;

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

      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      FirebaseUser user = result.user;

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
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      FirebaseUser user = result.user;
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
