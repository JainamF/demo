import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/app_properties.dart';
import 'package:flutter/material.dart';
import 'package:demo/screens/rating/rating_dialog.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:demo/models/product.dart';
import 'package:provider/provider.dart';
import 'package:demo/provider/user.dart';

class RatingPage extends StatefulWidget {
  final Product product;
  final String docid;

  const RatingPage({Key key, this.docid, this.product}) : super(key: key);
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  Future postlike(String docId) async {
    try {
      // Get reference to Firestore collection
      var collectionRef = FirebaseFirestore.instance.collection('Comments');

      var doc = await collectionRef.doc(docId).get();
      // print(doc.data());
      // print(doc['name']);
      return doc['Likes'];
    } catch (e) {
      throw e;
    }
  }

  Future retrievelike(String docId) async {
    try {
      // Get reference to Firestore collection
      var collectionRef = FirebaseFirestore.instance.collection('Comments');

      var doc = await collectionRef.doc(docId).get();
      // print(doc.data());
      // print(doc['name']);
      return doc['Likes'].toString();
    } catch (e) {
      throw e;
    }
  }

  Future<bool> yourlike(String docId, String useruid) async {
    try {
      // Get reference to Firestore collection
      var collectionRef = FirebaseFirestore.instance.collection('Comments');

      var doc = await collectionRef
          .doc(docId)
          .collection("Paintings")
          .doc(useruid)
          .get();
      // print(doc.data());
      // print(doc['name']);
      if (doc != null) {
        return doc['isLiked'];
      } else {
        return false;
      }
    } catch (e) {
      throw e;
    }
  }

  double rating = 0.0;
  // bool isLiked = false;
  // List<int> ratings = [2, 1, 5, 2, 4, 3];

  @override
  Widget build(BuildContext context) {
    CUser user = Provider.of<CUser>(context);
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0.0,
          actions: <Widget>[
            // IconButton(
            //   icon: Image.asset('assets/icons/comment.png'),
            //   onPressed: () {
            //     showDialog(
            //         context: context,
            //         child: Dialog(
            //           shape: BeveledRectangleBorder(
            //               borderRadius: BorderRadius.all(Radius.circular(10))),
            //           child: RatingDialog(widget.product.name, widget.docid),
            //         ));
            //   },
            //   color: Colors.black,
            // ),
          ],
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (b, constraints) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            height: 92,
                            width: 92,
                            decoration: BoxDecoration(
                                color: yellow,
                                shape: BoxShape.circle,
                                boxShadow: shadow,
                                border: Border.all(
                                    width: 8.0, color: Colors.white)),
                            child: Image.network(widget.product.image),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 72.0, vertical: 16.0),
                            child: Text(
                              widget.product.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Row(
                                children: [
                                  Container(
                                      child: StreamBuilder<DocumentSnapshot>(
                                          // <2> Pass `Future<QuerySnapshot>` to future
                                          stream: FirebaseFirestore.instance
                                              .collection('Comments')
                                              .doc(widget.docid)
                                              .collection("Liked")
                                              .doc(user.uid)
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            switch (snapshot.connectionState) {
                                              case ConnectionState.waiting:
                                                return new Center(
                                                    child:
                                                        new CircularProgressIndicator());

                                              default:
                                                // var doc = snapshot.data;
                                                // print(doc);
                                                // print(doc.data());
                                                print(snapshot.data.data());
                                                if (snapshot.data.data() ==
                                                    null) {
                                                  return IconButton(
                                                    icon: Icon(Icons
                                                        .favorite_border_outlined),
                                                    onPressed: () async {
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              "Comments")
                                                          .doc(widget.docid)
                                                          .collection("Liked")
                                                          .doc(user.uid)
                                                          .set({
                                                        'isLiked': true,
                                                      });

                                                      String rlike =
                                                          await retrievelike(
                                                              widget.docid);

                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              "Comments")
                                                          .doc(widget.docid)
                                                          .set({
                                                        'Likes':
                                                            (int.parse(rlike) +
                                                                1)
                                                      });
                                                    },
                                                    color: Colors.red,
                                                    iconSize: 50.0,
                                                  );
                                                } else {
                                                  var doc = snapshot.data;
                                                  return doc["isLiked"]
                                                      ? IconButton(
                                                          icon: Icon(
                                                              Icons.favorite),
                                                          onPressed: () async {
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "Comments")
                                                                .doc(widget
                                                                    .docid)
                                                                .collection(
                                                                    "Liked")
                                                                .doc(user.uid)
                                                                .set({
                                                              'isLiked': false
                                                            });

                                                            String rlike =
                                                                await retrievelike(
                                                                    widget
                                                                        .docid);

                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "Comments")
                                                                .doc(widget
                                                                    .docid)
                                                                .set({
                                                              'Likes': (int.parse(
                                                                      rlike) -
                                                                  1)
                                                            });
                                                          },
                                                          color: Colors.red,
                                                          iconSize: 50.0,
                                                        )
                                                      : IconButton(
                                                          icon: Icon(Icons
                                                              .favorite_border_outlined),
                                                          onPressed: () async {
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "Comments")
                                                                .doc(widget
                                                                    .docid)
                                                                .collection(
                                                                    "Liked")
                                                                .doc(user.uid)
                                                                .set({
                                                              'isLiked': true
                                                            });

                                                            String rlike =
                                                                await retrievelike(
                                                                    widget
                                                                        .docid);

                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "Comments")
                                                                .doc(widget
                                                                    .docid)
                                                                .set({
                                                              'Likes': (int.parse(
                                                                      rlike) +
                                                                  1)
                                                            });
                                                          },
                                                          color: Colors.red,
                                                          iconSize: 50.0,
                                                        );
                                                }
                                            }
                                          })),
                                  Container(
                                      child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: StreamBuilder<
                                                  DocumentSnapshot>(
                                              // <2> Pass `Future<QuerySnapshot>` to future
                                              stream: FirebaseFirestore.instance
                                                  .collection('Comments')
                                                  .doc(widget.docid)
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                switch (
                                                    snapshot.connectionState) {
                                                  case ConnectionState.waiting:
                                                    return new Center(
                                                        child:
                                                            new CircularProgressIndicator());
                                                  default:
                                                    var doc = snapshot.data;
                                                    return Text(
                                                        "${doc["Likes"]} Likes");
                                                }
                                              }))),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.rate_review),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          child: Dialog(
                                            shape: BeveledRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: RatingDialog(
                                                widget.product.name,
                                                widget.docid),
                                          ));
                                    },
                                    color: Colors.black,
                                    iconSize: 50.0,
                                  ),
                                  Text("Comment"),
                                ],
                              ),
                            ),
