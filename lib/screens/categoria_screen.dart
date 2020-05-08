import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nivaldomotos/constants/colors.dart';
import 'package:nivaldomotos/constants/fonts.dart';
import 'package:nivaldomotos/screens/products_screen.dart';
import 'package:nivaldomotos/widgets/loading.dart';
import 'package:transparent_image/transparent_image.dart';

class CategoriaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(backgroundColor),
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "CATEGORIAS",
          style: TextStyle(
              fontFamily: fontExtraBold,
              fontSize: 24,
              color: Color(accentColor)),
        ),
        centerTitle: true,
        backgroundColor: Color(backgroundColorDark),
      ),
      body: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: Firestore.instance.collection('products').getDocuments(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: LoadingWidget(),
              );
            } else {
              return ListView(
                padding: EdgeInsets.only(left: 20, top: 10),
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: snapshot.data.documents.map((doc) {
                  return Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProductsScreen(
                                    snapshot: doc,
                                    title: doc.data['title'],
                                  )));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 60,
                              width: 60,
                              child: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  FadeInImage.memoryNetwork(
                                    placeholder: kTransparentImage,
                                    image: doc.data['icon'],
                                    imageScale: 14,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.79,
                              height: 60,
                              color: Colors.transparent,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      doc.data['title'],
                                      style: categoryTitleStyle,
                                    ),
                                    Icon(CupertinoIcons.right_chevron)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider()
                    ],
                  );
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }
}
