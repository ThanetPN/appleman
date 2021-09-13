// To parse this JSON data, do
//
//     final requestDetailModel = requestDetailModelFromJson(jsonString);

import 'dart:convert';

RequestDetailModel requestDetailModelFromJson(String str) =>
    RequestDetailModel.fromJson(json.decode(str));

String requestDetailModelToJson(RequestDetailModel data) =>
    json.encode(data.toJson());

class RequestDetailModel {
  RequestDetailModel({
    required this.data,
    required this.totalCount,
    required this.isSuccess,
    this.errorMessages,
    this.errorFieldMessages,
  });

  Data data;
  int totalCount;
  bool isSuccess;
  dynamic errorMessages;
  dynamic errorFieldMessages;

  factory RequestDetailModel.fromJson(Map<String, dynamic> json) =>
      RequestDetailModel(
        data: Data.fromJson(json["data"]),
        totalCount: json["totalCount"],
        isSuccess: json["isSuccess"],
        errorMessages: json["errorMessages"],
        errorFieldMessages: json["errorFieldMessages"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "totalCount": totalCount,
        "isSuccess": isSuccess,
        "errorMessages": errorMessages,
        "errorFieldMessages": errorFieldMessages,
      };
}

class Data {
  Data({
    required this.requestDetail,
    required this.requestItems,
    required this.requestImages,
    required this.requestTeamMembers,
  });

  RequestDetail requestDetail;
  List<RequestItem> requestItems;
  List<RequestImage> requestImages;
  List<RequestTeamMember> requestTeamMembers;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        requestDetail: RequestDetail.fromJson(json["requestDetail"]),
        requestItems: List<RequestItem>.from(
            json["requestItems"].map((x) => RequestItem.fromJson(x))),
        requestImages: List<RequestImage>.from(
            json["requestImages"].map((x) => RequestImage.fromJson(x))),
        requestTeamMembers: List<RequestTeamMember>.from(
            json["requestTeamMembers"]
                .map((x) => RequestTeamMember.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "requestDetail": requestDetail.toJson(),
        "requestItems": List<dynamic>.from(requestItems.map((x) => x.toJson())),
        "requestImages":
            List<dynamic>.from(requestImages.map((x) => x.toJson())),
        "requestTeamMembers":
            List<dynamic>.from(requestTeamMembers.map((x) => x.toJson())),
      };
}

class RequestDetail {
  RequestDetail({
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

  factory RequestDetail.fromJson(Map<String, dynamic> json) => RequestDetail(
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
        fromLatitude: json["fromLatitude"].toDouble(),
        fromLongitude: json["fromLongitude"].toDouble(),
        toLatitude: json["toLatitude"].toDouble(),
        toLongitude: json["toLongitude"].toDouble(),
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

class RequestImage {
  RequestImage({
    required this.typeFlag,
    required this.imageSeq,
    required this.imageType,
    required this.companyCode,
    required this.fileName,
    required this.filePath,
    this.itemCode,
  });

  String typeFlag;
  int imageSeq;
  String imageType;
  String companyCode;
  String fileName;
  String filePath;
  dynamic itemCode;

  factory RequestImage.fromJson(Map<String, dynamic> json) => RequestImage(
        typeFlag: json["typeFlag"],
        imageSeq: json["imageSeq"],
        imageType: json["imageType"],
        companyCode: json["companyCode"],
        fileName: json["fileName"],
        filePath: json["filePath"],
        itemCode: json["itemCode"],
      );

  Map<String, dynamic> toJson() => {
        "typeFlag": typeFlag,
        "imageSeq": imageSeq,
        "imageType": imageType,
        "companyCode": companyCode,
        "fileName": fileName,
        "filePath": filePath,
        "itemCode": itemCode,
      };
}

class RequestItem {
  RequestItem({
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

  factory RequestItem.fromJson(Map<String, dynamic> json) => RequestItem(
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

class RequestTeamMember {
  RequestTeamMember({
    required this.requestId,
    required this.driverCode,
    required this.active,
  });

  String requestId;
  String driverCode;
  bool active;

  factory RequestTeamMember.fromJson(Map<String, dynamic> json) =>
      RequestTeamMember(
        requestId: json["requestID"],
        driverCode: json["driverCode"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "requestID": requestId,
        "driverCode": driverCode,
        "active": active,
      };
}
