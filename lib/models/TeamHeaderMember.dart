// To parse this JSON data, do
//
//     final teamHeaderMember = teamHeaderMemberFromJson(jsonString);

import 'dart:convert';

TeamHeaderMember teamHeaderMemberFromJson(String str) =>
    TeamHeaderMember.fromJson(json.decode(str));

String teamHeaderMemberToJson(TeamHeaderMember headerTeam) =>
    json.encode(headerTeam.toJson());

class TeamHeaderMember {
  TeamHeaderMember({
    required this.headerTeam,
    required this.totalCount,
    required this.isSuccess,
    this.errorMessages,
    this.errorFieldMessages,
  });

  List<TeamMember>? headerTeam;
  int totalCount;
  bool isSuccess;
  dynamic errorMessages;
  dynamic errorFieldMessages;

  factory TeamHeaderMember.fromJson(Map<String, dynamic> json) =>
      TeamHeaderMember(
        headerTeam: json["data"] == null
            ? null
            : List<TeamMember>.from(
                json["data"].map((x) => TeamMember.fromJson(x))),
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        isSuccess: json["isSuccess"] == null ? null : json["isSuccess"],
        errorMessages: json["errorMessages"],
        errorFieldMessages: json["errorFieldMessages"],
      );

  Map<String, dynamic> toJson() => {
        "data": headerTeam == null
            ? null
            : List<dynamic>.from(headerTeam!.map((x) => x.toJson())),
        "totalCount": totalCount == null ? null : totalCount,
        "isSuccess": isSuccess == null ? null : isSuccess,
        "errorMessages": errorMessages,
        "errorFieldMessages": errorFieldMessages,
      };
}

class TeamMember {
  TeamMember({
    required this.userCode,
    required this.driverCode,
    required this.position,
    required this.active,
    this.image,
  });

  String userCode;
  String driverCode;
  String position;
  bool active;
  dynamic image;

  factory TeamMember.fromJson(Map<String, dynamic> json) => TeamMember(
        userCode: json["userCode"] == null ? null : json["userCode"],
        driverCode: json["driverCode"] == null ? null : json["driverCode"],
        position: json["position"] == null ? null : json["position"],
        active: json["active"] == null ? null : json["active"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "userCode": userCode == null ? null : userCode,
        "driverCode": driverCode == null ? null : driverCode,
        "position": position == null ? null : position,
        "active": active == null ? null : active,
        "image": image,
      };
}
