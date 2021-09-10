// To parse this JSON homeCard, do
//
//     final cardModel = cardModelFromJson(jsonString);

import 'dart:convert';

CardModel cardModelFromJson(String str) => CardModel.fromJson(json.decode(str));

String cardModelToJson(CardModel homeCard) => json.encode(homeCard.toJson());

class CardModel {
  CardModel({
    required this.homeCard,
    required this.totalCount,
    required this.isSuccess,
    this.errorMessages,
    this.errorFieldMessages,
  });

  List<InRequestHome> homeCard;
  int totalCount;
  bool isSuccess;
  dynamic errorMessages;
  dynamic errorFieldMessages;

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
        homeCard: List<InRequestHome>.from(
            json["data"].map((x) => InRequestHome.fromJson(x))),
        totalCount: json["totalCount"],
        isSuccess: json["isSuccess"],
        errorMessages: json["errorMessages"],
        errorFieldMessages: json["errorFieldMessages"],
      );

  Map<String, dynamic> toJson() => {
        "homeCard": List<dynamic>.from(homeCard.map((x) => x.toJson())),
        "totalCount": totalCount,
        "isSuccess": isSuccess,
        "errorMessages": errorMessages,
        "errorFieldMessages": errorFieldMessages,
      };
}

class InRequestHome {
  InRequestHome({
    required this.requestId,
    required this.sellerCode,
    required this.sellerName,
    required this.startEffectiveDate,
    required this.endEffectiveDate,
    required this.leaderCode,
    required this.requestType,
    required this.requestStatus,
    required this.method,
    required this.remark,
    required this.fromLatitude,
    required this.fromLongitude,
    required this.toLatitude,
    required this.toLongitude,
    required this.locationNameTha,
    required this.locationNameEng,
    required this.wareHouseCode,
    required this.wareHouseNameTha,
    required this.wareHouseNameEng,
    required this.addressTha,
    required this.addressEng,
    this.sellerReceiveSignature,
    this.driverReceiveSignature,
    this.sellerDeliverySignature,
    this.driverDeliverySignature,
    required this.active,
    required this.amount,
  });

  String requestId;
  String sellerCode;
  String sellerName;
  DateTime startEffectiveDate;
  DateTime endEffectiveDate;
  String leaderCode;
  String requestType;
  String requestStatus;
  String method;
  String remark;
  double fromLatitude;
  double fromLongitude;
  double toLatitude;
  double toLongitude;
  String locationNameTha;
  String locationNameEng;
  String wareHouseCode;
  String wareHouseNameTha;
  String wareHouseNameEng;
  String addressTha;
  String addressEng;
  dynamic sellerReceiveSignature;
  dynamic driverReceiveSignature;
  dynamic sellerDeliverySignature;
  dynamic driverDeliverySignature;
  bool active;
  int amount;

  factory InRequestHome.fromJson(Map<String, dynamic> json) => InRequestHome(
        requestId: json["requestID"],
        sellerCode: json["sellerCode"],
        sellerName: json["sellerName"],
        startEffectiveDate: DateTime.parse(json["startEffectiveDate"]),
        endEffectiveDate: DateTime.parse(json["endEffectiveDate"]),
        leaderCode: json["leaderCode"],
        requestType: json["requestType"],
        requestStatus: json["requestStatus"],
        method: json["method"],
        remark: json["remark"],
        fromLatitude: json["fromLatitude"],
        fromLongitude: json["fromLongitude"],
        toLatitude: json["toLatitude"],
        toLongitude: json["toLongitude"],
        locationNameTha: json["locationNameTha"],
        locationNameEng: json["locationNameEng"],
        wareHouseCode: json["wareHouseCode"],
        wareHouseNameTha: json["wareHouseNameTha"],
        wareHouseNameEng: json["wareHouseNameEng"],
        addressTha: json["addressTha"],
        addressEng: json["addressEng"],
        sellerReceiveSignature: json["sellerReceiveSignature"],
        driverReceiveSignature: json["driverReceiveSignature"],
        sellerDeliverySignature: json["sellerDeliverySignature"],
        driverDeliverySignature: json["driverDeliverySignature"],
        active: json["active"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "requestID": requestId,
        "sellerCode": sellerCode,
        "sellerName": sellerName,
        "startEffectiveDate": startEffectiveDate.toIso8601String(),
        "endEffectiveDate": endEffectiveDate.toIso8601String(),
        "leaderCode": leaderCode,
        "requestType": requestType,
        "requestStatus": requestStatus,
        "method": method,
        "remark": remark,
        "fromLatitude": fromLatitude,
        "fromLongitude": fromLongitude,
        "toLatitude": toLatitude,
        "toLongitude": toLongitude,
        "locationNameTha": locationNameTha,
        "locationNameEng": locationNameEng,
        "wareHouseCode": wareHouseCode,
        "wareHouseNameTha": wareHouseNameTha,
        "wareHouseNameEng": wareHouseNameEng,
        "addressTha": addressTha,
        "addressEng": addressEng,
        "sellerReceiveSignature": sellerReceiveSignature,
        "driverReceiveSignature": driverReceiveSignature,
        "sellerDeliverySignature": sellerDeliverySignature,
        "driverDeliverySignature": driverDeliverySignature,
        "active": active,
        "amount": amount,
      };
}
