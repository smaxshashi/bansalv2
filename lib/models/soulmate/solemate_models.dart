import 'dart:convert';

List<SoulmateModels> soulmateModelsFromJson(String str) =>
    List<SoulmateModels>.from(
        json.decode(str).map((x) => SoulmateModels.fromJson(x)));

String soulmateModelsToJson(List<SoulmateModels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SoulmateModels {
  final int giftingId;
  final String giftingName;
  final String type;
  final String? description;
  final int price;
  final String? exfield1;
  final String? exfield2;
  final int wholesalerId;
  final String wholesaler;
  final DateTime createDate;
  final DateTime modiDate;
  final String imageUrl;

  SoulmateModels({
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

  factory SoulmateModels.fromJson(Map<String, dynamic> json) => SoulmateModels(
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
