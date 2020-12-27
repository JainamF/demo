import 'package:demo/models/product.dart';
import 'package:demo/screens/product/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'productpageadmin.dart';

// ignore: must_be_immutable
class ProductListAdmin extends StatelessWidget {
  List<Product> products;

  final SwiperController swiperController = SwiperController();

  ProductListAdmin({Key key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double cardHeight = MediaQuery.of(context).size.height / 3.2;
    double cardWidth = MediaQuery.of(context).size.width / 1.8;
    if (products == null) products = [];

    return SizedBox(
        height: cardHeight,
        child: Swiper(
          itemCount: products.length,
          itemBuilder: (_, index) {
            return ProductCardAdmin(
                height: cardHeight, width: cardWidth, product: products[index]);
          },
          scale: 0.8,
          controller: swiperController,
          viewportFraction: 0.6,
          loop: false,
          fade: 0.5,
        ));
  }
}

class ProductCardAdmin extends StatelessWidget {
  final Product product;
  final double height;
  final double width;

  const ProductCardAdmin({Key key, this.product, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ProductPageAdmin(product: product))),
      child: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 30),
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(24)),
              color: Colors.grey[300],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {},
                  color: Colors.red,
                ),
                Column(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            product.name ?? '',
                            style:
                                TextStyle(color: Colors.black, fontSize: 18.0),
                          ),
                        )),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12.0),
                        padding: const EdgeInsets.fromLTRB(8.0, 4.0, 12.0, 4.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          color: Color.fromRGBO(224, 69, 10, 1),
                        ),
                        child: Text(
                          '\ Rs${product.price ?? 0.0}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            // child: Hero(
            //   tag: product.image,
            child: Padding(
              padding: const EdgeInsets.only(left: 40.0, top: 20.0),
              child: Image.network(
                product.image ?? '',
                height: height / 1.7,
                width: width / 1.4,
                fit: BoxFit.contain,
              ),
            ),
          ),
          // ),
        ],
      ),
    );
  }
}
