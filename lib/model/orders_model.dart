// To parse this JSON data, do
//
//     final orderModel = orderModelFromMap(jsonString);

import 'dart:convert';

List<OrderModel> orderModelFromMap(String str) =>
    List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromMap(x)));

String orderModelToMap(List<OrderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class OrderModel {
  OrderModel({
    this.total,
    this.deliveryFee,
    this.orderDistance,
    this.fromShop,
    this.toUser,
    this.products,
  });

  double total;
  double deliveryFee;
  double orderDistance;
  FromShop fromShop;
  ToUser toUser;
  List<ProductCartOrder> products;

  factory OrderModel.fromMap(Map<String, dynamic> json) => OrderModel(
        total: json["total"] == null ? null : json["total"].toDouble(),
        deliveryFee:
            json["deliveryFee"] == null ? null : json["deliveryFee"].toDouble(),
        orderDistance: json["orderDistance"] == null
            ? null
            : json["orderDistance"].toDouble(),
        fromShop: json["fromShop"] == null
            ? null
            : FromShop.fromMap(json["fromShop"]),
        toUser: json["toUser"] == null ? null : ToUser.fromMap(json["toUser"]),
        products: json["products"] == null
            ? null
            : List<ProductCartOrder>.from(
                json["products"].map((x) => ProductCartOrder.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "total": total == null ? null : total,
        "deliveryFee": deliveryFee == null ? null : deliveryFee,
        "orderDistance": orderDistance == null ? null : orderDistance,
        "fromShop": fromShop == null ? null : fromShop.toMap(),
        "toUser": toUser == null ? null : toUser.toMap(),
        "products": products == null
            ? null
            : List<dynamic>.from(products.map((x) => x.toMap())),
      };
}

class FromShop {
  FromShop({
    this.id,
    this.name,
    this.shopLatitude,
    this.shopLongitude,
    this.imageUrl,
    this.area,
  });

  int id;
  String name;
  String shopLatitude;
  String shopLongitude;
  String imageUrl;
  String area;

  factory FromShop.fromMap(Map<String, dynamic> json) => FromShop(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        shopLatitude: json["shopLatitude"] == null
            ? null
            : json["shopLatitude"].toDouble(),
        shopLongitude: json["shopLongitude"] == null
            ? null
            : json["shopLongitude"].toDouble(),
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        area: json["area"] == null ? null : json["area"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "shopLatitude": shopLatitude == null ? null : shopLatitude,
        "shopLongitude": shopLongitude == null ? null : shopLongitude,
        "imageUrl": imageUrl == null ? null : imageUrl,
        "area": area == null ? null : area,
      };
}

class ProductCartOrder {
  ProductCartOrder({
    this.id,
    this.name,
    this.price,
    this.quantity,
    this.imageUrl,
  });

  int id;
  String name;
  String price;
  int quantity;
  String imageUrl;

  factory ProductCartOrder.fromMap(Map<String, dynamic> json) =>
      ProductCartOrder(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        price: json["price"] == null ? null : json["price"].toDouble(),
        quantity: json["quantity"] == null ? null : json["quantity"],
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "price": price == null ? null : price,
        "quantity": quantity == null ? null : quantity,
        "imageUrl": imageUrl == null ? null : imageUrl,
      };
}

class ToUser {
  ToUser({
    this.id,
    this.name,
    this.phone,
    this.latitude,
    this.longitude,
  });

  String id;
  String name;
  String phone;
  double latitude;
  double longitude;

  factory ToUser.fromMap(Map<String, dynamic> json) => ToUser(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        phone: json["phone"] == null ? null : json["phone"],
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "phone": phone == null ? null : phone,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
      };
}
