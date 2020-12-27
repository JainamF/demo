import 'package:demo/app_properties.dart';
// import 'package:artist/models/product.dart';
// import 'package:artist/screens/address/add_address_page.dart';
import 'package:demo/screens/payment/unpaid_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'components/credit_card.dart';
// import 'components/shop_item_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/provider/user.dart';
import 'package:provider/provider.dart';

class CheckOutPage extends StatefulWidget {
  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  SwiperController swiperController = SwiperController();
  @override
  Widget build(BuildContext context) {
    Widget checkOutButton = InkWell(
        onTap: () => {},
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (_) => AddAddressPage())),
        child: Container(
          height: 80,
          width: MediaQuery.of(context).size.width / 1.5,
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
            child: Text("Check Out",
                style: const TextStyle(
                    color: const Color(0xfffefefe),
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontSize: 20.0)),
          ),
        ));
    CUser user = Provider.of<CUser>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: darkGrey),
          actions: <Widget>[
            IconButton(
              icon: Image.asset('assets/icons/denied_wallet.png'),
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => UnpaidPage())),
            )
          ],
          title: Text(
            'Checkout',
            style: TextStyle(
                color: darkGrey, fontWeight: FontWeight.w500, fontSize: 18.0),
          ),
        ),
        body: LayoutBuilder(
            builder: (_, constraints) => SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 32.0),
                            height: 48.0,
                            color: yellow,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Subtotal',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  "NA",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  height: 250.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('myorder')
                                          .doc(user.uid)
                                          .collection('items')
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          var doc = snapshot.data.docs;
                                          return ListView.builder(
                                              itemCount: doc.length,
                                              itemBuilder: (context, index) {
                                                return Column(children: [
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          top: 20),
                                                      height: 130,
                                                      child: Stack(
                                                          children: <Widget>[
                                                            Align(
                                                                alignment:
                                                                    Alignment(
                                                                        0, 0.8),
                                                                child:
                                                                    Container(
                                                                        height:
                                                                            180,
                                                                        margin: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                16.0),
                                                                        decoration: BoxDecoration(
                                                                            color: Colors
                                                                                .white,
                                                                            boxShadow:
                                                                                shadow,
                                                                            borderRadius: BorderRadius.only(
                                                                                bottomLeft: Radius.circular(
                                                                                    10),
                                                                                bottomRight: Radius.circular(
                                                                                    10))),
                                                                        child: Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: <Widget>[
                                                                              SizedBox(
                                                                                height: 150,
                                                                                width: 170,
                                                                                child: Stack(children: <Widget>[
                                                                                  // Positioned(
                                                                                  //   left: 25,
                                                                                  //   child: SizedBox(
                                                                                  //     height: 200,
                                                                                  //     width: 200,
                                                                                  //     child: Transform.scale(
                                                                                  //       scale: 1.2,
                                                                                  //       child: Image.asset('assets/bottom_yellow.png'),
                                                                                  //     ),
                                                                                  //   ),
                                                                                  // ),
                                                                                  Positioned(
                                                                                    left: 10,
                                                                                    top: 0,
                                                                                    child: SizedBox(
                                                                                        height: 120,
                                                                                        width: 120,
                                                                                        child: Image.network(
                                                                                          '${doc[index]["img"]}',
                                                                                          fit: BoxFit.contain,
                                                                                        )),
                                                                                  ),
                                                                                  Positioned(
                                                                                    right: 10,
                                                                                    bottom: 10,
                                                                                    child: Align(
                                                                                      child: IconButton(
                                                                                        icon: Image.asset('assets/red_clear.png'),
                                                                                        onPressed: () async {
                                                                                          await FirebaseFirestore.instance.collection("myorder").doc(user.uid).collection("items").doc(doc[index].id).delete();
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                ]),
                                                                              ),
                                                                              Container(
                                                                                padding: EdgeInsets.only(top: 32.0, right: 12.0),
                                                                                width: 150,
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: <Widget>[
                                                                                    Text(
                                                                                      doc[index]["name"],
                                                                                      textAlign: TextAlign.right,
                                                                                      style: TextStyle(
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontSize: 18,
                                                                                        color: darkGrey,
                                                                                      ),
                                                                                    ),
                                                                                    Align(
                                                                                      alignment: Alignment.centerRight,
                                                                                      child: Container(
                                                                                        width: 160,
                                                                                        padding: const EdgeInsets.only(left: 32.0, top: 8.0, bottom: 8.0),
                                                                                        child: Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                          children: <Widget>[
                                                                                            // ColorOption(Colors.red),
                                                                                            Text(
                                                                                              '\ Rs ${doc[index]["price"]}',
                                                                                              textAlign: TextAlign.center,
                                                                                              style: TextStyle(color: darkGrey, fontWeight: FontWeight.bold, fontSize: 18.0),
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ])))
                                                          ]))
                                                ]);
                                                //       SizedBox(
                                                //         height: 10.0,
                                              });
                                        } else {
                                          return LinearProgressIndicator();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'Payment',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: darkGrey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 250,
                                  child: Swiper(
                                    itemCount: 2,
                                    itemBuilder: (_, index) {
                                      return CreditCard();
                                    },
                                    scale: 0.8,
                                    controller: swiperController,
                                    viewportFraction: 0.6,
                                    loop: false,
                                    fade: 0.7,
                                  ),
                                ),
                                SizedBox(height: 24),
                                Center(
                                    child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                                  .padding
                                                  .bottom ==
                                              0
                                          ? 20
                                          : MediaQuery.of(context)
                                              .padding
                                              .bottom),
                                  child: checkOutButton,
                                )),
                              ],
                            ),
                          ),
                        ])))));