//                             Padding(
//                               padding: const EdgeInsets.only(right: 16.0),
//                               child: Text(
//                                 '4.8',
//                                 style: TextStyle(fontSize: 48),
//                               ),
//                             ),
//                             Column(
//                               children: <Widget>[
//                                 FlutterRatingBar(
// //                      borderColor: Color(0xffFF8993),
// //                      fillColor: Color(0xffFF8993),
//                                   ignoreGestures: true,
//                                   itemSize: 20,
//                                   allowHalfRating: true,
//                                   initialRating: 1,
//                                   itemPadding:
//                                       EdgeInsets.symmetric(horizontal: 4.0),
//                                   fullRatingWidget: Icon(
//                                     Icons.favorite,
//                                     color: Color(0xffFF8993),
//                                     size: 20,
//                                   ),
//                                   noRatingWidget: Icon(Icons.favorite_border,
//                                       color: Color(0xffFF8993), size: 20),
//                                   onRatingUpdate: (value) {
//                                     setState(() {
//                                       rating = value;
//                                     });
//                                   },
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 4.0),
//                                   child: Text('from 25 people'),
//                                 )
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Align(
                            alignment: Alignment(-1, 0),
                            child: Text('All Reviews')),
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            height: 400.0,
                            child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: StreamBuilder<QuerySnapshot>(
                                    // <2> Pass `Future<QuerySnapshot>` to future
                                    stream: FirebaseFirestore.instance
                                        .collection('Comments')
                                        .doc(widget.docid)
                                        .collection('Paintings')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.waiting:
                                          return new Center(
                                              child:
                                                  new CircularProgressIndicator());
                                        default:
                                          final List<DocumentSnapshot> doc =
                                              snapshot.data.docs;

                                          return ListView.builder(
                                              itemCount: doc.length,
                                              itemBuilder: (context, index) {
                                                // FirebaseFirestore.instance
                                                //     .collection("Comments")
                                                //     .get()
                                                //     .map((val)
                                                //  =>
                                                if (doc[index].data().length !=
                                                    1)
                                                  return SingleChildScrollView(
                                                    child: Container(
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            vertical: 4.0),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        5.0))),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          16.0),
                                                              child:
                                                                  CircleAvatar(
                                                                maxRadius: 14,
                                                                backgroundImage:
                                                                    AssetImage(
                                                                        'assets/background.jpg'),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        doc[index]
                                                                            [
                                                                            "name"],
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                      // Text(
                                                                      //   '10 am, Via iOS',
                                                                      //   style: TextStyle(
                                                                      //       color: Colors
                                                                      //           .grey,
                                                                      //       fontSize:
                                                                      //           10.0),
                                                                      // )
                                                                    ],
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            8.0),
                                                                    child:
                                                                        FlutterRatingBar(
//                                borderColor: Color(0xffFF8993),
//                                fillColor: Color(0xffFF8993),
                                                                      ignoreGestures:
                                                                          true,
                                                                      itemSize:
                                                                          20,
                                                                      allowHalfRating:
                                                                          true,
                                                                      initialRating:
                                                                          doc[index]["rating"]
                                                                              .toDouble(),
                                                                      // initialRating: val.toDouble(),
                                                                      itemPadding:
                                                                          EdgeInsets.symmetric(
                                                                              horizontal: 4.0),
                                                                      fullRatingWidget:
                                                                          Icon(
                                                                        Icons
                                                                            .favorite,
                                                                        color: Color(
                                                                            0xffFF8993),
                                                                        size:
                                                                            14,
                                                                      ),
                                                                      noRatingWidget: Icon(
                                                                          Icons
                                                                              .favorite_border,
                                                                          color: Color(
                                                                              0xffFF8993),
                                                                          size:
                                                                              14),
                                                                      onRatingUpdate:
                                                                          (value) {
                                                                        setState(
                                                                            () {
                                                                          rating =
                                                                              value;
                                                                        });
                                                                      },
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    doc[index][
                                                                        "desc"],
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                  ),
                                                                  // Padding(
                                                                  //   padding: const EdgeInsets
                                                                  //           .symmetric(
                                                                  //       vertical:
                                                                  //           16.0),
                                                                  //   child: Row(
                                                                  //     mainAxisAlignment:
                                                                  //         MainAxisAlignment
                                                                  //             .start,
                                                                  //     children: <
                                                                  //         Widget>[
                                                                  //        doc[index]
                                                                  //       ["isLiked"]
                                                                  //           ? IconButton(
                                                                  //               icon: Icon(Icons.favorite),
                                                                  //               onPressed: () async {
                                                                  //                 setState(() {
                                                                  //                   isLiked = !isLiked;
                                                                  //                 });
                                                                  //                 // showDialog(
                                                                  //                 //     context: context,
                                                                  //                 //     child: Dialog(
                                                                  //                 //       shape: BeveledRectangleBorder(
                                                                  //                 //           borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                  //                 //       child: RatingDialog(widget.product.name, widget.docid),
                                                                  //                 //     ));
                                                                  //               },
                                                                  //               color: Colors.red,
                                                                  //             )
                                                                  //           : IconButton(
                                                                  //               icon: Icon(Icons.favorite_border_outlined),
                                                                  //               onPressed: () async {
                                                                  //                 setState(() {
                                                                  //                   isLiked = !isLiked;
                                                                  //                 });

                                                                  //                 // showDialog(
                                                                  //                 //     context: context,
                                                                  //                 //     child: Dialog(
                                                                  //                 //       shape: BeveledRectangleBorder(
                                                                  //                 //           borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                  //                 //       child: RatingDialog(widget.product.name, widget.docid),
                                                                  //                 //     ));
                                                                  //               },
                                                                  //               color: Colors.red,
                                                                  //             ),
                                                                  //       Text(
                                                                  //         '${doc[index]["likes"]} likes',
                                                                  //         style: TextStyle(
                                                                  //             color:
                                                                  //                 Colors.grey[400],
                                                                  //             fontSize: 10.0),
                                                                  //       ),
                                                                  //       // Text(
                                                                  //       //   '1 Comment',
                                                                  //       //   style: TextStyle(
                                                                  //       //       color:
                                                                  //       //           Colors.blue,
                                                                  //       //       fontWeight: FontWeight.bold,
                                                                  //       //       fontSize: 10.0),
                                                                  //       // )
                                                                  //     ],
                                                                  //   ),
                                                                  // )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        )),
                                                  );
                                              });
                                      }
                                    })
                                // .toList()
                                ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
