import 'dart:convert';

OccasionCardModels occasionCardModelsFromJson(String str) =>
    OccasionCardModels.fromJson(json.decode(str));

String occasionCardModelsToJson(OccasionCardModels data) =>
    json.encode(data.toJson());

class OccasionCardModels {
  final int status;
  final String message;
  final int totalProducts;
  final List<OccasionCard> products;

  OccasionCardModels({
    required this.status,
    required this.message,
    required this.totalProducts,
    required this.products,
  });

  factory OccasionCardModels.fromJson(Map<String, dynamic> json) =>
      OccasionCardModels(
        status: json["status"],
        message: json["message"],
        totalProducts: json["totalProducts"],
        products: List<OccasionCard>.from(
            json["products"].map((x) => OccasionCard.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "totalProducts": totalProducts,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class OccasionCard {
  final int productId;
  final String productName;
  final String description;
  final String categoryName;
  final int categoryId;
  final int subCategoryId;
  final String subCategoryName;
  final String weight;
  final String karat;
  final String wastage;
  final String occasion;
  final String soulmate;
  final String gifting;
  final String gender;
  final String wholesaler;
  final String tagNumber;
  final String size;
  final String length;
  final String productType;
  final int wholesalerId;
  final List<dynamic> imageUrls;
  final List<dynamic> compressedImageUrls;
  final List<dynamic> compressedUrls;
  final bool checked;

  OccasionCard({
    required this.productId,
    required this.productName,
    required this.description,
    required this.categoryName,
    required this.categoryId,
    required this.subCategoryId,
    required this.subCategoryName,
    required this.weight,
    required this.karat,
    required this.wastage,
    required this.occasion,
    required this.soulmate,
    required this.gifting,
    required this.gender,
    this.wholesaler = "",
    this.tagNumber = "",
    this.size = "",
    this.length = "",
    this.productType = "",
    required this.wholesalerId,
    this.imageUrls = const [],
    this.compressedImageUrls = const [],
    this.compressedUrls = const [],
    required this.checked,
  });

  factory OccasionCard.fromJson(Map<String, dynamic> json) => OccasionCard(
        productId: json["productId"] ?? 0,
        productName: json["productName"] ?? "",
        description: json["description"] ?? "",
        categoryName: json["categoryName"] ?? "",
        categoryId: json["categoryId"] ?? 0,
        subCategoryId: json["subCategoryId"] ?? 0,
        subCategoryName: json["subCategoryName"] ?? "",
        weight: json["weight"] ?? "",
        karat: json["karat"] ?? "",
        wastage: json["wastage"] ?? "",
        occasion: json["occasion"] ?? "",
        soulmate: json["soulmate"] ?? "",
        gifting: json["gifting"] ?? "",
        gender: json["gender"] ?? "",
        wholesaler: json["wholesaler"] ?? "",
        tagNumber: json["tagNumber"] ?? "",
        size: json["size"] ?? "",
        length: json["length"] ?? "",
        productType: json["productType"] ?? "",
        wholesalerId: json["wholesalerId"] ?? 0,
        imageUrls: List<dynamic>.from(json["imageUrls"] ?? []),
        compressedImageUrls:
            List<dynamic>.from(json["compressedImageUrls"] ?? []),
        compressedUrls: List<dynamic>.from(json["compressedUrls"] ?? []),
        checked: json["checked"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "productName": productName,
        "description": description,
        "categoryName": categoryName,
        "categoryId": categoryId,
        "subCategoryId": subCategoryId,
        "subCategoryName": subCategoryName,
        "weight": weight,
        "karat": karat,
        "wastage": wastage,
        "occasion": occasion,
        "soulmate": soulmate,
        "gifting": gifting,
        "gender": gender,
        "wholesaler": wholesaler,
        "tagNumber": tagNumber,
        "size": size,
        "length": length,
        "productType": productType,
        "wholesalerId": wholesalerId,
        "imageUrls": imageUrls,
        "compressedImageUrls": compressedImageUrls,
        "compressedUrls": compressedUrls,
        "checked": checked,
      };
}
