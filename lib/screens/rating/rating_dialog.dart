import 'package:demo/app_properties.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/screens/shop/check_out_page.dart';
import 'package:flutter/material.dart';
import 'package:demo/provider/user.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingDialog extends StatefulWidget {
  final String productname;
  final String docid;

  const RatingDialog(this.productname, this.docid);
  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  double rating = 1.0;
  String desc = "";
  String name = "";
  @override
  Widget build(BuildContext context) {
    CUser user = Provider.of<CUser>(context);
    double width = MediaQuery.of(context).size.width;

    Widget payNow = InkWell(
      onTap: () async {
        await FirebaseFirestore.instance
            .collection("ArtistUser")
            .doc(user.uid)
            .snapshots()
            .map((e) {
          print(e);
          name = e["name"].toString();
        });
        print(name);
        // Navigator.of(context).pop();
        await FirebaseFirestore.instance
            .collection("Comments")
            .doc(widget.docid)
            .collection("Paintings")
            .doc(user.uid)
            .set({
          'desc': desc,
          'rating': rating,
          'name': name,
        });
        Navigator.pop(context);
        // FirebaseFirestore.instance.collection("Comments").doc("asdfa").set({
        //   'desc':controller,

        // });
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (_) => CheckOutPage()));
      },
      child: Container(
        height: 60,
        width: width / 1.5,
        decoration: BoxDecoration(
            gradient: mainButton,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.16),
                offset: Offset(0, 5),
                blurRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.circular(9.0)),
        child: Center(
          child: Text("Submit",
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0)),
        ),
      ),
    );

    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.grey[50]),
          padding: EdgeInsets.all(24.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            // Container(
            //     height: 100.0,
            //     child: StreamBuilder<DocumentSnapshot>(
            //         // <2> Pass `Future<QuerySnapshot>` to future
            //         stream: FirebaseFirestore.instance
            //             .collection('ArtistUser')
            //             .doc(user.uid)
            //             .snapshots(),
            //         builder: (context, snapshot) {
            //           switch (snapshot.connectionState) {
            //             case ConnectionState.waiting:
            //               return new Center(
            //                   child: new CircularProgressIndicator());
            //             default:
            //               // StreamBuilder(
            //               //     stream: FirebaseFirestore.instance
            //               //         .collection('ArtistUser')
            //               //         .doc(user.uid)
            //               //         .snapshots(),
            //               //     builder: (context, snapshot) {
            //               //       if (!snapshot.hasData) {
            //               //         return new Text("Loading");
            //               //       }
            //               var userDocument = snapshot.data;
            //               print(userDocument["name"]);
            //               // name = userDocumentname;
            //               return Container();
            //           }
            //         })),
            Text(
              'Thank You!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RichText(
                text: TextSpan(
                    style:
                        TextStyle(fontFamily: 'Montserrat', color: Colors.grey),
                    children: [
                      TextSpan(
                        text: 'You rated ',
                      ),
                      TextSpan(
                          text: widget.productname,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600]))
                    ]),
              ),
            ),
            FlutterRatingBar(
//                      borderColor: Color(0xffFF8993),
//                      fillColor: Color(0xffFF8993),

              itemSize: 32,
              allowHalfRating: false,
              initialRating: 1,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              fullRatingWidget:
                  Icon(Icons.favorite, color: Color(0xffFF8993), size: 32),
              noRatingWidget: Icon(Icons.favorite_border,
                  color: Color(0xffFF8993), size: 32),
              onRatingUpdate: (value) {
                setState(() {
                  rating = value;
                });

                // print(value);
              },
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: 16.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextField(
                  onChanged: (val) => setState(() => desc = val),
                  // controller: TextEditingController(),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      hintText: 'Say something about the product.'),
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  maxLength: 200,
                )),
            payNow
          ])),
    );
  }
}
