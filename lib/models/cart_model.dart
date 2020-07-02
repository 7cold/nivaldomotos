import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nivaldomotos/datas/cart_product.dart';
import 'package:nivaldomotos/models/user_model.dart';
import 'package:mercadopago_sdk/mercadopago_sdk.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  UserModel user;
  var mp = MP("4618697567453611", "7Vb1745xBCAbFfD6CmMFpDnkkTkZSZqs");
  List<CartProduct> products = [];
  var resultRefIdMP;

  Future<Map<String, dynamic>> preferenceGetMP() async {
    double productsPrice = getProductsPrice();
    double shipPrice = getShipPrice();
    double discount = getDiscount();

    var preference = {
      "items": [
        {
          "title": "Produtos Nivaldo Motos",
          "quantity": 1,
          "currency_id": "BRL",
          "unit_price": productsPrice - discount + shipPrice
        }
      ],
      "payer": {
        "email": user.firebaseUser.email,
        "name": user.firebaseUser.uid
      },
      "payment_methods": {
        "excluded_payment_types": [
          {"id": "atm"},
        ]
      },
    };

    resultRefIdMP = await mp.createPreference(preference);

    print(resultRefIdMP);

    return resultRefIdMP;
  }

  String couponCode;
  String shipping = "retirar_loja";
  double setShipPrice = 0.0;
  int discountPercentage = 0;

  bool isLoading = false;

  CartModel(this.user) {
    if (user.isLoggedIn()) _loadCartItems();
  }

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct cartProduct) {
    products.add(cartProduct);

    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .add(cartProduct.toMap())
        .then((doc) {
      cartProduct.cid = doc.documentID;
    });

    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct) {
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.cid)
        .delete();

    products.remove(cartProduct);

    notifyListeners();
  }

  void decProduct(CartProduct cartProduct) {
    cartProduct.quantity--;

    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.cid)
        .updateData(cartProduct.toMap());

    notifyListeners();
  }

  void pararPedido(String id) {
    Firestore.instance
        .collection("orders")
        .document(id)
        .updateData({"status": 0});

    notifyListeners();
  }

  void incProduct(CartProduct cartProduct) {
    cartProduct.quantity++;

    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.cid)
        .updateData(cartProduct.toMap());

    notifyListeners();
  }

  void setCoupon(String couponCode, int discountPercentage) {
    this.couponCode = couponCode;
    this.discountPercentage = discountPercentage;
  }

  void updatePrices() {
    notifyListeners();
  }

  double getProductsPrice() {
    double price = 0.0;
    for (CartProduct c in products) {
      if (c.productData != null) price += c.quantity * c.productData.price;
    }
    return price;
  }

  double getDiscount() {
    return getProductsPrice() * discountPercentage / 100;
  }

  void setShippingPrice(double setShipPrice) {
    this.setShipPrice = setShipPrice;
  }

  double getShipPrice() {
    return setShipPrice;
  }

  void setShipping(String shipping) {
    this.shipping = shipping;
  }

  String getShipping() {
    return shipping;
  }

  Future<String> finishOrder() async {
    if (products.length == 0) return null;

    isLoading = true;
    notifyListeners();

    double productsPrice = getProductsPrice();
    String shipping = getShipping();
    double shipPrice = getShipPrice();
    double discount = getDiscount();

    DocumentReference refOrder =
        await Firestore.instance.collection("orders").add({
      "clientId": user.firebaseUser.uid,
      "clienteNome": user.userData['nome'] + " " + user.userData['sobrenome'],
      "products": products.map((cartProduct) => cartProduct.toMap()).toList(),
      "shipPrice": shipPrice,
      "date": Timestamp.now(),
      "productsPrice": productsPrice,
      "discount": discount,
      "shipping": shipping,
      "totalPrice": productsPrice - discount + shipPrice,
      "status": 1,
      "refIdMP": resultRefIdMP['response']['id'],
      "payInfo": {
        "status": "",
        "id": "00000",
      }
    });

    await Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("orders")
        .document(refOrder.documentID)
        .setData({
      "orderId": refOrder.documentID,
      "date": Timestamp.now(),
    });

    QuerySnapshot query = await Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .getDocuments();

    for (DocumentSnapshot doc in query.documents) {
      doc.reference.delete();
    }

    products.clear();

    couponCode = null;
    shipping = "";
    discountPercentage = 0;

    isLoading = false;
    notifyListeners();

    return refOrder.documentID;
  }

  void _loadCartItems() async {
    QuerySnapshot query = await Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .getDocuments();

    products =
        query.documents.map((doc) => CartProduct.fromDocument(doc)).toList();

    notifyListeners();
  }

  Future createPayInfo(orderID, dataPayInfo) async {
    isLoading = true;
    notifyListeners();

    await Firestore.instance.collection("orders").document(orderID).updateData({
      "payInfo": dataPayInfo,
    });
  }
}
