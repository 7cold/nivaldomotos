import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nivaldomotos/constants/colors.dart';
import 'package:nivaldomotos/constants/contants.dart';
import 'package:nivaldomotos/constants/fonts.dart';
import 'package:nivaldomotos/models/cart_model.dart';
import 'package:nivaldomotos/widgets/text_form_field.dart';

class DiscountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          child: ExpansionTile(
            title: Text(
              "Cupom de desconto",
              style: cartSubTitleStyle,
            ),
            leading: FaIcon(
              FontAwesomeIcons.gift,
              color: Color(backgroundColorGray),
            ),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                    TextInput(
                      border: true,
                      controller: null,
                      validator: null,
                      textStyle: inputStyle,
                      textCapitalization: TextCapitalization.none,
                      obscure: false,
                      keyboardType: TextInputType.text,
                      hintText: "Cupom",
                      icon: FontAwesomeIcons.gift,
                      onSubmited: (text) {
                        Firestore.instance
                            .collection('coupons')
                            .document(text)
                            .get()
                            .then((docSnap) {
                          if (docSnap.data != null) {
                            CartModel.of(context)
                                .setCoupon(text, docSnap.data['percent']);

                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "desconto de ${docSnap.data['percent']}% aplicado"),
                              ),
                            );
                          } else {
                            CartModel.of(context).setCoupon(null, 0);
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("nao aplicado"),
                            ));
                          }
                        });
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
