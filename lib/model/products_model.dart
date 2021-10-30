// To parse this JSON data, do
//
//     final productsModel = productsModelFromMap(jsonString);

import 'dart:convert';

class ProductsModel {
  ProductsModel({
    this.code,
    this.products,
  });

  int code;
  List<DatumProduct> products;

  factory ProductsModel.fromJson(String str) =>
      ProductsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductsModel.fromMap(Map<String, dynamic> json) => ProductsModel(
        code: json["code"],
        products: List<DatumProduct>.from(
            json["Products"].map((x) => DatumProduct.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "Products": List<dynamic>.from(products.map((x) => x.toMap())),
      };
}

class DatumProduct {
  DatumProduct({
    this.id,
    this.shopId,
    this.name,
    this.unit,
    this.price,
    this.discountPrice,
    this.deliverable,
    this.active,
    this.ownerId,
    this.quantity = 1,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.image,
    this.imageUrl,
    this.pivot,
    this.media,
  });

  int id;
  int shopId;
  String name;
  String unit;
  String price;
  String discountPrice;
  bool deliverable;
  bool active;
  int ownerId;
  int quantity;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  List<Image> image;
  List<String> imageUrl;
  Pivot pivot;
  List<Image> media;

  factory DatumProduct.fromJson(String str) =>
      DatumProduct.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DatumProduct.fromMap(Map<String, dynamic> json) => DatumProduct(
        id: json["id"],
        shopId: json["shop_id"],
        name: json["name"],
        unit: json["unit"],
        price: json["price"],
        discountPrice: json["discount_price"],
        deliverable: json["deliverable"],
        active: json["active"],
        ownerId: json["owner_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        image: List<Image>.from(json["image"].map((x) => Image.fromMap(x))),
        imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
        pivot: Pivot.fromMap(json["pivot"]),
        media: List<Image>.from(json["media"].map((x) => Image.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "shop_id": shopId,
        "name": name,
        "unit": unit,
        "price": price,
        "discount_price": discountPrice,
        "deliverable": deliverable,
        "active": active,
        "owner_id": ownerId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "image": List<dynamic>.from(image.map((x) => x.toMap())),
        "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
        "pivot": pivot.toMap(),
        "media": List<dynamic>.from(media.map((x) => x.toMap())),
      };
}

class Image {
  Image({
    this.id,
    this.modelType,
    this.modelId,
    this.uuid,
    this.collectionName,
    this.generatedConversions,
    this.name,
    this.fileName,
    this.mimeType,
    this.disk,
    this.conversionsDisk,
    this.size,
    this.manipulations,
    this.customProperties,
    this.responsiveImages,
    this.orderColumn,
    this.createdAt,
    this.updatedAt,
    this.url,
    this.thumbnail,
    this.previewThumbnail,
  });

  int id;
  ModelType modelType;
  int modelId;
  String uuid;
  CollectionName collectionName;
  dynamic generatedConversions;
  String name;
  String fileName;
  MimeType mimeType;
  Disk disk;
  Disk conversionsDisk;
  int size;
  List<dynamic> manipulations;
  CustomProperties customProperties;
  List<dynamic> responsiveImages;
  int orderColumn;
  DateTime createdAt;
  DateTime updatedAt;
  String url;
  String thumbnail;
  String previewThumbnail;

  factory Image.fromJson(String str) => Image.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Image.fromMap(Map<String, dynamic> json) => Image(
        id: json["id"],
        modelType: modelTypeValues.map[json["model_type"]],
        modelId: json["model_id"],
        uuid: json["uuid"],
        collectionName: collectionNameValues.map[json["collection_name"]],
        generatedConversions: json["generated_conversions"],
        name: json["name"],
        fileName: json["file_name"],
        mimeType: mimeTypeValues.map[json["mime_type"]],
        disk: diskValues.map[json["disk"]],
        conversionsDisk: diskValues.map[json["conversions_disk"]],
        size: json["size"],
        manipulations: List<dynamic>.from(json["manipulations"].map((x) => x)),
        customProperties: CustomProperties.fromMap(json["custom_properties"]),
        responsiveImages:
            List<dynamic>.from(json["responsive_images"].map((x) => x)),
        orderColumn: json["order_column"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        url: json["url"] == null ? null : json["url"],
        thumbnail: json["thumbnail"] == null ? null : json["thumbnail"],
        previewThumbnail: json["preview_thumbnail"] == null
            ? null
            : json["preview_thumbnail"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "model_type": modelTypeValues.reverse[modelType],
        "model_id": modelId,
        "uuid": uuid,
        "collection_name": collectionNameValues.reverse[collectionName],
        "generated_conversions": generatedConversions,
        "name": name,
        "file_name": fileName,
        "mime_type": mimeTypeValues.reverse[mimeType],
        "disk": diskValues.reverse[disk],
        "conversions_disk": diskValues.reverse[conversionsDisk],
        "size": size,
        "manipulations": List<dynamic>.from(manipulations.map((x) => x)),
        "custom_properties": customProperties.toMap(),
        "responsive_images": List<dynamic>.from(responsiveImages.map((x) => x)),
        "order_column": orderColumn,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "url": url == null ? null : url,
        "thumbnail": thumbnail == null ? null : thumbnail,
        "preview_thumbnail": previewThumbnail == null ? null : previewThumbnail,
      };
}

enum CollectionName { PRODUCT_IMAGE }

final collectionNameValues =
    EnumValues({"product_image": CollectionName.PRODUCT_IMAGE});

enum Disk { PUBLIC }

final diskValues = EnumValues({"public": Disk.PUBLIC});

class CustomProperties {
  CustomProperties({
    this.generatedConversions,
  });

  GeneratedConversions generatedConversions;

  factory CustomProperties.fromJson(String str) =>
      CustomProperties.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CustomProperties.fromMap(Map<String, dynamic> json) =>
      CustomProperties(
        generatedConversions:
            GeneratedConversions.fromMap(json["generated_conversions"]),
      );

  Map<String, dynamic> toMap() => {
        "generated_conversions": generatedConversions.toMap(),
      };
}

class GeneratedConversions {
  GeneratedConversions({
    this.thumbnail,
    this.previewThumbnail,
  });

  dynamic thumbnail;
  dynamic previewThumbnail;

  factory GeneratedConversions.fromJson(String str) =>
      GeneratedConversions.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GeneratedConversions.fromMap(Map<String, dynamic> json) =>
      GeneratedConversions(
        thumbnail: json["thumbnail"],
        previewThumbnail: json["preview_thumbnail"],
      );

  Map<String, dynamic> toMap() => {
        "thumbnail": thumbnail,
        "preview_thumbnail": previewThumbnail,
      };
}

enum MimeType { IMAGE_JPEG }

final mimeTypeValues = EnumValues({"image/jpeg": MimeType.IMAGE_JPEG});

enum ModelType { APP_MODELS_PRODUCT }

final modelTypeValues =
    EnumValues({"App\\Models\\DatumProduct": ModelType.APP_MODELS_PRODUCT});

class Pivot {
  Pivot({
    this.categoryId,
    this.productId,
  });

  int categoryId;
  int productId;

  factory Pivot.fromJson(String str) => Pivot.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pivot.fromMap(Map<String, dynamic> json) => Pivot(
        categoryId: json["category_id"],
        productId: json["product_id"],
      );

  Map<String, dynamic> toMap() => {
        "category_id": categoryId,
        "product_id": productId,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
