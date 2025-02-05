
import 'dart:convert';

List<SubCategoryModels> subCategoryModelsFromJson(String str) =>
    List<SubCategoryModels>.from(
        json.decode(str).map((x) => SubCategoryModels.fromJson(x)));

String subCategoryModelsToJson(List<SubCategoryModels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubCategoryModels {
  final int subcategoryId;
  final String subCategoryName;
  final int categoryId;
  final String categoryName;
  final String description;
  final int price;
  final String? exfield1;
  final String? exfield2;
  final String? gender;
  final String? imageUrl;
  final DateTime createDate;
  final DateTime modiDate;
  final String wholesalerName;
  final int wholesalerId;
  final String? subCategoryType;

  SubCategoryModels({
    required this.subcategoryId,
    required this.subCategoryName,
    required this.categoryId,
    required this.categoryName,
    required this.description,
    required this.price,
    this.exfield1,
    this.exfield2,
    this.gender,
     this.imageUrl,
    required this.createDate,
    required this.modiDate,
    required this.wholesalerName,
    required this.wholesalerId,
    this.subCategoryType,
  });

  factory SubCategoryModels.fromJson(Map<String, dynamic> json) =>
      SubCategoryModels(
        subcategoryId: json["subcategoryId"],
        subCategoryName: json["subCategoryName"],
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        description: json["description"],
        price: json["price"],
        exfield1: json["exfield1"],
        exfield2: json["exfield2"],
        gender: json["gender"],
        imageUrl: json["imageUrl"],
        createDate: DateTime.parse(json["createDate"]),
        modiDate: DateTime.parse(json["modiDate"]),
        wholesalerName: json["wholesalerName"],
        wholesalerId: json["wholesalerId"],
        subCategoryType: json["subCategoryType"],
      );

  Map<String, dynamic> toJson() => {
        "subcategoryId": subcategoryId,
        "subCategoryName": subCategoryName,
        "categoryId": categoryId,
        "categoryName": categoryName,
        "description": description,
        "price": price,
        "exfield1": exfield1,
        "exfield2": exfield2,
        "gender": gender,
        "imageUrl": imageUrl,
        "createDate": createDate.toIso8601String(),
        "modiDate": modiDate.toIso8601String(),
        "wholesalerName": wholesalerName,
        "wholesalerId": wholesalerId,
        "subCategoryType": subCategoryType,
      };
}