//   SwiperController swiperController = SwiperController();
//   List<Product> products = [];

//   // Product('assets/headphones.png',
//   //     'Boat roackerz 400 On-Ear Bluetooth Headphones', 'description', 45.3),
//   // Product('assets/headphones_2.png',
//   //     'Boat roackerz 100 On-Ear Bluetooth Headphones', 'description', 22.3),
//   // Product('assets/headphones_3.png',
//   //     'Boat roackerz 300 On-Ear Bluetooth Headphones', 'description', 58.3)
//   // ];

//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<UserProvider>(context);
//     print(user.user.uid);

//     // FirebaseFirestore.instance
//     //     .collection('myorder')
//     //     .doc(user.user.uid)
//     //     .collection('items')
//     //     .snapshots()
//     //     .map((snapShot) => snapShot.docs.map((document) => products.add(Product(
//     //           '${document['img']}',
//     //           '${document['name']}',
//     //           '${document['intro']}',
//     //           double.parse(document['price'].toString()),
//     //         ))));

    // Widget checkOutButton = InkWell(
    //     onTap: () => Navigator.of(context)
    //         .push(MaterialPageRoute(builder: (_) => AddAddressPage())),
    //     child: Container(
    //       height: 80,
    //       width: MediaQuery.of(context).size.width / 1.5,
    //       decoration: BoxDecoration(
    //           gradient: mainButton,
    //           boxShadow: [
    //             BoxShadow(
    //               color: Color.fromRGBO(0, 0, 0, 0.16),
    //               offset: Offset(0, 5),
    //               blurRadius: 10.0,
    //             )
    //           ],
    //           borderRadius: BorderRadius.circular(9.0)),
    //       child: Center(
    //         child: Text("Check Out",
    //             style: const TextStyle(
    //                 color: const Color(0xfffefefe),
    //                 fontWeight: FontWeight.w600,
    //                 fontStyle: FontStyle.normal,
    //                 fontSize: 20.0)),
    //       ),
    //     ));

