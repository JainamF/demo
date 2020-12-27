import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo/provider/user.dart';
import 'package:demo/models/product.dart';
import 'package:demo/screens/main/components/product_list.dart';
import 'productlistadmin.dart';

class ViewPaintings extends StatefulWidget {
  final String doid;

  ViewPaintings(this.doid);
  @override
  _ViewPaintingsState createState() => _ViewPaintingsState();
}

class _ViewPaintingsState extends State<ViewPaintings> {
  @override
  Widget build(BuildContext context) {
    CUser user = Provider.of<CUser>(context);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Art'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("artist")
              .doc(widget.doid)
              .collection("paintings")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var doc = snapshot.data.docs;
              return ListView.builder(
                  itemCount: doc.length,
                  itemBuilder: (context, index) {
                    List<Product> products = [
                      Product(
                          doc[index]['img'].toString(),
                          doc[index]['name'].toString(),
                          doc[index]['description'].toString(),
                          double.parse(doc[index]['price'].toString())),
                    ];
                    return Container(
                      height: 300,
                      child: Column(
                        children: [
                          ProductListAdmin(
                            products: products,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
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
