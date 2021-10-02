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

  Data? data;
  int totalCount;
  bool isSuccess;
  dynamic errorMessages;
  dynamic errorFieldMessages;

  factory RequestDetailModel.fromJson(Map<String, dynamic> json) =>
      RequestDetailModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        isSuccess: json["isSuccess"] == null ? null : json["isSuccess"],
        errorMessages: json["errorMessages"],
        errorFieldMessages: json["errorFieldMessages"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
        "totalCount": totalCount == null ? null : totalCount,
        "isSuccess": isSuccess == null ? null : isSuccess,
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

  RequestDetail? requestDetail;
  List<RequestItem>? requestItems;
  List<RequestImage>? requestImages;
  List<RequestTeamMember>? requestTeamMembers;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        requestDetail: json["requestDetail"] == null
            ? null
            : RequestDetail.fromJson(json["requestDetail"]),
        requestItems: json["requestItems"] == null
            ? null
            : List<RequestItem>.from(
                json["requestItems"].map((x) => RequestItem.fromJson(x))),
        requestImages: json["requestImages"] == null
            ? null
            : List<RequestImage>.from(
                json["requestImages"].map((x) => RequestImage.fromJson(x))),
        requestTeamMembers: json["requestTeamMembers"] == null
            ? null
            : List<RequestTeamMember>.from(json["requestTeamMembers"]
                .map((x) => RequestTeamMember.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "requestDetail": requestDetail == null ? null : requestDetail!.toJson(),
        "requestItems": requestItems == null
            ? null
            : List<dynamic>.from(requestItems!.map((x) => x.toJson())),
        "requestImages": requestImages == null
            ? null
            : List<dynamic>.from(requestImages!.map((x) => x.toJson())),
        "requestTeamMembers": requestTeamMembers == null
            ? null
            : List<dynamic>.from(requestTeamMembers!.map((x) => x.toJson())),
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
  DateTime? startEffectiveDate;
  DateTime? endEffectiveDate;
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
        requestId: json["requestID"] == null ? null : json["requestID"],
        sellerCode: json["sellerCode"] == null ? null : json["sellerCode"],
        sellerName: json["sellerName"] == null ? null : json["sellerName"],
        // startEffectiveDate: DateTime.parse(json["startEffectiveDate"]),
        // endEffectiveDate: DateTime.parse(json["endEffectiveDate"]),
        startEffectiveDate: json["startEffectiveDate"] == null
            ? null
            : DateTime.parse(json["startEffectiveDate"]),
        endEffectiveDate: json["endEffectiveDate"] == null
            ? null
            : DateTime.parse(json["endEffectiveDate"]),

        leaderCode: json["leaderCode"] == null ? null : json["leaderCode"],
        requestType: json["requestType"] == null ? null : json["requestType"],
        requestStatus:
            json["requestStatus"] == null ? null : json["requestStatus"],
        method: json["method"] == null ? null : json["method"],
        remark: json["remark"] == null ? null : json["remark"],
        fromLatitude: json["fromLatitude"] == null
            ? null
            : json["fromLatitude"].toDouble(),
        fromLongitude: json["fromLongitude"] == null
            ? null
            : json["fromLongitude"].toDouble(),
        toLatitude:
            json["toLatitude"] == null ? null : json["toLatitude"].toDouble(),
        toLongitude:
            json["toLongitude"] == null ? null : json["toLongitude"].toDouble(),
        locationNameTha:
            json["locationNameTha"] == null ? null : json["locationNameTha"],
        locationNameEng:
            json["locationNameEng"] == null ? null : json["locationNameEng"],
        wareHouseCode:
            json["wareHouseCode"] == null ? null : json["wareHouseCode"],
        wareHouseNameTha:
            json["wareHouseNameTha"] == null ? null : json["wareHouseNameTha"],
        wareHouseNameEng:
            json["wareHouseNameEng"] == null ? null : json["wareHouseNameEng"],
        addressTha: json["addressTha"] == null ? null : json["addressTha"],
        addressEng: json["addressEng"] == null ? null : json["addressEng"],
        sellerReceiveSignature: json["sellerReceiveSignature"],
        driverReceiveSignature: json["driverReceiveSignature"],
        sellerDeliverySignature: json["sellerDeliverySignature"],
        driverDeliverySignature: json["driverDeliverySignature"],
        active: json["active"] == null ? null : json["active"],
        amount: json["amount"] == null ? null : json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "requestID": requestId == null ? null : requestId,
        "sellerCode": sellerCode == null ? null : sellerCode,
        "sellerName": sellerName == null ? null : sellerName,
        "startEffectiveDate": startEffectiveDate == null
            ? null
            : startEffectiveDate!.toIso8601String(),
        "endEffectiveDate": endEffectiveDate == null
            ? null
            : endEffectiveDate!.toIso8601String(),
        "leaderCode": leaderCode == null ? null : leaderCode,
        "requestType": requestType == null ? null : requestType,
        "requestStatus": requestStatus == null ? null : requestStatus,
        "method": method == null ? null : method,
        "remark": remark == null ? null : remark,
        "fromLatitude": fromLatitude == null ? null : fromLatitude,
        "fromLongitude": fromLongitude == null ? null : fromLongitude,
        "toLatitude": toLatitude == null ? null : toLatitude,
        "toLongitude": toLongitude == null ? null : toLongitude,
        "locationNameTha": locationNameTha == null ? null : locationNameTha,
        "locationNameEng": locationNameEng == null ? null : locationNameEng,
        "wareHouseCode": wareHouseCode == null ? null : wareHouseCode,
        "wareHouseNameTha": wareHouseNameTha == null ? null : wareHouseNameTha,
        "wareHouseNameEng": wareHouseNameEng == null ? null : wareHouseNameEng,
        "addressTha": addressTha == null ? null : addressTha,
        "addressEng": addressEng == null ? null : addressEng,
        "sellerReceiveSignature": sellerReceiveSignature,
        "driverReceiveSignature": driverReceiveSignature,
        "sellerDeliverySignature": sellerDeliverySignature,
        "driverDeliverySignature": driverDeliverySignature,
        "active": active == null ? null : active,
        "amount": amount == null ? null : amount,
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
    required this.requestId,
  });

  String typeFlag;
  int imageSeq;
  String imageType;
  String companyCode;
  String fileName;
  String filePath;
  String requestId;

  factory RequestImage.fromJson(Map<String, dynamic> json) => RequestImage(
        typeFlag: json["typeFlag"] == null ? null : json["typeFlag"],
        imageSeq: json["imageSeq"] == null ? null : json["imageSeq"],
        imageType: json["imageType"] == null ? null : json["imageType"],
        companyCode: json["companyCode"] == null ? null : json["companyCode"],
        fileName: json["fileName"] == null ? null : json["fileName"],
        filePath: json["filePath"] == null ? null : json["filePath"],
        requestId: json["requestID"] == null ? null : json["requestID"],
      );

  Map<String, dynamic> toJson() => {
        "typeFlag": typeFlag == null ? null : typeFlag,
        "imageSeq": imageSeq == null ? null : imageSeq,
        "imageType": imageType == null ? null : imageType,
        "companyCode": companyCode == null ? null : companyCode,
        "fileName": fileName == null ? null : fileName,
        "filePath": filePath == null ? null : filePath,
        "requestID": requestId == null ? null : requestId,
      };
}

