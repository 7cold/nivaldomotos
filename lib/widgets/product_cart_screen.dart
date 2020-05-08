import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nivaldomotos/constants/colors.dart';
import 'package:nivaldomotos/constants/contants.dart';
import 'package:nivaldomotos/constants/fonts.dart';
import 'package:nivaldomotos/datas/cart_product.dart';
import 'package:nivaldomotos/datas/product_data.dart';
import 'package:nivaldomotos/models/cart_model.dart';
import 'package:nivaldomotos/widgets/loading.dart';

class ProductCartScreen extends StatelessWidget {
  final CartProduct cartProduct;

  ProductCartScreen(this.cartProduct);

  Widget build(BuildContext context) {
    Widget _buildProducts() {
      CartModel.of(context).updatePrices();
      return Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            width: 100,
            child: Image.network(
              cartProduct.productData.images[0],
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    cartProduct.productData.title,
                    style: cartTitleStyle,
                  ),
                  Text(
                    cartProduct.color == ""
                        ? cartProduct.size
                        : cartProduct.color + " - " + cartProduct.size,
                    style: cartSubTitleStyle,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'R\$ ',
                      style: cartSubTitleStyle,
                      children: <TextSpan>[
                        TextSpan(
                            text:
                                '${cartProduct.productData.price.toStringAsFixed(2)}',
                            style: cartTitleStyle),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.minusCircle,
                          color: Color(cartProduct.quantity > 1
                              ? primaryColor
                              : backgroundColorGray),
                        ),
                        onPressed: cartProduct.quantity > 1
                            ? () {
                                CartModel.of(context).decProduct(cartProduct);
                              }
                            : null,
                      ),
                      Text(
                        cartProduct.quantity.toString(),
                        style: cartTitleStyle,
                      ),
                      IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.plusCircle,
                          color: Color(primaryColor),
                        ),
                        onPressed: () {
                          CartModel.of(context).incProduct(cartProduct);
                        },
                      ),
                      FlatButton(
                        onPressed: () {
                          CartModel.of(context).removeCartItem(cartProduct);
                        },
                        child: FaIcon(FontAwesomeIcons.trash,
                            color: Color(backgroundColorDark), size: 18),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      child: Material(
        elevation: 3,
        borderRadius: borderAll,
        shadowColor: Colors.white,
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: borderAll,
            ),
            child: cartProduct.productData == null
                ? FutureBuilder<DocumentSnapshot>(
                    future: Firestore.instance
                        .collection('products')
                        .document(cartProduct.category)
                        .collection('items')
                        .document(cartProduct.pid)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        cartProduct.productData =
                            ProductData.fromDocument(snapshot.data);
                        return _buildProducts();
                      } else {
                        return Center(
                          child: LoadingWidget(),
                        );
                      }
                    },
                  )
                : _buildProducts()),
      ),
    );
  }
}
