import 'package:demo/app_properties.dart';
import 'package:demo/models/product.dart';
import 'package:flutter/material.dart';

class ShopProduct extends StatelessWidget {
  final Product product;
  final Function onRemove;

  const ShopProduct(this.product, {Key key, this.onRemove}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width / 2,
        child: Column(
          children: <Widget>[
            ShopProductDisplay(
              product,
              onPressed: onRemove,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: darkGrey,
                ),
              ),
            ),
            Text(
              '\$${product.price}',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: darkGrey, fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
          ],
        ));
  }
}

class ShopProductDisplay extends StatelessWidget {
  final Product product;
  final Function onPressed;

  const ShopProductDisplay(this.product, {Key key, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(product);
    return SizedBox(
      height: 150,
      width: 200,
      child: Stack(children: <Widget>[
        Positioned(
          left: 25,
          child: SizedBox(
            height: 150,
            width: 150,
            child: Transform.scale(
              scale: 1.2,
              child: Image.asset('assets/bottom_yellow.png'),
            ),
          ),
        ),
        Positioned(
          left: 50,
          top: 5,
          child: SizedBox(
              height: 80,
              width: 80,
              child: Image.network(
                '${product.image}',
                fit: BoxFit.contain,
              )),
        ),
        Positioned(
          right: 30,
          bottom: 25,
          child: Align(
            child: IconButton(
              icon: Image.asset('assets/red_clear.png'),
              onPressed: onPressed,
            ),
          ),
        )
      ]),
    );
  }
}