//     print(products);
    // return Scaffold(
    //   backgroundColor: Colors.white,
    //   appBar: AppBar(
    //     backgroundColor: Colors.transparent,
    //     elevation: 0.0,
    //     iconTheme: IconThemeData(color: darkGrey),
    //     actions: <Widget>[
    //       IconButton(
    //         icon: Image.asset('assets/icons/denied_wallet.png'),
    //         onPressed: () => Navigator.of(context)
    //             .push(MaterialPageRoute(builder: (_) => UnpaidPage())),
    //       )
    //     ],
    //     title: Text(
    //       'Checkout',
    //       style: TextStyle(
    //           color: darkGrey, fontWeight: FontWeight.w500, fontSize: 18.0),
    //     ),
    //   ),
    //   body: LayoutBuilder(
    //     builder: (_, constraints) => SingleChildScrollView(
    //       physics: ClampingScrollPhysics(),
    //       child: ConstrainedBox(
    //         constraints: BoxConstraints(minHeight: constraints.maxHeight),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: <Widget>[
    //             Container(
    //               padding: EdgeInsets.symmetric(horizontal: 32.0),
    //               height: 48.0,
    //               color: yellow,
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: <Widget>[
    //                   Text(
    //                     'Subtotal',
    //                     style: TextStyle(
    //                         color: Colors.white,
    //                         fontWeight: FontWeight.bold,
    //                         fontSize: 16),
    //                   ),
    //                   Text(
    //                     products.length.toString() + ' items',
    //                     style: TextStyle(
    //                         color: Colors.white,
    //                         fontWeight: FontWeight.bold,
    //                         fontSize: 16),
    //                   )
    //                 ],
    //               ),
    //             ),
    //             // Container(
    //             //     width: 0.0,
    //             //     height: 0.0,
    //             //     child: StreamBuilder<QuerySnapshot>(
    //             //         stream: FirebaseFirestore.instance
    //             //             .collection('myorder')
    //             //             .doc(user.user.uid)
    //             //             .collection('items')
    //             //             .snapshots(),
    //             //         builder: (context, snapshot) {
    //             //           if (snapshot.hasData) {
    //             //             var doc = snapshot.data.docs;
    //             //             return ListView.builder(
    //             //                 itemCount: doc.length,
    //             //                 itemBuilder: (context, index) {
    //             //                   print(products);
    //             //                   print(doc[index]['img']);
    //             //                   products.add(
    //             //                     Product(
    //             //                         doc[index]['img'],
    //             //                         doc[index]['name'],
    //             //                         doc[index]['intro'],
    //             //                         double.parse(
    //             //                             doc[index]['price'].toString())),
    //             //                   );
    //             //                 });
    //             //           }
    //             //         })),
    //             SizedBox(
    //                 height: 300,
    //                 child: Scrollbar(
    //                     child: StreamBuilder<QuerySnapshot>(
    //                         stream: FirebaseFirestore.instance
    //                             .collection('myorder')
    //                             .doc(user.user.uid)
    //                             .collection('items')
    //                             .snapshots(),
    //                         builder: (context, snapshot) {
    //                           if (snapshot.hasData) {
    //                             var doc = snapshot.data.docs;

    //                             return ListView.builder(
    //                                 itemCount: doc.length,
    //                                 itemBuilder: (context, index) {
    //                                   ShopItemList(
    //                                       Product(
    //                                         doc[index]['img'],
    //                                         doc[index]['name'],
    //                                         doc[index]['intro'],
    //                                         double.parse(
    //                                             doc[index]['price'].toString()),
    //                                       ), onRemove: () {
    //                                     setState(() {
    //                                       // products.remove(products[index]);
    //                                     });
    //                                   });
    //                                 });
    //                           }
    //                         }))),

    //             // child: ListView.builder(
    //             //   itemBuilder: (_, index) => ShopItemList(
    //             //     products[index],
    //             //     onRemove: () {
    //             //       setState(() {
    //             //         products.remove(products[index]);
    //             //       });

    //             Padding(
    //               padding: const EdgeInsets.all(16.0),
    //               child: Text(
    //                 'Payment',
    //                 style: TextStyle(
    //                     fontSize: 20,
    //                     color: darkGrey,
    //                     fontWeight: FontWeight.bold),
    //               ),
    //             ),
    //             SizedBox(
    //               height: 250,
    //               child: Swiper(
    //                 itemCount: 2,
    //                 itemBuilder: (_, index) {
    //                   return CreditCard();
    //                 },
    //                 scale: 0.8,
    //                 controller: swiperController,
    //                 viewportFraction: 0.6,
    //                 loop: false,
    //                 fade: 0.7,
    //               ),
    //             ),
    //             SizedBox(height: 24),
    //             Center(
    //                 child: Padding(
    //               padding: EdgeInsets.only(
    //                   bottom: MediaQuery.of(context).padding.bottom == 0
    //                       ? 20
    //                       : MediaQuery.of(context).padding.bottom),
    //               child: checkOutButton,
    //             ))
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
//   }
// }
  }
}

class Scroll extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    LinearGradient grT = LinearGradient(
        colors: [Colors.transparent, Colors.black26],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter);
    LinearGradient grB = LinearGradient(
        colors: [Colors.transparent, Colors.black26],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter);

    canvas.drawRect(
        Rect.fromLTRB(0, 0, size.width, 30),
        Paint()
          ..shader = grT.createShader(Rect.fromLTRB(0, 0, size.width, 30)));

    canvas.drawRect(Rect.fromLTRB(0, 30, size.width, size.height - 40),
        Paint()..color = Color.fromRGBO(50, 50, 50, 0.4));

    canvas.drawRect(
        Rect.fromLTRB(0, size.height - 40, size.width, size.height),
        Paint()
          ..shader = grB.createShader(
              Rect.fromLTRB(0, size.height - 40, size.width, size.height)));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
