import 'package:demo/provider/user.dart';
import 'package:demo/screens/Authenticate/login.dart';
import 'package:demo/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<CUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Login(),
        // home: AuthService().handleAuth(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MultiProvider(
//     providers: [
//       ChangeNotifierProvider.value(value: UserProvider.initialize()),
//       ChangeNotifierProvider.value(value: AppProvider()),
//     ],
//     child: MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(primaryColor: Colors.white),
//       home: ScreensController(),
//     ),
//   ));
// }

// class ScreensController extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<UserProvider>(context);
//     switch (user.status) {
//       case Status.Uninitialized:
//         return Splash();
//       case Status.Unauthenticated:
//         return Login();
//       case Status.Authenticating:
//         return Login();
//       case Status.Authenticated:
//         return MainPage();
//       default:
//         return Login();
//     }
//   }
// }
