// To parse this JSON itemCard, do
//
//     final cardRequestItem = cardRequestItemFromJson(jsonString);

import 'dart:convert';

CardRequestItem cardRequestItemFromJson(String str) =>
    CardRequestItem.fromJson(json.decode(str));

String cardRequestItemToJson(CardRequestItem itemCard) =>
    json.encode(itemCard.toJson());

class CardRequestItem {
  CardRequestItem({
    required this.itemCard,
    required this.totalCount,
    required this.isSuccess,
    this.errorMessages,
    this.errorFieldMessages,
  });

  List<InRequestItemCard> itemCard;
  int totalCount;
  bool isSuccess;
  dynamic errorMessages;
  dynamic errorFieldMessages;

  factory CardRequestItem.fromJson(Map<String, dynamic> json) =>
      CardRequestItem(
        itemCard: List<InRequestItemCard>.from(
            json["data"].map((x) => InRequestItemCard.fromJson(x))),
        totalCount: json["totalCount"],
        isSuccess: json["isSuccess"],
        errorMessages: json["errorMessages"],
        errorFieldMessages: json["errorFieldMessages"],
      );

  Map<String, dynamic> toJson() => {
        "itemCard": List<dynamic>.from(itemCard.map((x) => x.toJson())),
        "totalCount": totalCount,
        "isSuccess": isSuccess,
        "errorMessages": errorMessages,
        "errorFieldMessages": errorFieldMessages,
      };
}

class InRequestItemCard {
  InRequestItemCard({
    required this.itemCode,
    required this.companyCode,
    required this.itemStatus,
    this.sellerCode,
    required this.remark,
    required this.brandCode,
    required this.brandNameTha,
    required this.brandNameEng,
    required this.modelCode,
    required this.modelName,
    required this.subModelCode,
    required this.subModelName,
    required this.custSubModelCode,
    required this.licensePlateNo,
    required this.provinceId,
    required this.provinceName,
    required this.districtId,
    required this.districtName,
    required this.colorCode,
    required this.color,
    required this.gearCode,
    required this.gearName,
    required this.gearType,
    required this.manufactureYear,
    required this.receiveMiles,
  });

  String itemCode;
  String companyCode;
  String itemStatus;
  dynamic sellerCode;
  String remark;
  String brandCode;
  String brandNameTha;
  String brandNameEng;
  String modelCode;
  String modelName;
  String subModelCode;
  String subModelName;
  String custSubModelCode;
  String licensePlateNo;
  int provinceId;
  String provinceName;
  int districtId;
  String districtName;
  String colorCode;
  String color;
  String gearCode;
  String gearName;
  String gearType;
  double manufactureYear;
  double receiveMiles;

  factory InRequestItemCard.fromJson(Map<String, dynamic> json) =>
      InRequestItemCard(
        itemCode: json["itemCode"],
        companyCode: json["companyCode"],
        itemStatus: json["itemStatus"],
        sellerCode: json["sellerCode"],
        remark: json["remark"],
        brandCode: json["brandCode"],
        brandNameTha: json["brandNameTha"],
        brandNameEng: json["brandNameEng"],
        modelCode: json["modelCode"],
        modelName: json["modelName"],
        subModelCode: json["subModelCode"],
        subModelName: json["subModelName"],
        custSubModelCode: json["custSubModelCode"],
        licensePlateNo: json["licensePlateNo"],
        provinceId: json["provinceID"],
        provinceName: json["provinceName"],
        districtId: json["districtID"],
        districtName: json["districtName"],
        colorCode: json["colorCode"],
        color: json["color"],
        gearCode: json["gearCode"],
        gearName: json["gearName"],
        gearType: json["gearType"],
        manufactureYear: json["manufactureYear"],
        receiveMiles: json["receiveMiles"],
      );

  Map<String, dynamic> toJson() => {
        "itemCode": itemCode,
        "companyCode": companyCode,
        "itemStatus": itemStatus,
        "sellerCode": sellerCode,
        "remark": remark,
        "brandCode": brandCode,
        "brandNameTha": brandNameTha,
        "brandNameEng": brandNameEng,
        "modelCode": modelCode,
        "modelName": modelName,
        "subModelCode": subModelCode,
        "subModelName": subModelName,
        "custSubModelCode": custSubModelCode,
        "licensePlateNo": licensePlateNo,
        "provinceID": provinceId,
        "provinceName": provinceName,
        "districtID": districtId,
        "districtName": districtName,
        "colorCode": colorCode,
        "color": color,
        "gearCode": gearCode,
        "gearName": gearName,
        "gearType": gearType,
        "manufactureYear": manufactureYear,
        "receiveMiles": receiveMiles,
      };
}