class RequestItem {
  RequestItem({
    required this.itemCode,
    required this.companyCode,
    required this.itemStatus,
    required this.sellerCode,
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
    required this.requestId,
  });

  String itemCode;
  String companyCode;
  String itemStatus;
  String? sellerCode;
  String? remark;
  String? brandCode;
  String? brandNameTha;
  String? brandNameEng;
  String? modelCode;
  String? modelName;
  String? subModelCode;
  String? subModelName;
  String? custSubModelCode;
  String? licensePlateNo;
  int? provinceId;
  String? provinceName;
  int? districtId;
  String? districtName;
  String? colorCode;
  String? color;
  String? gearCode;
  String? gearName;
  String? gearType;
  double? manufactureYear;
  double? receiveMiles;
  String requestId;

  factory RequestItem.fromJson(Map<String, dynamic> json) => RequestItem(
        itemCode: json["itemCode"] == null ? null : json["itemCode"],
        companyCode: json["companyCode"] == null ? null : json["companyCode"],
        itemStatus: json["itemStatus"] == null ? null : json["itemStatus"],
        sellerCode: json["sellerCode"] == null ? null : json["sellerCode"],
        remark: json["remark"] == null ? null : json["remark"],
        brandCode: json["brandCode"] == null ? null : json["brandCode"],
        brandNameTha:
            json["brandNameTha"] == null ? null : json["brandNameTha"],
        brandNameEng:
            json["brandNameEng"] == null ? null : json["brandNameEng"],
        modelCode: json["modelCode"] == null ? null : json["modelCode"],
        modelName: json["modelName"] == null ? null : json["modelName"],
        subModelCode:
            json["subModelCode"] == null ? null : json["subModelCode"],
        subModelName:
            json["subModelName"] == null ? null : json["subModelName"],
        custSubModelCode:
            json["custSubModelCode"] == null ? null : json["custSubModelCode"],
        licensePlateNo:
            json["licensePlateNo"] == null ? null : json["licensePlateNo"],
        provinceId: json["provinceID"] == null ? null : json["provinceID"],
        provinceName:
            json["provinceName"] == null ? null : json["provinceName"],
        districtId: json["districtID"] == null ? null : json["districtID"],
        districtName:
            json["districtName"] == null ? null : json["districtName"],
        colorCode: json["colorCode"] == null ? null : json["colorCode"],
        color: json["color"] == null ? null : json["color"],
        gearCode: json["gearCode"] == null ? null : json["gearCode"],
        gearName: json["gearName"] == null ? null : json["gearName"],
        gearType: json["gearType"] == null ? null : json["gearType"],
        manufactureYear:
            json["manufactureYear"] == null ? null : json["manufactureYear"],
        receiveMiles:
            json["receiveMiles"] == null ? null : json["receiveMiles"],
        requestId: json["requestID"] == null ? null : json["requestID"],
      );

