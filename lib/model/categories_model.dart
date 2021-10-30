// To parse this JSON data, do
//
//     final categoriesModel = categoriesModelFromMap(jsonString);

import 'dart:convert';

class CategoriesModel {
  CategoriesModel({
    this.code,
    this.categories,
  });

  int code;
  List<DatumCategory> categories;

  factory CategoriesModel.fromJson(String str) =>
      CategoriesModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoriesModel.fromMap(Map<String, dynamic> json) => CategoriesModel(
        code: json["code"],
        categories: List<DatumCategory>.from(
            json["Categories"].map((x) => DatumCategory.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "Categories": List<dynamic>.from(categories.map((x) => x.toMap())),
      };
}

class DatumCategory {
  DatumCategory({
    this.id,
    this.name,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.image,
    this.imageUrl,
    this.media,
  });

  int id;
  String name;
  bool active;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  List<Image> image;
  List<String> imageUrl;
  List<Image> media;

  factory DatumCategory.fromJson(String str) =>
      DatumCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DatumCategory.fromMap(Map<String, dynamic> json) => DatumCategory(
        id: json["id"],
        name: json["name"],
        active: json["active"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        image: List<Image>.from(json["image"].map((x) => Image.fromMap(x))),
        imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
        media: List<Image>.from(json["media"].map((x) => Image.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "active": active,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
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
    this.responsiveImages,
    this.orderColumn,
    this.createdAt,
    this.updatedAt,
    this.url,
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
  List<dynamic> responsiveImages;
  int orderColumn;
  DateTime createdAt;
  DateTime updatedAt;
  String url;

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
        responsiveImages:
            List<dynamic>.from(json["responsive_images"].map((x) => x)),
        orderColumn: json["order_column"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        url: json["url"] == null ? null : json["url"],
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
        "responsive_images": List<dynamic>.from(responsiveImages.map((x) => x)),
        "order_column": orderColumn,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "url": url == null ? null : url,
      };
}
