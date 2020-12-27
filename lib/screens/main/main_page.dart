// import 'package:artist/app_properties.dart';
import 'package:demo/custom_background.dart';
// import 'package:artist/helpers/style.dart';
// import 'package:artist/models/product.dart';
// import 'package:artist/screens/category/category_list_page.dart';
// import 'package:artist/screens/main/components/recommended_list.dart';
// import 'package:artist/screens/notifications_page.dart';
import 'package:demo/screens/profile_page.dart';
// import 'package:artist/screens/search_page.dart';
import 'package:demo/screens/shop/check_out_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'components/custom_bottom_bar.dart';
// import 'components/product_list.dart';
import 'components/tab_view.dart';
import 'package:demo/screens/progress.dart';
import 'package:demo/screens/main/artistpainting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainPage extends StatefulWidget {
  final String docid;
  MainPage(this.docid);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with TickerProviderStateMixin<MainPage> {
  SwiperController swiperController;
  TabController tabController;
  TabController tabController2;
  TabController bottomTabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 1, vsync: this);

    bottomTabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Widget appBar = Container(
      height: kToolbarHeight + MediaQuery.of(context).padding.top,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                  onPressed: () => {},
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (_) => NotificationsPage())),
                  icon: Icon(Icons.notifications)),
              IconButton(
                  onPressed: () => {},
                  // Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: (_) => SearchPage())),
                  icon: SvgPicture.asset('assets/icons/search_icon.svg'))
            ],
          ),
          Container(
            child: Text(
              "Artist",
              style: new TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w900,
                  color: Colors.black87),
            ),
          )
        ],
      ),
    );
    Widget artist = Container(
        height: 550,
        child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection("ArtistUser").snapshots(),
            // ignore: missing_return
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var doc = snapshot.data.docs;
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: doc.length,
                    // ignore: missing_return
                    itemBuilder: (context, index) {
                      if (doc[index]['approved'] == true) {
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
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    });
              } else {
                return LinearProgressIndicator();
              }
            }));

    // Widget tabBar = TabBar(
    //   tabs: [
    //     Tab(text: 'Trending'),
    //     // Tab(text: 'Sports'),
    //     // Tab(text: 'Headsets'),
    //     // Tab(text: 'Wireless'),
    //     // Tab(text: 'Bluetooth'),
    //   ],
    //   labelStyle: TextStyle(fontSize: 16.0),
    //   unselectedLabelStyle: TextStyle(
    //     fontSize: 14.0,
    //   ),
    //   labelColor: darkGrey,
    //   unselectedLabelColor: Color.fromRGBO(0, 0, 0, 0.5),
    //   isScrollable: true,
    //   controller: tabController,
    // );

    return Scaffold(
      bottomNavigationBar: CustomBottomBar(controller: bottomTabController),
      body: CustomPaint(
        painter: MainBackground(),
        child: TabBarView(
          controller: bottomTabController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            SafeArea(
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  // These are the slivers that show up in the "outer" scroll view.
                  return <Widget>[
                    SliverToBoxAdapter(
                      child: appBar,
                    ),

                    // SliverToBoxAdapter(
                    //   child: artistname,
                    // ),
                    SliverToBoxAdapter(
                      child: artist,
                    ),
                    // SliverToBoxAdapter(
                    //   child: otherpainting,
                    // )
                  ];
                },
                body: TabView(
                  tabController: tabController,
                ),
              ),
            ),
            // CategoryListPage(),
            InProgress(),
            CheckOutPage(),
            ProfilePage(widget.docid)
          ],
        ),
      ),
    );
  }
}

// SliverToBoxAdapter(
//   child: topHeader,
// ),
// SliverToBoxAdapter(
//   //     child: StreamBuilder<QuerySnapshot>(
//   //   stream: FirebaseFirestore.instance
//   //       .collection("artistinfo")
//   //       // .where("transname", isEqualTo: category)
//   //       .snapshots(),
//   //   builder: (context, snapshot) {
//   //     if (snapshot.hasData) {
//   //       var doc = snapshot.data.docs;
//   //       return ListView.builder(
//   //           itemCount: doc.length,
//   //           itemBuilder: (context, index) {
//   //             return InkWell(
//   //                 onTap: null,
//   //                 child: Container(
//   //                     height: 250,
//   //                     width:
//   //                         MediaQuery.of(context).size.width /
//   //                                 2 -
//   //                             29,
//   //                     decoration: BoxDecoration(
//   //                         borderRadius: BorderRadius.all(
//   //                             Radius.circular(10)),
//   //                         color: Color(0xfffbd085)
//   //                             .withOpacity(0.46)),
//   //                     child: Column(
//   //                       crossAxisAlignment:
//   //                           CrossAxisAlignment.end,
//   //                       children: <Widget>[
//   //                         Align(
//   //                           alignment: Alignment.topCenter,
//   //                           child: Container(
//   //                             padding: EdgeInsets.all(16.0),
//   //                             width: MediaQuery.of(context)
//   //                                         .size
//   //                                         .width /
//   //                                     2 -
//   //                                 64,
//   //                             height: MediaQuery.of(context)
//   //                                         .size
//   //                                         .width /
//   //                                     2 -
//   //                                 64,
//   //                             child: Image.asset(
//   //                               doc[index]['imgurl'],
//   //                             ),
//   //                           ),
//   //                         ),
//   //                         Flexible(
//   //                           child: Align(
//   //                             alignment: Alignment(1, 0.5),
//   //                             child: Container(
//   //                                 margin:
//   //                                     const EdgeInsets.only(
//   //                                         left: 16.0),
//   //                                 padding:
//   //                                     const EdgeInsets.all(
//   //                                         8.0),
//   //                                 decoration: BoxDecoration(
//   //                                     color: Color(0xffe0450a)
//   //                                         .withOpacity(0.51),
//   //                                     borderRadius:
//   //                                         BorderRadius.only(
//   //                                             topLeft: Radius
//   //                                                 .circular(
//   //                                                     10),
//   //                                             bottomLeft: Radius
//   //                                                 .circular(
//   //                                                     10))),
//   //                                 child: Text(
//   //                                   doc[index]['name'],
//   //                                   textAlign:
//   //                                       TextAlign.right,
//   //                                   style: TextStyle(
//   //                                     fontSize: 12.0,
//   //                                     color: Colors.white,
//   //                                   ),
//   //                                 )),
//   //                           ),
//   //                         )
//   //                       ],
//   //                     )));
//   // products.add(
//   //   Product('assets/headphones_2.png', 'Hello',
//   //       'Kem Chho', 102.99),
//   // );
//   //             // print(products);
//   //           });
//   //     } else {
//   //       return LinearProgressIndicator();
//   //     }
//   //   },
//   // )
//   child: ProductList(
//     products: products,
//   ),
// ),