  Map<String, dynamic> toJson() => {
        "itemCode": itemCode == null ? null : itemCode,
        "companyCode": companyCode == null ? null : companyCode,
        "itemStatus": itemStatus == null ? null : itemStatus,
        "sellerCode": sellerCode == null ? null : sellerCode,
        "remark": remark == null ? null : remark,
        "brandCode": brandCode == null ? null : brandCode,
        "brandNameTha": brandNameTha == null ? null : brandNameTha,
        "brandNameEng": brandNameEng == null ? null : brandNameEng,
        "modelCode": modelCode == null ? null : modelCode,
        "modelName": modelName == null ? null : modelName,
        "subModelCode": subModelCode == null ? null : subModelCode,
        "subModelName": subModelName == null ? null : subModelName,
        "custSubModelCode": custSubModelCode == null ? null : custSubModelCode,
        "licensePlateNo": licensePlateNo == null ? null : licensePlateNo,
        "provinceID": provinceId == null ? null : provinceId,
        "provinceName": provinceName == null ? null : provinceName,
        "districtID": districtId == null ? null : districtId,
        "districtName": districtName == null ? null : districtName,
        "colorCode": colorCode == null ? null : colorCode,
        "color": color == null ? null : color,
        "gearCode": gearCode == null ? null : gearCode,
        "gearName": gearName == null ? null : gearName,
        "gearType": gearType == null ? null : gearType,
        "manufactureYear": manufactureYear == null ? null : manufactureYear,
        "receiveMiles": receiveMiles == null ? null : receiveMiles,
        "requestID": requestId == null ? null : requestId,
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
        requestId: json["requestID"] == null ? null : json["requestID"],
        driverCode: json["driverCode"] == null ? null : json["driverCode"],
        active: json["active"] == null ? null : json["active"],
      );

  Map<String, dynamic> toJson() => {
        "requestID": requestId == null ? null : requestId,
        "driverCode": driverCode == null ? null : driverCode,
        "active": active == null ? null : active,
      };
}
