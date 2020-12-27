// import 'package:artist/app_properties.dart';
// import 'package:artist/models/product.dart';
import 'package:demo/screens/main/artistpainting.dart';
// import 'package:artist/screens/product/product_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class RecommendedList extends StatefulWidget {
  final String docid;

  RecommendedList(
    this.docid,
  );
  // List<Product> products = [

  //   Product('assets/bag_1.png', 'Bag', 'Beautiful bag', 2.33),
  //   Product('assets/cap_5.png', 'Cap', 'Cap with beautiful design', 10),
  //   Product('assets/jeans_1.png', 'Jeans', 'Jeans for you', 20),
  //   Product('assets/womanshoe_3.png', 'Woman Shoes',
  //       'Shoes with special discount', 30),
  //   Product('assets/bag_10.png', 'Bag Express', 'Bag for your shops', 40),
  //   Product('assets/jeans_3.png', 'Jeans', 'Beautiful Jeans', 102.33),
  //   Product('assets/ring_1.png', 'Silver Ring', 'Description', 52.33),
  //   Product('assets/shoeman_7.png', 'Shoes', 'Description', 62.33),
  //   Product('assets/headphone_9.png', 'Headphones', 'Description', 72.33),
  // ];

  @override
  _RecommendedListState createState() => _RecommendedListState();
}

class _RecommendedListState extends State<RecommendedList> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("artist")
                .doc(widget.docid)
                .collection("paintings")
                .snapshots(),
            // ignore: missing_return
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var doc = snapshot.data.docs;

                // return ListView.builder(
                //     scrollDirection: Axis.vertical,
                //     itemCount: doc.length,
                //     itemBuilder: (context, index) {
                //       return StreamBuilder<QuerySnapshot>(
                //           stream: FirebaseFirestore.instance
                //               .collection("artist")
                //               .doc(doc[index].id)
                //               .collection("paintings")
                //               .snapshots(),
                //           builder: (context, snapshot2) {
                //             if (snapshot.hasData) {
                //               var doc2 = snapshot2.data.docs;

                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: doc.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.grey[300],
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ArtistPainting(
                                        '${doc[index].id}',
                                      )),
                            );
                          },
                          child: Container(
                            height: 240,
                            width: 250,
                            child: Column(
                              children: <Widget>[
                                new SizedBox(
                                  height: 184.0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 25.0, right: 8.0),
                                    // child: new Positioned.fill(
                                    child: new Image.network(
                                      '${doc[index]['img']}',
                                      //package: destination.assetPackage,
                                      fit: BoxFit.contain,
                                    ),
                                    // ),
                                  ),
                                ),
                                new Padding(
                                  padding: new EdgeInsets.all(
                                    7.0,
                                  ),
                                  child: new Text(
                                    '${doc[index]['name']}',
                                    style: new TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.black87),
                                  ),
                                ),
                                // new Padding(
                                //   padding: new EdgeInsets.all(
                                //     0.0,
                                //   ),
                                //   child: new Text(
                                //     "cardTag",
                                //     style: new TextStyle(
                                //         fontSize: 12.0,
                                //         fontWeight: FontWeight.w400,
                                //         color: Colors.black54),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                return LinearProgressIndicator();
              }
            }));
  }
}
