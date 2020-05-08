import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nivaldomotos/constants/colors.dart';
import 'package:nivaldomotos/constants/contants.dart';
import 'package:nivaldomotos/constants/fonts.dart';
import 'package:nivaldomotos/models/user_model.dart';
import 'package:nivaldomotos/screens/cart_screen.dart';
import 'package:nivaldomotos/screens/categoria_screen.dart';
import 'package:nivaldomotos/screens/products_screen.dart';
import 'package:nivaldomotos/screens/user_screen.dart';
import 'package:nivaldomotos/widgets/cart_icon.dart';
import 'package:nivaldomotos/widgets/loading.dart';
import 'package:nivaldomotos/widgets/user_icon.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:transparent_image/transparent_image.dart';
import 'dart:async';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(backgroundColor),
      body: SafeArea(
        child: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if (model.isLoading)
              return Center(
                child: LoadingWidget(),
              );
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    height: 70,
                    //color: Colors.amber,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset(
                          "assets/images/logo.png",
                          scale: 9,
                        ),
                        Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => UserScreen()));
                              },
                              child: UserIcon(),
                            ),
                            SizedBox(width: 15),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CartScreen()));
                              },
                              child: CartIcon(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 110,
                    child: FutureBuilder<QuerySnapshot>(
                      future: Firestore.instance
                          .collection('products')
                          .orderBy("pos", descending: false)
                          .limit(6)
                          .getDocuments(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: LoadingWidget(),
                          );
                        } else {
                          return ListView(
                            padding: EdgeInsets.only(left: 25),
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            children: snapshot.data.documents.map((doc) {
                              return Padding(
                                padding: EdgeInsets.only(right: 25),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductsScreen(
                                                  snapshot: doc,
                                                  title: doc.data['title'],
                                                )));
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Material(
                                        elevation: 7,
                                        shadowColor: Color(accentColor)
                                            .withOpacity(0.22),
                                        borderRadius: borderAll,
                                        child: Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: borderAll,
                                          ),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: <Widget>[
                                              SizedBox(
                                                  height: 5,
                                                  width: 5,
                                                  child: LoadingWidget()),
                                              FadeInImage.memoryNetwork(
                                                placeholder: kTransparentImage,
                                                image: doc.data['icon'],
                                                imageScale: 12,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 5),
                                        child: Text(
                                          doc.data['title'],
                                          style: categoryStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "",
                          style: titleHomeStyle,
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CategoriaScreen()));
                            },
                            child: Text("ver tudo>", style: categorySubStyle)),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Promoções",
                          style: titleHomeStyle,
                        ),
                        SizedBox(height: 20),
                        FutureBuilder<QuerySnapshot>(
                            future: Firestore.instance
                                .collection('promocoes')
                                .where('active', isEqualTo: true)
                                .getDocuments(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: LoadingWidget(),
                                );
                              } else {
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: SizedBox(
                                      height: 200.0,
                                      width: MediaQuery.of(context).size.width,
                                      child: Carousel(
                                          borderRadius: true,
                                          boxFit: BoxFit.cover,
                                          autoplay: false,
                                          autoplayDuration:
                                              Duration(seconds: 8),
                                          animationCurve:
                                              Curves.fastLinearToSlowEaseIn,
                                          dotSize: 4.0,
                                          dotIncreasedColor:
                                              Color(backgroundColor),
                                          dotBgColor: Color(primaryColor),
                                          dotPosition: DotPosition.topRight,
                                          dotVerticalPadding: 0.0,
                                          showIndicator: true,
                                          indicatorBgPadding: 6.0,
                                          images: snapshot.data.documents
                                              .map((doc) {
                                            return FadeInImage.memoryNetwork(
                                              placeholder: kTransparentImage,
                                              image: doc.data['image'],
                                              fit: BoxFit.cover,
                                            );
                                          }).toList())),
                                );
                              }
                            }),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Encontre nossa loja",
                          style: titleHomeStyle,
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              LoadingWidget(),
                              GoogleMaps(
                                  MediaQuery.of(context).size.width, 300),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class GoogleMaps extends StatefulWidget {
  final double widht;
  final double height;

  GoogleMaps(this.widht, this.height);

  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  Completer<GoogleMapController> _controller = Completer();
  bool isMapCreated = false;

  Timer _timer;
  bool exibir = false;

  _GoogleMapsState() {
    _timer = new Timer(const Duration(milliseconds: 4000), () {
      setState(() {
        exibir = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return exibir == false
        ? SizedBox()
        : Container(
            height: widget.height,
            width: widget.widht,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(-22.2793989, -46.356904),
                zoom: 16.0,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          );
  }
}
