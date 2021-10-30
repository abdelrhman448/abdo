// To parse this JSON data, do
//
//     final offersModel = offersModelFromMap(jsonString);

import 'dart:convert';

OffersModel offersModelFromMap(String str) =>
    OffersModel.fromMap(json.decode(str));

String offersModelToMap(OffersModel data) => json.encode(data.toMap());

class OffersModel {
  OffersModel({
    this.code,
    this.offers,
  });

  int code;
  List<DatumOffers> offers;

  factory OffersModel.fromMap(Map<String, dynamic> json) => OffersModel(
        code: json["code"] == null ? null : json["code"],
        offers: json["Offers"] == null
            ? null
            : List<DatumOffers>.from(
                json["Offers"].map((x) => DatumOffers.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
        "Offers": offers == null
            ? null
            : List<dynamic>.from(offers.map((x) => x.toMap())),
      };
}

class DatumOffers {
  DatumOffers({
    this.id,
    this.title,
    this.url,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.image,
    this.imageUrl,
    this.media,
  });

  int id;
  String title;
  String url;
  bool active;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  List<Image> image;
  List<String> imageUrl;
  List<Image> media;

  factory DatumOffers.fromMap(Map<String, dynamic> json) => DatumOffers(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        url: json["url"] == null ? null : json["url"],
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
            : List<Image>.from(json["image"].map((x) => Image.fromMap(x))),
        imageUrl: json["imageUrl"] == null
            ? null
            : List<String>.from(json["imageUrl"].map((x) => x)),
        media: json["media"] == null
            ? null
            : List<Image>.from(json["media"].map((x) => Image.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "url": url == null ? null : url,
        "active": active == null ? null : active,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "image": image == null
            ? null
            : List<dynamic>.from(image.map((x) => x.toMap())),
        "imageUrl": imageUrl == null
            ? null
            : List<dynamic>.from(imageUrl.map((x) => x)),
        "media": media == null
            ? null
            : List<dynamic>.from(media.map((x) => x.toMap())),
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

  factory Image.fromMap(Map<String, dynamic> json) => Image(
        id: json["id"] == null ? null : json["id"],
        modelType: json["model_type"] == null ? null : json["model_type"],
        modelId: json["model_id"] == null ? null : json["model_id"],
        uuid: json["uuid"] == null ? null : json["uuid"],
        collectionName:
            json["collection_name"] == null ? null : json["collection_name"],
        generatedConversions: json["generated_conversions"],
        name: json["name"] == null ? null : json["name"],
        fileName: json["file_name"] == null ? null : json["file_name"],
        mimeType: json["mime_type"] == null ? null : json["mime_type"],
        disk: json["disk"] == null ? null : json["disk"],
        conversionsDisk:
            json["conversions_disk"] == null ? null : json["conversions_disk"],
        size: json["size"] == null ? null : json["size"],
        manipulations: json["manipulations"] == null
            ? null
            : List<dynamic>.from(json["manipulations"].map((x) => x)),
        customProperties: json["custom_properties"] == null
            ? null
            : CustomProperties.fromMap(json["custom_properties"]),
        responsiveImages: json["responsive_images"] == null
            ? null
            : List<dynamic>.from(json["responsive_images"].map((x) => x)),
        orderColumn: json["order_column"] == null ? null : json["order_column"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        url: json["url"] == null ? null : json["url"],
        thumbnail: json["thumbnail"] == null ? null : json["thumbnail"],
        previewThumbnail: json["preview_thumbnail"] == null
            ? null
            : json["preview_thumbnail"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "model_type": modelType == null ? null : modelType,
        "model_id": modelId == null ? null : modelId,
        "uuid": uuid == null ? null : uuid,
        "collection_name": collectionName == null ? null : collectionName,
        "generated_conversions": generatedConversions,
        "name": name == null ? null : name,
        "file_name": fileName == null ? null : fileName,
        "mime_type": mimeType == null ? null : mimeType,
        "disk": disk == null ? null : disk,
        "conversions_disk": conversionsDisk == null ? null : conversionsDisk,
        "size": size == null ? null : size,
        "manipulations": manipulations == null
            ? null
            : List<dynamic>.from(manipulations.map((x) => x)),
        "custom_properties":
            customProperties == null ? null : customProperties.toMap(),
        "responsive_images": responsiveImages == null
            ? null
            : List<dynamic>.from(responsiveImages.map((x) => x)),
        "order_column": orderColumn == null ? null : orderColumn,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
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

  factory CustomProperties.fromMap(Map<String, dynamic> json) =>
      CustomProperties(
        generatedConversions: json["generated_conversions"] == null
            ? null
            : GeneratedConversions.fromMap(json["generated_conversions"]),
      );

  Map<String, dynamic> toMap() => {
        "generated_conversions":
            generatedConversions == null ? null : generatedConversions.toMap(),
      };
}

class GeneratedConversions {
  GeneratedConversions({
    this.thumbnail,
    this.previewThumbnail,
  });

  bool thumbnail;
  bool previewThumbnail;

  factory GeneratedConversions.fromMap(Map<String, dynamic> json) =>
      GeneratedConversions(
        thumbnail: json["thumbnail"] == null ? null : json["thumbnail"],
        previewThumbnail: json["preview_thumbnail"] == null
            ? null
            : json["preview_thumbnail"],
      );

  Map<String, dynamic> toMap() => {
        "thumbnail": thumbnail == null ? null : thumbnail,
        "preview_thumbnail": previewThumbnail == null ? null : previewThumbnail,
      };
}
