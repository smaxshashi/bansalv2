import 'dart:convert';

List<LightCategoryModels> lightCategoryModelsFromJson(String str) =>
    List<LightCategoryModels>.from(
        json.decode(str).map((x) => LightCategoryModels.fromJson(x)));

String lightCategoryModelsToJson(List<LightCategoryModels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LightCategoryModels {
  final int categoryId;
  final String categoryName;
  final String? description; // Nullable field
  final int price;
  final String? exfield1; // Nullable field
  final String? exfield2; // Nullable field
  final DateTime createDate;
  final DateTime modiDate;
  final String? imageUrl; // Nullable field
  final int wholesalerId;
  final String categoryType;
  final String? wholeseller; // Nullable field

  LightCategoryModels({
    required this.categoryId,
    required this.categoryName,
    this.description,
    required this.price,
    this.exfield1,
    this.exfield2,
    required this.createDate,
    required this.modiDate,
    this.imageUrl,
    required this.wholesalerId,
    required this.categoryType,
    this.wholeseller,
  });

  factory LightCategoryModels.fromJson(Map<String, dynamic> json) =>
      LightCategoryModels(
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        description: json["description"] as String?, // Nullable
        price: json["price"],
        exfield1: json["exfield1"] as String?, // Nullable
        exfield2: json["exfield2"] as String?, // Nullable
        createDate: DateTime.parse(json["createDate"]),
        modiDate: DateTime.parse(json["modiDate"]),
        imageUrl: json["imageUrl"] as String?, // Nullable
        wholesalerId: json["wholesalerId"],
        categoryType: json["categoryType"],
        wholeseller: json["wholeseller"] as String?, // Nullable
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "categoryName": categoryName,
        "description": description,
        "price": price,
        "exfield1": exfield1,
        "exfield2": exfield2,
        "createDate": createDate.toIso8601String(),
        "modiDate": modiDate.toIso8601String(),
        "imageUrl": imageUrl,
        "wholesalerId": wholesalerId,
        "categoryType": categoryType,
        "wholeseller": wholeseller,
      };
}
