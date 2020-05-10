import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String category;
  String id;
  String title;
  String description;
  String brand;
  double price;
  bool promocao;
  List images;
  List sizes;
  List colors;

  ProductData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    title = snapshot.data['title'];
    description = snapshot.data['description'];
    price = snapshot.data['price'] + 0.0;
    promocao = snapshot.data['promocao'];
    images = snapshot.data['images'];
    sizes = snapshot.data['sizes'];
    colors = snapshot.data['colors'];
    brand = snapshot.data['brand'];
  }

  Map<String, dynamic> toResumeMap() {
    return {
      "title": title,
      "description": description,
      "price": price,
      "brand": brand,
    };
  }
}
