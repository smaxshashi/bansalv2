import 'dart:convert';

// Converts JSON string to a list of BannerModel objects
List<BannerModel> bannerModelFromJson(String str) => List<BannerModel>.from(
    json.decode(str).map((x) => BannerModel.fromJson(x)));

// Converts a list of BannerModel objects to a JSON string
String bannerModelToJson(List<BannerModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BannerModel {
  final int bannerId;
  final String bannerName;
  final String? bannerCategory;
  final String? bannerSubcategory;
  final String imageUrl;
  final String? linkUrl;
  final String description;
  final bool isActive;
  final String? exfield1;
  final String? exfield2;
  final int wholesalerId;
  final String? wholesaler;
  final DateTime createDate;
  final DateTime modiDate;

  BannerModel({
    required this.bannerId,
    required this.bannerName,
    this.bannerCategory,
    this.bannerSubcategory,
    required this.imageUrl,
    this.linkUrl,
    required this.description,
    required this.isActive,
    this.exfield1,
    this.exfield2,
    required this.wholesalerId,
    this.wholesaler,
    required this.createDate,
    required this.modiDate,
  });

  // Factory constructor for creating a BannerModel from a JSON map
  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        bannerId: json["bannerId"],
        bannerName: json["bannerName"] ?? '',
        bannerCategory: json["bannerCategory"],
        bannerSubcategory: json["bannerSubcategory"],
        imageUrl: json["imageUrl"] ?? '',
        linkUrl: json["linkUrl"],
        description: json["description"] ?? '',
        isActive: json["isActive"] ?? false,
        exfield1: json["exfield1"],
        exfield2: json["exfield2"],
        wholesalerId: json["wholesalerId"] ?? 0,
        wholesaler: json["wholesaler"],
        createDate: json["createDate"] != null
            ? DateTime.parse(json["createDate"])
            : DateTime.now(),
        modiDate: json["modiDate"] != null
            ? DateTime.parse(json["modiDate"])
            : DateTime.now(),
      );

  // Method to convert a BannerModel to a JSON map
  Map<String, dynamic> toJson() => {
        "bannerId": bannerId,
        "bannerName": bannerName,
        "bannerCategory": bannerCategory,
        "bannerSubcategory": bannerSubcategory,
        "imageUrl": imageUrl,
        "linkUrl": linkUrl,
        "description": description,
        "isActive": isActive,
        "exfield1": exfield1,
        "exfield2": exfield2,
        "wholesalerId": wholesalerId,
        "wholesaler": wholesaler,
        "createDate": createDate.toIso8601String(),
        "modiDate": modiDate.toIso8601String(),
      };
}
