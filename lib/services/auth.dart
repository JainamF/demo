import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
import 'package:demo/provider/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // handleAuth() {
  //   return StreamBuilder(
  //       stream: FirebaseAuth.instance.authStateChanges(),
  //       builder: (BuildContext context, snapshot) {
  //         if (snapshot.hasData) {
  //           return Home();
  //         } else {
  //           return SignIn();
  //         }
  //       });
  // }

  // create user obj based on firebase user
  CUser _userFromFirebaseUser(User user) {
    return user != null ? CUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<CUser> get user {
    return _auth
        .authStateChanges()
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      var user = result.user;
      if (user.emailVerified) {
        return user.uid;
      } else {
        return null;
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(
      String username, String email, String password) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    User user = result.user;
    try {
      await user.sendEmailVerification();
      await FirebaseFirestore.instance
          .collection("NormalUser")
          .doc(user.uid)
          .set({
        'name': username,
        'phone': "",
        'email': email,
        'bio': "",
        'img':
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTypQUgssPXZrWN3Rgt4ohOfUq0qgfIR0dLYA&usqp=CAU",
      });
      // https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTypQUgssPXZrWN3Rgt4ohOfUq0qgfIR0dLYA&usqp=CAU
      return user.uid;
    } catch (e) {
      print("An error occured while trying to send email verification");
      print(e.message);
      return null;
    }
  }

  Future artistregisterWithEmailAndPassword(
      String username, String email, String password) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    User user = result.user;
    try {
      await user.sendEmailVerification();

      // await FirebaseFirestore.instance
      //     .collection("ArtistUser")
      //     .doc(user.uid)
      //     .set({
      //   'email': email,
      //   'approved': false,
      // });

      await FirebaseFirestore.instance
          .collection("ArtistUser")
          .doc(user.uid)
          .set({
        'approved': false,
        'name': username,
        'phone': "",
        'email': email,
        'bio': "",
        'img':
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTypQUgssPXZrWN3Rgt4ohOfUq0qgfIR0dLYA&usqp=CAU",
      });
      // https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTypQUgssPXZrWN3Rgt4ohOfUq0qgfIR0dLYA&usqp=CAU
      return user.uid;
    } catch (e) {
      print("An error occured while trying to send email verification");
      print(e.message);
      return null;
    }
  }

  Future sendPasswordResetEmail(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }

  // Future<void> resendEmailVerification() async {
  //   final User user = _auth.currentUser;
  //   user.sendEmailVerification();
  // }

  // await DatabaseService(uid: user.uid)
  //     .updateUserData('name', 'storename', 'contact', 'address');

  // await DatabaseService(uid: user.uid)
  //     .updateBookingData('name', DateTime.now(), '0');

  // await DatabaseService(uid: user.uid).updateTransactionData('name');

  // await DatabaseService(uid: user.uid).updateAdminData('NO');

  //   return _userFromFirebaseUser(user);
  // } catch (error) {
  //   print(error.toString());
  //   return null;
  // }

// sign out

  signOut() {
    FirebaseAuth.instance.signOut();
  }
}
//SignIn
// Future signIn(AuthCredential authCreds) async {
//   await FirebaseAuth.instance.signInWithCredential(authCreds);

//   // FirebaseUser user = result.user;

//   // await DatabaseService(uid: user.uid)
//   //     .updateUserData('name', 'storename', 'contact', 'address');

//   // await DatabaseService(uid: user.uid)
//   //     .updateBookingData('name', DateTime.now(), '0');

//   // await DatabaseService(uid: user.uid).updateTransactionData('name');

//   // await DatabaseService(uid: user.uid).updateAdminData('NO');
// }

// String nm1 = nam.data["name"].toString();

// signInWithOTP(smsCode, verId) {
//   AuthCredential authCreds =
//       PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
//   signIn(authCreds);
//   // registerWithEmailAndPassword(email, password);
// }

//import 'dart:async';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:google_sign_in/google_sign_in.dart';
//
//abstract class BaseAuth {
//  Future<FirebaseUser> googleSignIn();
//}
//
//class Auth implements BaseAuth {
//  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//  @override
//  Future<FirebaseUser> googleSignIn() async {
//    final GoogleSignIn _googleSignIn = GoogleSignIn();
//    final GoogleSignInAccount googleAccount = await _googleSignIn.signIn();
//    final GoogleSignInAuthentication googleAuth =
//        await googleAccount.authentication;
//
//    final AuthCredential credential = GoogleAuthProvider.getCredential(
//        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
//
//    try{
//      FirebaseUser user = await _firebaseAuth.signInWithCredential(credential);
//      return user;
//    }catch(e){
//      print(e.toString());
//      return null;
//    }
//  }
//}
