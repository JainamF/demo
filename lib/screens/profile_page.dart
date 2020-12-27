import 'package:demo/app_properties.dart';
import 'package:demo/screens/Authenticate/login.dart';
import 'package:demo/screens/edit_profile.dart';
// import 'package:artist/screens/faq_page.dart';
import 'package:demo/screens/payment/payment_page.dart';
import 'package:demo/screens/settings/settings_page.dart';
import 'package:demo/screens/tracking_page.dart';
// import 'package:artist/screens/ArtistView/addpainting.dart';
import 'package:demo/services/auth.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:artist/provider/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  final String docid;
  ProfilePage(this.docid);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    // CUser user = Provider.of<CUser>(context);

    return Scaffold(
        backgroundColor: Color(0xffF9F9F9),
        body: SafeArea(
            top: true,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    left: 16.0, right: 16.0, top: kToolbarHeight),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('NormalUser')
                      .doc(widget.docid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return LinearProgressIndicator();
                    }
                    var userDocument = snapshot.data;
                    return Column(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.white,
                          child: ClipOval(
                            child: new SizedBox(
                                width: 180.0,
                                height: 180.0,
                                child: Image.network(
                                  userDocument['img'],
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            userDocument['name'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: FlatButton(
                              child: Text(
                                "Edit",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              color: Colors.greenAccent,
                              textColor: Colors.white,
                              onPressed: () async {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => EditProfilePage()),

                                  // Future.delayed(const Duration(seconds: 1), () {
                                  //   setState(() {
                                  //     Navigator.of(context).pushAndRemoveUntil(
                                  //         MaterialPageRoute(
                                  //             builder: (context) => AdminHome()),
                                  //         (Route<dynamic> route) => false);
                                  //   });
                                  // });
                                );
                              }),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 16.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: transparentYellow,
                                    blurRadius: 4,
                                    spreadRadius: 1,
                                    offset: Offset(0, 1))
                              ]),
                          height: 150,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    IconButton(
                                        icon: Image.asset(
                                            'assets/icons/wallet.png'),
                                        onPressed: () {}
                                        // => Navigator.of(context).push(
                                        //     MaterialPageRoute(
                                        //         builder: (_) => WalletPage())),
                                        ),
                                    Text(
                                      'Wallet',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    IconButton(
                                      icon:
                                          Image.asset('assets/icons/truck.png'),
                                      onPressed: () => {},
                                      // Navigator.of(context)
                                      //     .push(MaterialPageRoute(
                                      //         builder: (_) => TrackingPage())),
                                    ),
                                    Text(
                                      'Shipped',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    IconButton(
                                      icon:
                                          Image.asset('assets/icons/card.png'),
                                      onPressed: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (_) => PaymentPage())),
                                    ),
                                    Text(
                                      'Payment',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    IconButton(
                                      icon: Image.asset(
                                          'assets/icons/contact_us.png'),
                                      onPressed: () {},
                                    ),
                                    Text(
                                      'Support',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text('Settings'),
                          subtitle: Text('Privacy and logout'),
                          leading: Image.asset(
                            'assets/icons/settings_icon.png',
                            fit: BoxFit.scaleDown,
                            width: 30,
                            height: 30,
                          ),
                          trailing: Icon(Icons.chevron_right, color: yellow),
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => SettingsPage())),
                        ),
                        Divider(),
                        ListTile(
                          title: Text('Help & Support'),
                          subtitle: Text('Help center and legal support'),
                          leading: Image.asset('assets/icons/support.png'),
                          trailing: Icon(
                            Icons.chevron_right,
                            color: yellow,
                          ),
                        ),
                        Divider(),
                        ListTile(
                          title: Text('FAQ'),
                          subtitle: Text('Questions and Answer'),
                          leading: Image.asset('assets/icons/faq.png'),
                          trailing: Icon(Icons.chevron_right, color: yellow),
                          onTap: () => {},
                          // Navigator.of(context).push(
                          //     MaterialPageRoute(builder: (_) => FaqPage())),
                        ),
                        Divider(),
                        ListTile(
                          title: Text('Logout'),
                          // subtitle: Text('Questions and Answer'),
                          leading: Image.asset('assets/icons/sign_out.png'),
                          trailing: Icon(Icons.chevron_right, color: yellow),
                          onTap: () async {
                            await _auth.signOut();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                                (Route<dynamic> route) => false);
                          },
                        ),
                        Divider(),
                      ],
                    );
                  },
                ),
              ),
            )));
  }
}
