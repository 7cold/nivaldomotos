import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:nivaldomotos/constants/colors.dart';
import 'package:nivaldomotos/constants/fonts.dart';
import 'package:nivaldomotos/datas/product_data.dart';
import 'package:nivaldomotos/screens/products_details_screen.dart';
import 'package:nivaldomotos/widgets/cart_icon.dart';
import 'package:nivaldomotos/widgets/loading.dart';
import 'package:page_transition/page_transition.dart';
import 'package:transparent_image/transparent_image.dart';
import 'cart_screen.dart';

class ProductsScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;
  final String title;

  ProductsScreen({this.snapshot, this.title});

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
          title.toUpperCase(),
          style: TextStyle(
              fontFamily: fontExtraBold,
              fontSize: 24,
              color: Color(accentColor)),
        ),
        centerTitle: true,
        backgroundColor: Color(backgroundColorDark),
        elevation: 0,
      ),
      backgroundColor: Color(backgroundColor),
      body: SafeArea(
        child: FutureBuilder<QuerySnapshot>(
          future: Firestore.instance
              .collection('products')
              .document(snapshot.documentID)
              .collection('items')
              .getDocuments(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: LoadingWidget());
            } else {
              return snapshot.data.documents.length >= 1
                  ? GridView.builder(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.only(left: 25, right: 25, top: 20),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        ProductData data = ProductData.fromDocument(
                            snapshot.data.documents[index]);
                        data.category = this.snapshot.documentID;

                        var priceMask =
                            new MoneyMaskedTextController(leftSymbol: 'R\$ ');
                        priceMask.updateValue(data.price);

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: ProductScreenDetails(data)));
                          },
                          child: Material(
                            elevation: 7,
                            shadowColor: Color(accentColor).withOpacity(0.22),
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Flex(
                                direction: Axis.vertical,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    flex: 1,
                                    child: Center(
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: LoadingWidget()),
                                          Hero(
                                            tag: "${data.id * 3}",
                                            child: Material(
                                              color: Colors.transparent,
                                              child: Container(
                                                child:
                                                    FadeInImage.memoryNetwork(
                                                  placeholder:
                                                      kTransparentImage,
                                                  image: data.images[0],
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      color: Color(backgroundColor)
                                          .withOpacity(0.18),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Hero(
                                            tag: "${data.id}",
                                            child: Material(
                                              color: Colors.transparent,
                                              child: Text(
                                                data.title + " | " + data.brand,
                                                style: cardTextStyle,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Hero(
                                                tag: "${data.id * 2}",
                                                child: Material(
                                                  color: Colors.transparent,
                                                  child: RichText(
                                                    text: TextSpan(
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text:
                                                                priceMask.text,
                                                            style: data.promocao ==
                                                                    true
                                                                ? cardPricePromoStyle
                                                                : cardPriceStyle),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              data.promocao == true
                                                  ? Container(
                                                      height: 50,
                                                      width: 50,
                                                      child: FlareActor(
                                                        "assets/animators/alert_icon.flr",
                                                        animation: "show",
                                                        fit: BoxFit.fill,
                                                      ),
                                                    )
                                                  : SizedBox()
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : Container(
                      color: Color(backgroundColor),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Não há Produtos,\nvolte para continuar!",
                            style: TextStyle(
                                fontFamily: fontBold,
                                color: Color(backgroundColorDark),
                                fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                          Image.asset(
                            "assets/images/no_data.png",
                            scale: 6,
                          ),
                        ],
                      ),
                    );
            }
          },
        ),
      ),
    );
  }
}
