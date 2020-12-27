import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:demo/provider/user.dart';
// import 'package:artist/services/auth.dart';
import 'package:demo/screens/ArtistView/userartist.dart';
import 'package:demo/screens/ArtistView/editdelete.dart';

import '../../app_properties.dart';

class EditList extends StatefulWidget {
  final String docid4;
  EditList(this.docid4);
  @override
  _EditListState createState() => _EditListState();
}

class _EditListState extends State<EditList> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Art List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("artist")
              .doc(widget.docid4)
              .collection("paintings")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var doc = snapshot.data.docs;
              return ListView.builder(
                  itemCount: doc.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditDelete(
                                        '${widget.docid4}',
                                        '${doc[index].id}',
                                        "${doc[index]['img']}",
                                        '${doc[index]['name']}',
                                        '${doc[index]['description']}',
                                        '${doc[index]['price']}',
                                      )),
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
                                leading: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Color(0xff476cfb),
                                  child: ClipOval(
                                    child: new SizedBox(
                                        width: 50.0,
                                        height: 50.0,
                                        child: Image.network(
                                          "${doc[index]['img']}",
                                        )),
                                  ),
                                ),
                                title: Text(
                                  '${doc[index]['name']}',
                                  style: TextStyle(
                                    color: kTitleTextColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  '${doc[index]['name']}',
                                  style: TextStyle(
                                    color: kTitleTextColor.withOpacity(0.7),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    );
                  });
            } else {
              return LinearProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

// // static void deleteFireBaseStorageItem(String fileUrl){

// // String filePath = fileUrl
// //                   .replaceAll(new
// //                   RegExp(r'https://firebasestorage.googleapis.com/v0/b/dial-in-2345.appspot.com/o/'), '');

// // filePath = filePath.replaceAll(new RegExp(r'%2F'), '/');

// // filePath = filePath.replaceAll(new RegExp(r'(\?alt).*'), '');

// // StorageReference storageReferance = FirebaseStorage.instance.ref();

// // storageReferance.child(filePath).delete().then((_) => print('Successfully deleted $filePath storage item' ));}
