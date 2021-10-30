// To parse this JSON data, do
//
//     final productOrder = productOrderFromMap(jsonString);

import 'dart:convert';

ProductOrder productOrderFromMap(String str) =>
    ProductOrder.fromMap(json.decode(str));

String productOrderToMap(ProductOrder data) => json.encode(data.toMap());

class ProductOrder {
  ProductOrder({
    this.total,
    this.deliveryFee,
    this.orderDistance,
    this.products,
  });

  int total;
  int deliveryFee;
  double orderDistance;

  List<Product> products;

  factory ProductOrder.fromMap(Map<String, dynamic> json) => ProductOrder(
        total: json["total"] == null ? null : json["total"],
        deliveryFee: json["deliveryFee"] == null ? null : json["deliveryFee"],
        orderDistance: json["orderDistance"] == null
            ? null
            : json["orderDistance"].toDouble(),
        products: json["products"] == null
            ? null
            : List<Product>.from(
                json["products"].map((x) => Product.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "total": total == null ? null : total,
        "deliveryFee": deliveryFee == null ? null : deliveryFee,
        "orderDistance": orderDistance == null ? null : orderDistance,
        "products": products == null
            ? null
            : List<dynamic>.from(products.map((x) => x.toMap())),
      };
}

class Product {
  Product({
    this.id,
    this.quantity,
    this.price,
    this.name,
    this.imageUrl,
  });

  int id;
  int quantity;
  String price;
  String name;
  String imageUrl;

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"] == null ? null : json["id"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        price: json["price"] == null ? null : json["price"],
        name: json["name"] == null ? null : json["name"],
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "quantity": quantity == null ? null : quantity,
        "price": price == null ? null : price,
        "name": name == null ? null : name,
        "imageUrl": imageUrl == null ? null : imageUrl,
      };
}
