import 'package:demo/models/product.dart';
import 'package:flutter/material.dart';
import 'components/product_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ArtistPainting extends StatefulWidget {
  final String docid;

  ArtistPainting(
    this.docid,
  );
  @override
  _ArtistPaintingState createState() => _ArtistPaintingState();
}

class _ArtistPaintingState extends State<ArtistPainting> {
  // List<Product> products = [
  //   Product(
  //       'assets/headphones_2.png',
  //       'Hello',
  //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ut labore et dolore magna aliqua. Nec nam aliquam sem et tortor consequat id porta nibh. Orci porta non pulvinar neque laoreet suspendisse. Id nibh tortor id aliquet. Dui sapien eget mi proin. Viverra vitae congue eu consequat ac felis donec. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Vulputate mi sit amet mauris commodo quis imperdiet. Vel fringilla est ullamcorper eget nulla facilisi etiam dignissim. Sit amet cursus sit amet dictum sit amet justo. Mattis pellentesque id nibh tortor. Sed blandit libero volutpat sed cras ornare arcu dui. Fermentum et sollicitudin ac orci phasellus. Ipsum nunc aliquet bibendum enim facilisis gravida. Viverra suspendisse potenti nullam ac tortor. Dapibus ultrices in iaculis nunc sed. Nisi porta lorem mollis aliquam ut porttitor leo a. Phasellus egestas tellus rutrum tellus pellentesque. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Commodo ullamcorper a lacus vestibulum sed arcu non odio. Urna id volutpat lacus laoreet non curabitur gravida arcu ac. Eros in cursus turpis massa. Eget mauris pharetra et ultrices neque.',
  //       102.99),
  //   Product(
  //       'assets/headphones_3.png',
  //       'Skullcandy headset X25',
  //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ut labore et dolore magna aliqua. Nec nam aliquam sem et tortor consequat id porta nibh. Orci porta non pulvinar neque laoreet suspendisse. Id nibh tortor id aliquet. Dui sapien eget mi proin. Viverra vitae congue eu consequat ac felis donec. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Vulputate mi sit amet mauris commodo quis imperdiet. Vel fringilla est ullamcorper eget nulla facilisi etiam dignissim. Sit amet cursus sit amet dictum sit amet justo. Mattis pellentesque id nibh tortor. Sed blandit libero volutpat sed cras ornare arcu dui. Fermentum et sollicitudin ac orci phasellus. Ipsum nunc aliquet bibendum enim facilisis gravida. Viverra suspendisse potenti nullam ac tortor. Dapibus ultrices in iaculis nunc sed. Nisi porta lorem mollis aliquam ut porttitor leo a. Phasellus egestas tellus rutrum tellus pellentesque. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Commodo ullamcorper a lacus vestibulum sed arcu non odio. Urna id volutpat lacus laoreet non curabitur gravida arcu ac. Eros in cursus turpis massa. Eget mauris pharetra et ultrices neque.',
  //       55.99),
  //   Product(
  //       'assets/headphones.png',
  //       'Blackzy PRO hedphones M003',
  //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ut labore et dolore magna aliqua. Nec nam aliquam sem et tortor consequat id porta nibh. Orci porta non pulvinar neque laoreet suspendisse. Id nibh tortor id aliquet. Dui sapien eget mi proin. Viverra vitae congue eu consequat ac felis donec. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Vulputate mi sit amet mauris commodo quis imperdiet. Vel fringilla est ullamcorper eget nulla facilisi etiam dignissim. Sit amet cursus sit amet dictum sit amet justo. Mattis pellentesque id nibh tortor. Sed blandit libero volutpat sed cras ornare arcu dui. Fermentum et sollicitudin ac orci phasellus. Ipsum nunc aliquet bibendum enim facilisis gravida. Viverra suspendisse potenti nullam ac tortor. Dapibus ultrices in iaculis nunc sed. Nisi porta lorem mollis aliquam ut porttitor leo a. Phasellus egestas tellus rutrum tellus pellentesque. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Commodo ullamcorper a lacus vestibulum sed arcu non odio. Urna id volutpat lacus laoreet non curabitur gravida arcu ac. Eros in cursus turpis massa. Eget mauris pharetra et ultrices neque.',
  //       152.99),
  // ];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Paintings Collection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("artist")
              .doc(widget.docid)
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
                          ProductList(
                            docid: doc[index].id,
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

// InkWell(
//   onTap: () {
//     // Navigator.push(
//     //   context,
//     //   MaterialPageRoute(
//     //       builder: (context) => ArtistPainting(
//     //             '${doc[index].id}',
//     //           )),
//     // );
//   },
//   child: DecoratedBox(
//     decoration: BoxDecoration(
//       color: kBlueColor.withOpacity(0.1),
//       borderRadius: BorderRadius.circular(10),
//     ),
//     child: Padding(
//       padding: EdgeInsets.all(10),
//       child: ListTile(
//         leading: CircleAvatar(
//           radius: 40,
//           backgroundColor: Color(0xff476cfb),
//           child: ClipOval(
//             child: new SizedBox(
//                 width: 50.0,
//                 height: 50.0,
//                 child: Image.network(
//                   "${doc[index]['img']}",
//                 )),
//           ),
//         ),
//         title: Text(
//           '${doc[index]['name']}',
//           style: TextStyle(
//             color: kTitleTextColor,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         // subtitle: Text(
//         //   '${doc[index]['id']}',
//         //   style: TextStyle(
//         //     color: kTitleTextColor.withOpacity(0.7),
//         //   ),
//         // ),
//       ),
//     ),
//   ),
// ),
