import 'package:coffee_shop_app/Authenticate/signin.dart';
import 'package:coffee_shop_app/Services/database.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire;
import 'package:coffee_shop_app/Model/user.dart';

class AuthService {
  final fire.FirebaseAuth _auth = fire.FirebaseAuth.instance;

  // create user obj based on firebase user
  User? _userFromFirebase(fire.User user){
    return user != null ? User(uid: user.uid): null;
  }

  // auth change user stream
  Stream<User?> get user {
    return _auth.authStateChanges()
        .map((fire.User? user) => _userFromFirebase(user!));
  }

  // Stream<User?> get user {
  //   return _auth.authStateChanges().map((fire.User? firebaseUser) {
  //     if (firebaseUser == null) {
  //       return null; // User is not authenticated
  //     } else {
  //       return _userFromFirebase(firebaseUser);
  //     }
  //   });
  // }



  // sign in auth
  Future signInAnon() async{
    try{
      fire.UserCredential result = await fire.FirebaseAuth.instance.signInAnonymously();
      fire.User user = result.user!;
      return _userFromFirebase(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

// sing in with email & password
  Future signInWithEmailAndPassword(String email,String password) async {
    try{
      fire.UserCredential result = await fire.FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      fire.User user = result.user!;
      return _userFromFirebase(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

// register with email & password
  Future registerWithEmailAndPassword(String email,String password) async {
    try{
      fire.UserCredential result = await fire.FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      fire.User user = result.user!;

      // create a new document for the user with the uid
      await DatabaseServices(uid: user.uid).updateUserData("0", "new crew member", 100);
      return _userFromFirebase(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

// sign out
  Future signOut() async {
      try {
        return await _auth.signOut();
      }
      catch(e) {
        print(e.toString());
        return null;
      }
  }

  }