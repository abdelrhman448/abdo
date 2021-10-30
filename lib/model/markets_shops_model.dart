// To parse this JSON data, do
//
//     final marketsShopsModel = marketsShopsModelFromMap(jsonString);

import 'dart:convert';

class MarketsShopsModel {
  MarketsShopsModel({
    this.code,
    this.shops,
  });

  int code;
  List<DatumShops> shops;

  factory MarketsShopsModel.fromJson(String str) =>
      MarketsShopsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MarketsShopsModel.fromMap(Map<String, dynamic> json) =>
      MarketsShopsModel(
        code: json["code"],
        shops: List<DatumShops>.from(
            json["Shops"].map((x) => DatumShops.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "Shops": List<dynamic>.from(shops.map((x) => x.toMap())),
      };
}

class DatumShops {
  DatumShops({
    this.id,
    this.ownerId,
    this.name,
    this.phone,
    this.latitude,
    this.longitude,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.marketId,
    this.image,
    this.imageUrl,
    this.media,
  });

  int id;
  int ownerId;
  String name;
  String phone;
  String latitude;
  String longitude;
  bool active;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  int marketId;
  List<Image> image;
  List<String> imageUrl;
  List<Image> media;

  factory DatumShops.fromJson(String str) =>
      DatumShops.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DatumShops.fromMap(Map<String, dynamic> json) => DatumShops(
        id: json["id"],
        ownerId: json["owner_id"],
        name: json["name"],
        phone: json["phone"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        active: json["active"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        marketId: json["market_id"],
        image: List<Image>.from(json["image"].map((x) => Image.fromMap(x))),
        imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
        media: List<Image>.from(json["media"].map((x) => Image.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "owner_id": ownerId,
        "name": name,
        "phone": phone,
        "latitude": latitude,
        "longitude": longitude,
        "active": active,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "market_id": marketId,
        "image": List<dynamic>.from(image.map((x) => x.toMap())),
        "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
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
  String modelType;
  int modelId;
  String uuid;
  String collectionName;
  dynamic generatedConversions;
  String name;
  String fileName;
  String mimeType;
  String disk;
  String conversionsDisk;
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
        modelType: json["model_type"],
        modelId: json["model_id"],
        uuid: json["uuid"],
        collectionName: json["collection_name"],
        generatedConversions: json["generated_conversions"],
        name: json["name"],
        fileName: json["file_name"],
        mimeType: json["mime_type"],
        disk: json["disk"],
        conversionsDisk: json["conversions_disk"],
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
        "model_type": modelType,
        "model_id": modelId,
        "uuid": uuid,
        "collection_name": collectionName,
        "generated_conversions": generatedConversions,
        "name": name,
        "file_name": fileName,
        "mime_type": mimeType,
        "disk": disk,
        "conversions_disk": conversionsDisk,
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

  String thumbnail;
  String previewThumbnail;

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
