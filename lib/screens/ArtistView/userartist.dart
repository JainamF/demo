// import 'package:artist/provider/user.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/services/auth.dart';
import 'package:demo/app_properties.dart';
import 'package:demo/screens/ArtistView/addpainting.dart';
import 'package:demo/screens/ArtistView/viewpaintings/viewpainting.dart';
import 'package:demo/screens/ArtistView/artistprofile.dart';
import 'package:demo/screens/ArtistView/editlist.dart';
import 'package:demo/screens/Authenticate/login.dart';

class UserArtist extends StatefulWidget {
  final String docid;

  UserArtist(this.docid);
  @override
  _UserArtistState createState() => _UserArtistState();
}

class _UserArtistState extends State<UserArtist> {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    // CUser user = Provider.of<CUser>(context);
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('ArtistUser')
            .doc(widget.docid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LinearProgressIndicator();
          }
          var userDocument = snapshot.data;
          var appr = userDocument["approved"];
          if (appr == true) {
            return Scaffold(
                body: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          child: Center(
                              child: Text(
                            "Artist View",
                            style: new TextStyle(
                              fontSize: 35.0,
                            ),
                          )),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AddPainting(widget.docid)),
                            );
                          },
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: kBlueColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: ListTile(
                                // leading: CircleAvatar(
                                //   radius: 40,
                                //   backgroundColor: Color(0xff476cfb),
                                //   child: ClipOval(
                                //     child: new SizedBox(
                                //         width: 50.0,
                                //         height: 50.0,
                                //         child: Image.network(
                                //           "${doc[index]['img']}",
                                //         )),
                                //   ),
                                // ),
                                title: Text(
                                  'Add Art',
                                  style: TextStyle(
                                    color: kTitleTextColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // subtitle: Text(
                                //   '${doc[index]['id']}',
                                //   style: TextStyle(
                                //     color: kTitleTextColor.withOpacity(0.7),
                                //   ),
                                // ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ViewPaintings(widget.docid)),
                            );
                          },
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: kBlueColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: ListTile(
                                // leading: CircleAvatar(
                                //   radius: 40,
                                //   backgroundColor: Color(0xff476cfb),
                                //   child: ClipOval(
                                //     child: new SizedBox(
                                //         width: 50.0,
                                //         height: 50.0,
                                //         child: Image.network(
                                //           "${doc[index]['img']}",
                                //         )),
                                //   ),
                                // ),
                                title: Text(
                                  'View Art',
                                  style: TextStyle(
                                    color: kTitleTextColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // subtitle: Text(
                                //   '${doc[index]['id']}',
                                //   style: TextStyle(
                                //     color: kTitleTextColor.withOpacity(0.7),
                                //   ),
                                // ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ArtistProfile(widget.docid)),
                            );
                          },
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: kBlueColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: ListTile(
                                // leading: CircleAvatar(
                                //   radius: 40,
                                //   backgroundColor: Color(0xff476cfb),
                                //   child: ClipOval(
                                //     child: new SizedBox(
                                //         width: 50.0,
                                //         height: 50.0,
                                //         child: Image.network(
                                //           "${doc[index]['img']}",
                                //         )),
                                //   ),
                                // ),
                                title: Text(
                                  'Profile',
                                  style: TextStyle(
                                    color: kTitleTextColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // subtitle: Text(
                                //   '${doc[index]['id']}',
                                //   style: TextStyle(
                                //     color: kTitleTextColor.withOpacity(0.7),
                                //   ),
                                // ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditList(widget.docid)),
                            );
                          },
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: kBlueColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: ListTile(
                                // leading: CircleAvatar(
                                //   radius: 40,
                                //   backgroundColor: Color(0xff476cfb),
                                //   child: ClipOval(
                                //     child: new SizedBox(
                                //         width: 50.0,
                                //         height: 50.0,
                                //         child: Image.network(
                                //           "${doc[index]['img']}",
                                //         )),
                                //   ),
                                // ),
                                title: Text(
                                  'Edit/ Delete Art',
                                  style: TextStyle(
                                    color: kTitleTextColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // subtitle: Text(
                                //   '${doc[index]['id']}',
                                //   style: TextStyle(
                                //     color: kTitleTextColor.withOpacity(0.7),
                                //   ),
                                // ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        InkWell(
                          onTap: () async {
                            await _auth.signOut();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                                (Route<dynamic> route) => false);
                          },
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: kBlueColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: ListTile(
                                // leading: CircleAvatar(
                                //   radius: 40,
                                //   backgroundColor: Color(0xff476cfb),
                                //   child: ClipOval(
                                //     child: new SizedBox(
                                //         width: 50.0,
                                //         height: 50.0,
                                //         child: Image.network(
                                //           "${doc[index]['img']}",
                                //         )),
                                //   ),
                                // ),
                                title: Text(
                                  'Sign Out',
                                  style: TextStyle(
                                    color: kTitleTextColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // subtitle: Text(
                                //   '${doc[index]['id']}',
                                //   style: TextStyle(
                                //     color: kTitleTextColor.withOpacity(0.7),
                                //   ),
                                // ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )));
          } else {
            return Scaffold(
                body: new Container(
              child: Center(
                  child: Text(
                "Please Wait Until You are Approved by the Admin\n Mail Your Art for approval",
              )),
            ));
          }
        });
  }
}
