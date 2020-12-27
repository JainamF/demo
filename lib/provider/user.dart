class CUser {
  final String uid;

  CUser({this.uid});
}

// // import 'package:artist/models/cart_item.dart';
// // import 'package:artist/models/order.dart';
// // import 'package:artist/models/product.dart';
// // import 'package:artist/models/user.dart';
// // import 'package:artist/services/order.dart';
// // import 'package:artist/services/users.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

// class UserProvider with ChangeNotifier {
//   FirebaseAuth _auth;
//   User _user;
//   Status _status = Status.Uninitialized;

//   Status get status => _status;

//   User get user => _user;

//   UserProvider.initialize() : _auth = FirebaseAuth.instance {
//     _auth.authStateChanges().listen(_onStateChanged);
//   }

// abstract class BaseAuth {
//    Future<String> signIn(String email, String password);
//    Future<String> signUp(String username, String email, String password);
//    Future<void> signOut();
// }
// class Auth implements BaseAuth {
//    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//    @override
//    Future<String> signUp(String username, String email, String password) async {
//       FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
//      try {
//         await user.sendEmailVerification();
//         return user.uid;
//      } catch (e) {
//         print("An error occured while trying to send email        verification");
//         print(e.message);
//      }
//    }
// }

//   Future<bool> signIn(String email, String password) async {
//     try {
//       _status = Status.Authenticating;
//       notifyListeners();
//       await _auth.signInWithEmailAndPassword(email: email, password: password);
//       return true;
//     } catch (e) {
//       _status = Status.Unauthenticated;
//       notifyListeners();
//       print(e.toString());
//       return false;
//     }
//   }

//   Future<bool> signUp(String name, String email, String password) async {
//     try {
//       _status = Status.Authenticating;
//       notifyListeners();
//       await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       //   .then((user) {
//       // _userServices.createUser({
//       //   'name': name,
//       //   'email': email,
//       //   'uid': user.user.uid,
//       //   'stripeId': ''
//       // });
//       // });
//       return true;
//     } catch (e) {
//       _status = Status.Unauthenticated;
//       notifyListeners();
//       print(e.toString());
//       return false;
//     }
//   }

//   Future signOut() async {
//     _auth.signOut();
//     _status = Status.Unauthenticated;
//     notifyListeners();
//     return Future.delayed(Duration.zero);
//   }

//   Future<void> _onStateChanged(User user) async {
//     if (user == null) {
//       _status = Status.Unauthenticated;
//     } else {
//       _user = user;
//       // _userModel = await _userServices.getUserById(user.uid);
//       _status = Status.Authenticated;
//     }
//     notifyListeners();
//   }
// }
