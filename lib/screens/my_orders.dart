import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nivaldomotos/constants/colors.dart';
import 'package:nivaldomotos/constants/fonts.dart';
import 'package:nivaldomotos/models/user_model.dart';
import 'package:nivaldomotos/widgets/loading.dart';
import 'package:nivaldomotos/widgets/my_orders_items.dart';

class MyOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (UserModel.of(context).isLoggedIn()) {
      String uid = UserModel.of(context).firebaseUser.uid;

      return Scaffold(
        appBar: AppBar(
          title: Text(
            "MEUS PEDIDOS",
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
                .collection("users")
                .document(uid)
                .collection("orders")
                .getDocuments(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: LoadingWidget(),
                );
              } else {
                return ListView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  children: snapshot.data.documents
                      .map((doc) => MyOrdersItems(doc.documentID))
                      .toList()
                      .reversed
                      .toList(),
                );
              }
            },
          ),
        ),
      );
    } else {
      return Scaffold(
          backgroundColor: Color(backgroundColor), body: SizedBox());
    }
  }
}
