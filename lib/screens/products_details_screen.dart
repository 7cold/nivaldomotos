import 'package:carousel_pro/carousel_pro.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:nivaldomotos/constants/colors.dart';
import 'package:nivaldomotos/constants/fonts.dart';
import 'package:nivaldomotos/datas/cart_product.dart';
import 'package:nivaldomotos/datas/product_data.dart';
import 'package:nivaldomotos/models/cart_model.dart';
import 'package:nivaldomotos/screens/cart_screen.dart';
import 'package:nivaldomotos/widgets/button.dart';
import 'package:nivaldomotos/widgets/cart_icon.dart';

class ProductScreenDetails extends StatefulWidget {
  final ProductData product;

  ProductScreenDetails(this.product);

  @override
  _ProductScreenDetailsState createState() =>
      _ProductScreenDetailsState(product);
}

class _ProductScreenDetailsState extends State<ProductScreenDetails> {
  final ProductData product;
  String size;
  String color = "";

  _ProductScreenDetailsState(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CartScreen()));
                },
                child: CartIconWhite(),
              ),
            ),
          )
        ],
        title: Text(
          product.brand.toUpperCase(),
          style: TextStyle(
              fontFamily: fontExtraBold,
              fontSize: 24,
              color: Color(accentColor)),
        ),
        centerTitle: true,
        backgroundColor: Color(backgroundColorDark),
        elevation: 0,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Stack(
            children: <Widget>[
              Hero(
                tag: "${product.id * 3}",
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    height: 350,
                    color: Colors.white,
                    child: Carousel(
                      boxFit: BoxFit.contain,
                      autoplay: false,
                      dotSize: 3.0,
                      dotSpacing: 15,
                      dotBgColor: Colors.transparent,
                      dotColor: Color(secondaryColor),
                      dotIncreasedColor: Color(primaryColor),
                      images: product.images.map((url) {
                        return (NetworkImage(url));
                      }).toList(),
                    ),
                  ),
                ),
              ),
              product.promocao == true
                  ? Container(
                      height: 120,
                      width: 120,
                      child: FlareActor(
                        "assets/animators/alert_icon.flr",
                        animation: "show",
                        fit: BoxFit.fill,
                      ),
                    )
                  : Container(),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag: "${product.id}",
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      product.title.toUpperCase() +
                          " | " +
                          product.brand.toUpperCase(),
                      style: detailTitleStyle,
                    ),
                  ),
                ),
                Hero(
                  tag: "${product.id * 2}",
                  child: Material(
                    color: Colors.transparent,
                    child: RichText(
                      text: TextSpan(
                        text: 'R\$ ',
                        style: TextStyle(
                            color: Color(backgroundColorDark),
                            fontFamily: fontReg,
                            fontSize: 16),
                        children: <TextSpan>[
                          TextSpan(
                              text: '${product.price.toStringAsFixed(2)}',
                              style: detailPriceStyle),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Tamanho",
                  style: detailSubTitleStyle,
                ),
                SizedBox(
                  height: 36,
                  child: GridView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(vertical: 4),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.5,
                    ),
                    children: product.sizes.map((s) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            size = s;
                          });
                        },
                        child: Container(
                          width: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                              width: 2,
                              color: s == size
                                  ? Color(primaryColor)
                                  : Color(backgroundColorGray),
                            ),
                          ),
                          child: Text(
                            s,
                            style: detailTextSubTitleStyle,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 20),
                product.colors.length > 0 && product.colors[0] != ""
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Cores disponíveis",
                            style: detailSubTitleStyle,
                          ),
                          SizedBox(
                            height: 38,
                            child: GridView(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(vertical: 3),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                mainAxisSpacing: 8,
                                childAspectRatio: 0.2,
                              ),
                              children: product.colors.map((c) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      color = c;
                                    });
                                  },
                                  child: Container(
                                    width: 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      border: Border.all(
                                        width: 2,
                                        color: c == color
                                            ? Color(primaryColor)
                                            : Color(backgroundColorGray),
                                      ),
                                    ),
                                    child: Text(
                                      c,
                                      style: detailTextSubTitleStyle,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      )
                    : SizedBox(),
                ButtonFunction(
                  function: size == null ||
                          (product.colors.length != 0 && product.colors[0] != ""
                              ? color == ""
                              : color == null)
                      ? null
                      : () {
                          CartProduct cartProduct = CartProduct();
                          cartProduct.size = size;
                          cartProduct.color = color;
                          cartProduct.quantity = 1;
                          cartProduct.pid = product.id;
                          cartProduct.category = product.category;
                          cartProduct.productData = product;
                          CartModel.of(context).addCartItem(cartProduct);

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CartScreen()));
                        },
                  text: "Adicionar ao Carrinho".toUpperCase(),
                ),
                SizedBox(height: 20),
                Text(
                  "Marca",
                  style: detailSubTitleStyle,
                ),
                Text(
                  product.brand,
                  style: detailTextSubTitleStyle,
                ),
                SizedBox(height: 20),
                Text(
                  "Descrição",
                  style: detailSubTitleStyle,
                ),
                Text(
                  product.description,
                  style: detailTextSubTitleStyle,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
