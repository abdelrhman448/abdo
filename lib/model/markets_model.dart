// To parse this JSON data, do
//
//     final marketsModel = marketsModelFromMap(jsonString);

import 'dart:convert';

MarketsModel marketsModelFromMap(String str) =>
    MarketsModel.fromMap(json.decode(str));

String marketsModelToMap(MarketsModel data) => json.encode(data.toMap());

class MarketsModel {
  MarketsModel({
    this.code,
    this.markets,
  });

  int code;
  List<DatumMarket> markets;

  factory MarketsModel.fromMap(Map<String, dynamic> json) => MarketsModel(
        code: json["code"] == null ? null : json["code"],
        markets: json["Markets"] == null
            ? null
            : List<DatumMarket>.from(
                json["Markets"].map((x) => DatumMarket.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
        "Markets": markets == null
            ? null
            : List<dynamic>.from(markets.map((x) => x.toMap())),
      };
}

class DatumMarket {
  DatumMarket({
    this.id,
    this.name,
    this.ownerId,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.bgImage,
    this.imageUrl,
    this.categories,
    this.media,
  });

  int id;
  String name;
  int ownerId;
  bool active;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  List<dynamic> bgImage;
  List<dynamic> imageUrl;
  List<Category> categories;
  List<dynamic> media;

  factory DatumMarket.fromMap(Map<String, dynamic> json) => DatumMarket(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        ownerId: json["owner_id"] == null ? null : json["owner_id"],
        active: json["active"] == null ? null : json["active"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        bgImage: json["bg_image"] == null
            ? null
            : List<dynamic>.from(json["bg_image"].map((x) => x)),
        imageUrl: json["imageUrl"] == null
            ? null
            : List<dynamic>.from(json["imageUrl"].map((x) => x)),
        categories: json["categories"] == null
            ? null
            : List<Category>.from(
                json["categories"].map((x) => Category.fromMap(x))),
        media: json["media"] == null
            ? null
            : List<dynamic>.from(json["media"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "owner_id": ownerId == null ? null : ownerId,
        "active": active == null ? null : active,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "bg_image":
            bgImage == null ? null : List<dynamic>.from(bgImage.map((x) => x)),
        "imageUrl": imageUrl == null
            ? null
            : List<dynamic>.from(imageUrl.map((x) => x)),
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories.map((x) => x.toMap())),
        "media": media == null ? null : List<dynamic>.from(media.map((x) => x)),
      };
}

class Category {
  Category({
    this.id,
    this.name,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.image,
    this.imageUrl,
    this.pivot,
    this.media,
  });

  int id;
  String name;
  bool active;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  List<dynamic> image;
  List<dynamic> imageUrl;
  Pivot pivot;
  List<dynamic> media;

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        active: json["active"] == null ? null : json["active"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        image: json["image"] == null
            ? null
            : List<dynamic>.from(json["image"].map((x) => x)),
        imageUrl: json["imageUrl"] == null
            ? null
            : List<dynamic>.from(json["imageUrl"].map((x) => x)),
        pivot: json["pivot"] == null ? null : Pivot.fromMap(json["pivot"]),
        media: json["media"] == null
            ? null
            : List<dynamic>.from(json["media"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "active": active == null ? null : active,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "image": image == null ? null : List<dynamic>.from(image.map((x) => x)),
        "imageUrl": imageUrl == null
            ? null
            : List<dynamic>.from(imageUrl.map((x) => x)),
        "pivot": pivot == null ? null : pivot.toMap(),
        "media": media == null ? null : List<dynamic>.from(media.map((x) => x)),
      };
}

class Pivot {
  Pivot({
    this.marketId,
    this.categoryId,
  });

  int marketId;
  int categoryId;

  factory Pivot.fromMap(Map<String, dynamic> json) => Pivot(
        marketId: json["market_id"] == null ? null : json["market_id"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
      );

  Map<String, dynamic> toMap() => {
        "market_id": marketId == null ? null : marketId,
        "category_id": categoryId == null ? null : categoryId,
      };
}
