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

import '../../app_properties.dart';

class EditDelete extends StatefulWidget {
  final String docid;
  final String userid;
  String img;
  String name;
  String description;
  String price;

  EditDelete(
    this.userid,
    this.docid,
    this.img,
    this.name,
    this.description,
    this.price,
  );

  @override
  _EditDeleteState createState() => _EditDeleteState();
}

class _EditDeleteState extends State<EditDelete> {
  String del;
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  String exp;
  String fees;
  String field;

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Future retrieveImage(BuildContext context, String image) async {
      widget.img =
          await FirebaseStorage.instance.ref().child(image).getDownloadURL();
    }

    Future uploadPic(BuildContext context) async {
      String fileName = basename(_image.toString());
      StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      await uploadTask.onComplete;
      await retrieveImage(context, fileName);
    }

    return Scaffold(
        key: _key,
        appBar: AppBar(
          title: Text('Edit/Delete'),
        ),
        body: Stack(children: <Widget>[
          SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Container(
                      child: Column(children: [
                    Container(
                        child: Form(
                            key: _formKey,
                            child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    // mainAxisSize: MainAxisSize.max,
                                    verticalDirection: VerticalDirection.down,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Align(
                                            alignment: Alignment.center,
                                            child: CircleAvatar(
                                              radius: 65,
                                              backgroundColor: Colors.red[200],
                                              child: ClipOval(
                                                child: new SizedBox(
                                                  width: 180.0,
                                                  height: 180.0,
                                                  child: (_image == null)
                                                      ? Image.network(
                                                          "${widget.img}",
                                                        )
                                                      : Image.file(_image),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 60.0),
                                            child: IconButton(
                                              icon: Icon(
                                                FontAwesomeIcons.camera,
                                                size: 30.0,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  getImage();
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      FlatButton(
                                          child: Text(
                                            "Upload",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          color: Colors.blueAccent,
                                          textColor: Colors.white,
                                          onPressed: () async {
                                            await uploadPic(context);
                                          }),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'Name of Painting',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        child: TextFormField(
                                          initialValue: widget.name,
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.blueAccent,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            hintText: "Name",
                                          ),
                                          validator: (val) => val.isEmpty
                                              ? 'Enter Experience'
                                              : null,
                                          onChanged: (val) =>
                                              setState(() => widget.name = val),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'Price',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        child: TextFormField(
                                          initialValue: widget.price,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.blueAccent,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            hintText: "Price",
                                          ),
                                          validator: (val) => val.isEmpty
                                              ? 'Enter Price'
                                              : null,
                                          onChanged: (val) => setState(
                                              () => widget.price = val),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'Description',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        child: TextFormField(
                                          initialValue: widget.description,
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.blueAccent,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            hintText: "decription",
                                          ),
                                          validator: (val) => val.isEmpty
                                              ? 'Enter Price'
                                              : null,
                                          onChanged: (val) => setState(
                                              () => widget.description = val),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                    ])))),
                    Container(
                        child: Form(
                            key: _formKey2,
                            child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    // mainAxisSize: MainAxisSize.max,
                                    verticalDirection: VerticalDirection.down,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "If you want to delete this document type 'delete'",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        child: TextFormField(
                                          initialValue: "",
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.redAccent,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            hintText: "",
                                          ),
                                          validator: (val) => val.isEmpty
                                              ? 'Enter Price'
                                              : null,
                                          onChanged: (val) =>
                                              setState(() => del = val),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    ])))),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                              child: Text(
                                "Delete",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              color: Colors.blueAccent,
                              textColor: Colors.white,
                              onPressed: () async {
                                if (del == "delete") {
                                  if (_formKey2.currentState.validate()) {
                                    _formKey2.currentState.save();
                                    // await uploadPic(context);
                                    _key.currentState.showSnackBar(SnackBar(
                                        content: Text("Deleted successfully")));
                                    await FirebaseFirestore.instance
                                        .collection("artist")
                                        .doc(widget.userid)
                                        .collection("paintings")
                                        .doc(widget.docid)
                                        .delete();
                                    Navigator.pop(context);
                                  }
                                } else {
                                  _key.currentState.showSnackBar(
                                      SnackBar(content: Text("type delete")));
                                }
                              }),
                          SizedBox(
                            width: 15,
                          ),
                          FlatButton(
                              child: Text(
                                "Update",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              color: Colors.blueAccent,
                              textColor: Colors.white,
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  // await uploadPic(context);

                                  await FirebaseFirestore.instance
                                      .collection("artist")
                                      .doc(widget.userid)
                                      .collection("paintings")
                                      .doc(widget.docid)
                                      .set({
                                    'name': widget.name,
                                    'description': widget.description,
                                    'img': widget.img,
                                    'price': widget.price,
                                  });
                                }
                              }),
                        ],
                      ),
                    ),
                  ]))))
        ]));
  }
}
