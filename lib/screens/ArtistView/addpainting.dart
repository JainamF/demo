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

class AddPainting extends StatefulWidget {
  final String docid3;
  AddPainting(this.docid3);
  @override
  _AddPaintingState createState() => _AddPaintingState();
}

class _AddPaintingState extends State<AddPainting> {
  // final AuthService _auth = AuthService();
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

  String name;
  String img;
  String price;
  String description;

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    name = "";
    img = "";
    price = "";
    description = "";
  }

  @override
  Widget build(BuildContext context) {
    CUser user = Provider.of<CUser>(context);
    Future retrieveImage(BuildContext context, String image) async {
      img = await FirebaseStorage.instance.ref().child(image).getDownloadURL();
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
        appBar: AppBar(
          title: const Text('Docnew'),
        ),
        body: Stack(children: <Widget>[
          SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Container(
                      child: Column(
                    children: [
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTypQUgssPXZrWN3Rgt4ohOfUq0qgfIR0dLYA&usqp=CAU",
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
                                Text(
                                  'Painting Name',
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
                                          color: Colors.blueAccent,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      hintText: "Name of the Painting",
                                    ),
                                    validator: (val) => val.isEmpty
                                        ? 'Please enter Doctor name'
                                        : null,
                                    onChanged: (val) =>
                                        setState(() => name = val),
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
                                    keyboardType: TextInputType.number,
                                    initialValue: "",
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
                                    validator: (val) =>
                                        val.isEmpty ? 'Price' : null,
                                    onChanged: (val) =>
                                        setState(() => price = val),
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
                                    initialValue: "",
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blueAccent,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      hintText: "Description",
                                    ),
                                    validator: (val) => val.isEmpty
                                        ? 'Please enter Doctor name'
                                        : null,
                                    onChanged: (val) =>
                                        setState(() => description = val),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Container(
                              child: FlatButton(
                                  child: Text(
                                    "ADD",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  color: Colors.greenAccent,
                                  textColor: Colors.white,
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      await uploadPic(context);
                                      // print(widget._curdpractice);
                                      // print(widget._curdocid);
                                      await FirebaseFirestore.instance
                                          .collection("artist")
                                          .doc(widget.docid3)
                                          .collection("paintings")
                                          .add({
                                        'price': int.parse(price),
                                        'description': description,
                                        'name': name,
                                        'img': img,
                                      }).then((value) {
                                        FirebaseFirestore.instance
                                            .collection("Comments")
                                            .doc(value.id)
                                            .set({'Likes': 0});
                                      });

                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UserArtist(widget.docid3)),
                                          (Route<dynamic> route) => false);

                                      // Future.delayed(const Duration(seconds: 1), () {
                                      //   setState(() {
                                      //     Navigator.of(context).pushAndRemoveUntil(
                                      //         MaterialPageRoute(
                                      //             builder: (context) => AdminHome()),
                                      //         (Route<dynamic> route) => false);
                                      //   });
                                      // });
                                    }
                                  }),
                            ),
                          ),
                        ],
                      )
                    ],
                  ))))
        ]));
  }
}
