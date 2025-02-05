import 'dart:convert';

List<GiftingModels> giftingModelsFromJson(String str) =>
    List<GiftingModels>.from(
        json.decode(str).map((x) => GiftingModels.fromJson(x)));

String giftingModelsToJson(List<GiftingModels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GiftingModels {
  final int giftingId;
  final String giftingName;
  final String type; // Adjusted from giftingCode to type
  final String? description;
  final int price;
  final String? exfield1;
  final String? exfield2;
  final int wholesalerId; // Added field
  final String wholesaler; // Added field
  final DateTime createDate;
  final DateTime modiDate;
  final String imageUrl; // Added field

  GiftingModels({
    required this.giftingId,
    required this.giftingName,
    required this.type,
    this.description,
    required this.price,
    this.exfield1,
    this.exfield2,
    required this.wholesalerId,
    required this.wholesaler,
    required this.createDate,
    required this.modiDate,
    required this.imageUrl,
  });

  factory GiftingModels.fromJson(Map<String, dynamic> json) => GiftingModels(
        giftingId: json["giftingId"],
        giftingName: json["giftingName"],
        type: json["type"],
        description: json["description"],
        price: json["price"],
        exfield1: json["exfield1"],
        exfield2: json["exfield2"],
        wholesalerId: json["wholesalerId"],
        wholesaler: json["wholesaler"],
        createDate: DateTime.parse(json["createDate"]),
        modiDate: DateTime.parse(json["modiDate"]),
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "giftingId": giftingId,
        "giftingName": giftingName,
        "type": type,
        "description": description,
        "price": price,
        "exfield1": exfield1,
        "exfield2": exfield2,
        "wholesalerId": wholesalerId,
        "wholesaler": wholesaler,
        "createDate": createDate.toIso8601String(),
        "modiDate": modiDate.toIso8601String(),
        "imageUrl": imageUrl,
      };
}
