import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterappleman/constants/Mystyle.dart';
import 'package:flutterappleman/models/RequestDetailModel.dart';
import 'package:flutterappleman/models/TeamHeaderMember.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DetailSchedule extends StatefulWidget {
  DetailSchedule({Key? key}) : super(key: key);

  @override
  _DetailScheduleState createState() => _DetailScheduleState();
}

class _DetailScheduleState extends State<DetailSchedule> {
  late RequestDetail requestDetail = requestDetail;
  List<RequestItem?> requestItems = [];
  List<RequestTeamMember> requestTeamMembers = [];
  List<TeamMember>? member = [];
  bool isLoading = true;
  late String wareHouseNameTha;
  //var EventCalendar;
  var RequestID;
  var RrequestStatus;

  //getData
  _getDetail() async {
    var url = Uri.parse(
        'https://apps.softsquaregroup.com/AAA.AppleMan.API/api/Requst/GetRequestDetail?RequestID=${RequestID.toString()}');
    final http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      final RequestDetailModel detail =
          RequestDetailModel.fromJson(convert.jsonDecode(response.body));

      if (this.mounted) {
        setState(() {
          requestDetail = detail.data!.requestDetail!;
          requestItems = detail.data!.requestItems!;
          requestTeamMembers = detail.data!.requestTeamMembers!;
          isLoading = false;
        });
      }
    } else {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Error Api",
        desc: "เกิดข้อผิดพลาดจากระบบ",
        buttons: [
          DialogButton(
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ).show();
    }
  }

  //หัวหน้าทีม
  getHeaderTeam() async {
    var url = Uri.parse(
        'https://apps.softsquaregroup.com/AAA.AppleMan.API/api/RequestTeamMember/GetRequestTeamMember');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      final TeamHeaderMember hearderMember = TeamHeaderMember.fromJson(
        convert.jsonDecode(response.body),
      );

      setState(() {
        member = hearderMember.member;
        isLoading = false;
      });
    } else {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Error Api",
        desc: "เกิดข้อผิดพลาดจากระบบ",
        buttons: [
          DialogButton(
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ).show();
    }
  }

  _work() async {
    final url = Uri.parse(
        'https://apps.softsquaregroup.com/AAA.AppleMan.API/api/Requst/UpdateRequestStatus');

    final http.Response response = await http.post(url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: convert.jsonEncode({
          "RequestStatus": "รอการยืนยัน",
          "RequestID": RequestID,
          "Description": Description.text,
        }));
    print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        isLoading = true;
      });
      print(response.body);

      //ไปหน้า calendar
      Navigator.pushNamedAndRemoveUntil(
          context, '/navigationBar', (Route<dynamic> route) => false);
    } else {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Error Api",
        desc: "เกิดข้อผิดพลาดจากระบบ",
        buttons: [
          DialogButton(
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ).show();
    }
  }

  _workConfirm() async {
    final url = Uri.parse(
        'https://apps.softsquaregroup.com/AAA.AppleMan.API/api/Requst/UpdateRequestStatus');
    final http.Response response = await http.post(url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: convert.jsonEncode({
          "RequestStatus": "รอดำเนินการ",
          "RequestID": RequestID,
          "Description": 'null',
        }));
    if (response.statusCode == 200) {
      setState(() {
        isLoading = true;
      });

      //ไปหน้า detail
      Navigator.pop(context, '/detail');
    } else {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Error Api",
        desc: "เกิดข้อผิดพลาดจากระบบ",
        buttons: [
          DialogButton(
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ).show();
    }
  }

  _deleteRequestItem(String itemCode) async {
    final url = Uri.parse(
        'https://apps.softsquaregroup.com/AAA.AppleMan.API/api/RequestItem/DeleteRequestItem');
    final http.Response response = await http.delete(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode(
        {"itemCode": itemCode},
      ),
    );
    if (response.statusCode == 200) {
      Alert(
        context: context,
        type: AlertType.success,
        title: "Succeed",
        desc: "ลบรายการรับรถสำเร็จ",
        buttons: [
          DialogButton(
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pushNamed(
              context,
              '/detail',
              arguments: {
                'RequestID': RequestID,
                'RequestStatus': RrequestStatus
              },
            ),
          )
        ],
      ).show();
    } else {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Error Api",
        desc: "เกิดข้อผิดพลาดจากระบบ",
        buttons: [
          DialogButton(
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pushNamed(
              context,
              '/detail',
              arguments: {
                'RequestID': RequestID,
                'RequestStatus': RrequestStatus
              },
            ),
          )
        ],
      ).show();
    }
  }

  _deleteTeamMember(String driverCode) async {
    final url = Uri.parse(
        'https://apps.softsquaregroup.com/AAA.AppleMan.API/api/RequestTeamMember/DeleteTeamMember');
    final http.Response response = await http.delete(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode(
        {"driverCode": driverCode},
      ),
    );
    if (response.statusCode == 200) {
      Alert(
        context: context,
        type: AlertType.success,
        title: "Succeed",
        desc: "ลบสมาชิกสำเร็จ",
        buttons: [
          DialogButton(
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pushNamed(
              context,
              '/detail',
              arguments: {
                'RequestID': RequestID,
                'RequestStatus': RrequestStatus
              },
            ),
          )
        ],
      ).show();
    } else {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Error Api",
        desc: "เกิดข้อผิดพลาดจากระบบ",
        buttons: [
          DialogButton(
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pushNamed(
              context,
              '/detail',
              arguments: {
                'RequestID': RequestID,
                'RequestStatus': RrequestStatus
              },
            ),
          )
        ],
      ).show();
    }
  }

  //แก้ไขรายการรับรถ
  _updateFormItemCard(String itemCode) async {
    var url = Uri.parse(
        'https://apps.softsquaregroup.com/AAA.AppleMan.API/api/RequestItem/UpdateRequestItem');

    final http.Response response = await http.post(
      url,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: convert.jsonEncode(
        {
          'itemCode': itemCode,
          'brandNameEng': brandNameEng.text,
          'modelName': modelName.text,
          'color': color.text,
          'licensePlateNo': licensePlateNo.text,
          'manufactureYear': manufactureYear.text,
        },
      ),
    );
    if (response.statusCode == 200) {
      Alert(
        context: context,
        type: AlertType.success,
        title: "Succeed",
        desc: "แก้ไขรายการรับรถสำเร็จ",
        buttons: [
          DialogButton(
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pushNamed(
              context,
              '/detail',
              arguments: {
                'RequestID': RequestID,
              },
            ),
          )
        ],
      ).show();
    } else {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Error Api",
        desc: "เกิดข้อผิดพลาดจากระบบ",
        buttons: [
          DialogButton(
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ).show();
    }
  }

  //input การรับงานไม่รับงาน
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  var Description = TextEditingController();

  //เพิ่ม รายการรับรถ
  final TextEditingController itemCode = TextEditingController();
  final TextEditingController brandNameEng = TextEditingController();
  final TextEditingController modelName = TextEditingController();
  final TextEditingController color = TextEditingController();
  final TextEditingController licensePlateNo = TextEditingController();
  final TextEditingController manufactureYear = TextEditingController();

  //insert รายการรับรถ
  _requestItemWithUser() async {
    var url = Uri.parse(
        'https://apps.softsquaregroup.com/AAA.AppleMan.API/api/RequestItem/RequestItemWithUser');
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode(
        {
          "requestID": RequestID,
          'itemCode': itemCode.text,
          'brandNameEng': brandNameEng.text,
          'modelName': modelName.text,
          'color': color.text,
          'licensePlateNo': licensePlateNo.text,
          'manufactureYear': manufactureYear.text,
        },
      ),
    );
    if (response.statusCode == 500) {
      Alert(
        context: context,
        type: AlertType.success,
        title: "Succeed",
        desc: "เพิ่มรายการรับรถสำเร็จ",
        buttons: [
          DialogButton(
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pushNamed(
              context,
              '/detail',
              arguments: {
                'RequestID': RequestID,
                'RequestStatus': RrequestStatus
              },
            ),
          )
        ],
      ).show();
    } else {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Error Api",
        desc: "เกิดข้อผิดพลาดจากระบบ",
        buttons: [
          DialogButton(
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ).show();
    }
  }

  @override
  void initState() {
    if (mounted) {
      getHeaderTeam();
      super.initState();
    }
  }

  @override
  void dispose() {
    _getDetail();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final z = new DateFormat('dd/MM/yyyy');
    final f = new DateFormat('hh:mm');

    Map eventCalendarDate = ModalRoute.of(context)!.settings.arguments as Map;
    late String _requestID = ("${eventCalendarDate['RequestID']}");
    late String _requestStatus = ("${eventCalendarDate['RequestStatus']}");
    RequestID = _requestID;
    RrequestStatus = _requestStatus;
    _getDetail();

    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('รายละเอียดงาน', style: MyStyle().whiteTitleStyle()),
      ),
      backgroundColor: MyStyle().garyAllColor,
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : new ListView(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('รายละเอียดงาน',
                                      style: MyStyle().blueHeaderStyle()),
                                  Row(
                                    children: [
                                      Container(
                                        child: requestDetail.requestStatus ==
                                                'รอการยืนยัน'
                                            ? MaterialButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5))),
                                                color: MyStyle().garyssColor,
                                                child: Text(
                                                    requestDetail == null
                                                        ? '-'
                                                        : requestDetail
                                                            .requestStatus,
                                                    style:
                                                        MyStyle().whiteStyle()),
                                                onPressed: () {},
                                              )
                                            : errorA(),
                                      ),
                                      Container(
                                        child: requestDetail.requestStatus ==
                                                'รอดำเนินการ'
                                            ? MaterialButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5))),
                                                color: MyStyle().yellowColor,
                                                child: Text(
                                                    requestDetail.requestStatus,
                                                    style:
                                                        MyStyle().whiteStyle()),
                                                onPressed: () {},
                                              )
                                            : errorA(),
                                      ),
                                      Container(
                                        child: requestDetail.requestStatus ==
                                                'รอนำส่งรถ'
                                            ? MaterialButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5))),
                                                color: MyStyle().yellowColor,
                                                child: Text(
                                                    requestDetail.requestStatus,
                                                    style:
                                                        MyStyle().whiteStyle()),
                                                onPressed: () {},
                                              )
                                            : errorA(),
                                      ),
                                      Container(
                                        child: requestDetail.requestStatus ==
                                                'เสร็จสิ้น'
                                            ? MaterialButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5))),
                                                color: MyStyle().greenColor,
                                                child: Text(
                                                    requestDetail.requestStatus,
                                                    style:
                                                        MyStyle().whiteStyle()),
                                                onPressed: () {},
                                              )
                                            : errorA(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: double.infinity,
                                height: 5,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: <Color>[
                                        Colors.grey.shade400,
                                        Colors.white,
                                      ],
                                      tileMode: TileMode.clamp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'ผู้ขาย',
                                style: MyStyle().blueStyle(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    children: [
                                      Text(requestDetail == null
                                          ? '-'
                                          : requestDetail.sellerName)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.call),
                                      SizedBox(width: 10),
                                      Text('081-1234564')
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'ผู้ติดต่อ',
                                style: MyStyle().blueStyle(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    children: [
                                      Text('นางณัฐพร พลอยไพริน'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.call),
                                      SizedBox(width: 10),
                                      Text('081-1234562')
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_today),
                                      SizedBox(width: 10),
                                      Text(
                                        requestDetail == null
                                            ? '-'
                                            : z.format(requestDetail
                                                .startEffectiveDate!),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.watch_later),
                                      SizedBox(width: 10),
                                      Text(
                                        requestDetail == null
                                            ? '-'
                                            : f.format(requestDetail
                                                .startEffectiveDate!),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.directions_car),
                                  SizedBox(width: 10),
                                  Text(requestDetail == null
                                      ? '-'
                                      : '${requestDetail.amount.toString()} คัน')
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(requestDetail == null
                                  ? '-'
                                  : 'หมายเหตุ : ${requestDetail.remark.toString()} น.'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'สถานที่รับรถ',
                                    style: MyStyle().blueStyle(),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.red,
                                      ),
                                      SizedBox(width: 10),
                                      Text(requestDetail == null
                                          ? '-'
                                          : requestDetail.locationNameTha)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(width: 20),
                                      Icon(Icons.map),
                                      SizedBox(width: 5),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          primary: Color(0xFF4A90E2),
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            '/pickUpLocation',
                                            arguments: {
                                              'requestId':
                                                  requestDetail.requestId,
                                              'locationNameTha':
                                                  requestDetail.locationNameTha,
                                              'locationNameEng':
                                                  requestDetail.locationNameEng,
                                              //location
                                              'fromLatitude':
                                                  requestDetail.fromLatitude,
                                              'fromLongitude':
                                                  requestDetail.fromLongitude
                                            },
                                          );
                                        },
                                        child: Text('เปิด Google Map'),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(width: 20),
                                      Icon(Icons.image),
                                      SizedBox(width: 5),
                                      Text('แผนที่.jpg')
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'สถานที่ส่ง',
                                    style: MyStyle().blueStyle(),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.red,
                                      ),
                                      SizedBox(width: 10),
                                      Text(requestDetail == null
                                          ? '-'
                                          : requestDetail.wareHouseNameTha)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(width: 20),
                                      Icon(Icons.map),
                                      SizedBox(width: 5),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          primary: Color(0xFF4A90E2),
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/dropOffLocation',
                                              arguments: {
                                                'requestId':
                                                    requestDetail.requestId,
                                                'wareHouseNameTha':
                                                    requestDetail
                                                        .wareHouseNameTha,
                                                'wareHouseNameEng':
                                                    requestDetail
                                                        .wareHouseNameEng,
                                                'toLatitude':
                                                    requestDetail.toLatitude,
                                                'toLongitude':
                                                    requestDetail.toLongitude
                                              });
                                        },
                                        child: const Text('เปิด Google Map'),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(width: 20),
                                      Icon(Icons.image),
                                      SizedBox(width: 5),
                                      Text('รูปหน้าโกดังลาดพร้าว.jpg')
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(width: 20),
                                      Icon(Icons.image),
                                      SizedBox(width: 5),
                                      Text('แผนที่.jpg'),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //Add Teams
                    Container(
                      child: requestDetail.requestStatus == 'รอดำเนินการ'
                          ? cardAA()
                          : errorA(),
                    ),

                    //Add Teams
                    Container(
                      child: requestDetail.requestStatus == 'รอนำส่งรถ'
                          ? cardAA()
                          : errorA(),
                    ),

                    //card requestItem Draft
                    Container(
                      child: requestDetail.requestStatus == 'รอการยืนยัน'
                          ? draftAA()
                          : errorA(),
                    ),

                    //card requestItem รอนำส่งรถ
                    Container(
                      child: requestDetail.requestStatus == 'รอดำเนินการ'
                          ? pendingAA()
                          : errorA(),
                    ),

                    //card requestItem รอนำส่งรถ
                    Container(
                      child: requestDetail.requestStatus == 'รอนำส่งรถ'
                          ? waitingCar()
                          : errorA(),
                    ),

                    //card requestItem รอนำส่งรถ
                    Container(
                      child: requestDetail.requestStatus == 'รอนำส่งรถ'
                          ? buttonWaitingCard()
                          : errorA(),
                    ),

                    //card requestItem การเพิ่มรายการรับรถ รอดำเนินการ
                    Container(
                      child: requestDetail.requestStatus == 'รอดำเนินการ'
                          ? insertAddCarCard()
                          : errorA(),
                    ),

                    //ไม่รับงาน กับ ยืนยันรับงาน
                    Container(
                      child: requestDetail.requestStatus == 'รอการยืนยัน'
                          ? Container(
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.05,
                                  right:
                                      MediaQuery.of(context).size.width * 0.05),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    buttonDeny(),
                                    buttonConfirm(),
                                  ]),
                            )
                          : errorA(),
                    ),

                    //ยกเลิกงาน กับ ยืนยันรับรถ
                    Container(
                      child: requestDetail.requestStatus == 'รอดำเนินการ'
                          ? Container(
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.05,
                                  right:
                                      MediaQuery.of(context).size.width * 0.05),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  buttonCancel(),
                                  buttonConfirmCar(),
                                ],
                              ),
                            )
                          : errorA(),
                    ),
                  ],
                )
              ],
            ),
      //iconcar
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Container(
        child: _requestStatus == 'รอดำเนินการ' ? buildButton() : errorA(),
      ),
    );
  }

  //items Card == รอการยืนยัน
  Widget draftAA() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: requestItems
            .map(
              (RequestItem? e) => Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/car.jpg',
                            height: 150,
                            width: 150,
                          ),
                          SizedBox(width: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text((e == null || e.brandNameTha == null)
                                  ? '-'
                                  : e.brandNameTha!),
                              Text((e == null || e.brandNameEng == null)
                                  ? '-'
                                  : e.brandNameEng!),
                              Text((e == null || e.modelName == null)
                                  ? '-'
                                  : e.modelName!),
                              Text((e == null || e.color == null)
                                  ? '-'
                                  : e.color!),
                              Text((e == null || e.licensePlateNo == null)
                                  ? '-'
                                  : e.licensePlateNo!),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  //items Card == รอดำเนินการ
  Widget pendingAA() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: requestItems
            .map(
              (RequestItem? e) => Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/car.jpg',
                            height: 150,
                            width: 150,
                          ),
                          SizedBox(width: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text((e == null || e.brandNameTha == null)
                                  ? '-'
                                  : e.brandNameTha!),
                              Text((e == null || e.brandNameEng == null)
                                  ? '-'
                                  : e.brandNameEng!),
                              Text((e == null || e.modelName == null)
                                  ? '-'
                                  : e.modelName!),
                              Text((e == null || e.color == null)
                                  ? '-'
                                  : e.color!),
                              Text((e == null || e.licensePlateNo == null)
                                  ? '-'
                                  : e.licensePlateNo!),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  //items Card == รอดำเนินการ
  Widget waitingCar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: requestItems
            .map(
              (RequestItem? e) => Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/car.jpg',
                            height: 150,
                            width: 150,
                          ),
                          SizedBox(width: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text((e == null || e.brandNameTha == null)
                                  ? '-'
                                  : e.brandNameTha!),
                              Text((e == null || e.brandNameEng == null)
                                  ? '-'
                                  : e.brandNameEng!),
                              Text((e == null || e.modelName == null)
                                  ? '-'
                                  : e.modelName!),
                              Text((e == null || e.color == null)
                                  ? '-'
                                  : e.color!),
                              Text((e == null || e.licensePlateNo == null)
                                  ? '-'
                                  : e.licensePlateNo!),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  //card requestItem การเพิ่มรายการรับรถ รอดำเนินการ
  Widget insertAddCarCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: requestItems
            .map(
              (RequestItem? e) => Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/car.jpg',
                                height: 150,
                                width: 150,
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text((e == null || e.brandNameTha == null)
                                      ? '-'
                                      : e.brandNameTha!),
                                  Text((e == null || e.brandNameEng == null)
                                      ? '-'
                                      : e.brandNameEng!),
                                  Text((e == null || e.modelName == null)
                                      ? '-'
                                      : e.modelName!),
                                  Text((e == null || e.color == null)
                                      ? '-'
                                      : e.color!),
                                  Text((e == null || e.licensePlateNo == null)
                                      ? '-'
                                      : e.licensePlateNo!),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                color: MyStyle().yellowColor,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Container(
                                          height: 600,
                                          child: ListView(
                                            children: [
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 30),
                                              ),
                                              Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      'แก้ไขรายการรถ',
                                                      style: MyStyle()
                                                          .blueHeaderStyle(),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text('รูปภาพประกอบ'),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          child: Card(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child: new InkWell(
                                                              onTap: () async {
                                                                Navigator.of(
                                                                        context,
                                                                        rootNavigator:
                                                                            true)
                                                                    .pushNamed(
                                                                        '/camera');
                                                              },
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.fromLTRB(
                                                                            50,
                                                                            15,
                                                                            50,
                                                                            15),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .camera_alt,
                                                                          size:
                                                                              80,
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  FormBuilder(
                                                    key: _fbKey,
                                                    child: Column(
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  'ยี่ห้อ'),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    brandNameEng,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .text,
                                                                decoration:
                                                                    InputDecoration(
                                                                  border:
                                                                      OutlineInputBorder(),
                                                                  labelText:
                                                                      'brandNameEng',
                                                                ),
                                                                validator:
                                                                    brandNameEngValidator,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  Text('รุ่น'),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  TextFormField(
                                                                      controller:
                                                                          modelName,
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .text,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        border:
                                                                            OutlineInputBorder(),
                                                                        labelText:
                                                                            'ModelName',
                                                                      ),
                                                                      validator:
                                                                          modelNameValidator),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text('สี'),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    color,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .text,
                                                                decoration:
                                                                    InputDecoration(
                                                                  border:
                                                                      OutlineInputBorder(),
                                                                  labelText:
                                                                      'Color',
                                                                ),
                                                                validator:
                                                                    colorValidator,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  'ทะเบียนรถ'),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    licensePlateNo,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .text,
                                                                decoration:
                                                                    InputDecoration(
                                                                  border:
                                                                      OutlineInputBorder(),
                                                                  labelText:
                                                                      'LicensePlateNo',
                                                                ),
                                                                validator:
                                                                    licensePlateNoValidator,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  'ปีผลิต'),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    manufactureYear,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                decoration:
                                                                    InputDecoration(
                                                                  border:
                                                                      OutlineInputBorder(),
                                                                  labelText:
                                                                      'ManufactureYear',
                                                                ),
                                                                validator:
                                                                    manufactureYearValidator,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text(
                                                            'รูปเล่มทะเบียนรถ'),
                                                        Card(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: new InkWell(
                                                            onTap: () {
                                                              Navigator.of(
                                                                      context,
                                                                      rootNavigator:
                                                                          true)
                                                                  .pushNamed(
                                                                      '/camera');
                                                            },
                                                            child: Column(
                                                              children: <
                                                                  Widget>[
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .fromLTRB(
                                                                          50,
                                                                          15,
                                                                          50,
                                                                          15),
                                                                  child: Column(
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .camera_alt,
                                                                        size:
                                                                            80,
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: MaterialButton(
                                                            height: 50,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    5),
                                                              ),
                                                            ),
                                                            color: MyStyle()
                                                                .buttongray,
                                                            textColor:
                                                                Colors.white,
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context,
                                                                  '/detail');
                                                            },
                                                            child: Text(
                                                              'ยกเลิก',
                                                              style: MyStyle()
                                                                  .whiteStyle(),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: MaterialButton(
                                                            height: 50,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    5),
                                                              ),
                                                            ),
                                                            color: MyStyle()
                                                                .buttongray,
                                                            textColor:
                                                                Colors.white,
                                                            onPressed: () {
                                                              if (_fbKey
                                                                  .currentState!
                                                                  .saveAndValidate()) {
                                                                _updateFormItemCard(
                                                                  e!.itemCode,
                                                                );
                                                              }
                                                            },
                                                            child: Text(
                                                              'ยืนยัน',
                                                              style: MyStyle()
                                                                  .whiteStyle(),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                color: MyStyle().redyColor,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible:
                                        false, // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Alert'),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                  'คุณต้องการลบรายการรับรถนี้ใช่ไหม?'),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('Cancel'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: Text('OK'),
                                            onPressed: () {
                                              _deleteRequestItem(e!.itemCode);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  //button ปัฎิเสธ
  Widget buttonDeny() {
    final descriptionValidator = MultiValidator(
      [
        RequiredValidator(errorText: 'Enter your Description'),
      ],
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        minWidth: 120,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        color: MyStyle().redyColor,
        textColor: Colors.white,
        child: Text(
          'ไม่รับงาน',
          style: MyStyle().whiteStyle(),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  height: 350,
                  child: ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'ไม่รับงาน',
                              style: MyStyle().redStyle(),
                            ),
                          ),
                        ],
                      ),
                      FormBuilder(
                        key: _fbKey,
                        initialValue: {'Description': ''},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'เหตุผลไม่รับงาน',
                                style: MyStyle().garyStyle(),
                              ),
                              //Text input
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: Description,
                                  maxLines: 4,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Description',
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: MyStyle().garyColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: MyStyle().garyColor,
                                      ),
                                    ),
                                    hintStyle: MyStyle().h3Style(),
                                  ),
                                  validator: descriptionValidator,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              color: MyStyle().buttongray,
                              textColor: Colors.white,
                              onPressed: () {
                                Navigator.pop(context, '/detail');
                              },
                              child: Text(
                                'ยกเลิก',
                                style: MyStyle().whiteStyle(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              color: MyStyle().buttongreen,
                              textColor: Colors.white,
                              onPressed: () {
                                if (_fbKey.currentState!.saveAndValidate()) {
                                  _work();
                                }
                              },
                              child: Text(
                                'ยืนยัน',
                                style: MyStyle().whiteStyle(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  //button ยืนยันรับงาน
  Widget buttonConfirm() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        color: MyStyle().buttonblue, // background
        child: Text(
          'ยืนยันรับงาน',
          style: MyStyle().whiteStyle(),
        ),
        onPressed: () => _workConfirm(),
      ),
    );
  }

  //ทีมงาน

  Widget cardAA() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ทีมงาน',
                    style: MyStyle().blueStyle(),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add_circle,
                    ),
                    iconSize: 30,
                    color: MyStyle().buttongreen,
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/add-member',
                        arguments: {
                          'RequestID': RequestID,
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                height: 5,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Colors.grey.shade400,
                        Colors.white,
                      ],
                      tileMode: TileMode.clamp,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: member!
                    .map(
                      (e) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                e.driverCode,
                                style: MyStyle().garyStyle(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: requestTeamMembers
                    .map(
                      (e) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                e.driverCode,
                                style: MyStyle().garyStyle(),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                color: MyStyle().redyColor,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible:
                                        false, // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Alert'),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                  'คุณต้องการลบสมาชิกคนนี้ใช่ไหม?'),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('Cancel'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: Text('OK'),
                                            onPressed: () {
                                              _deleteTeamMember(e.driverCode);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget errorA() {
    return Container(
      child: Text(''),
    );
  }

  //button ปัฎิเสธ
  Widget buttonCancel() {
    final descriptionValidator = MultiValidator(
      [
        RequiredValidator(errorText: 'Enter your Description'),
      ],
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        minWidth: 120,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        color: MyStyle().redyColor,
        textColor: Colors.white,
        child: Text(
          'ยกเลิกงาน',
          style: MyStyle().whiteStyle(),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  height: 350,
                  child: ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'ยกเลิกงาน',
                              style: MyStyle().redStyle(),
                            ),
                          ),
                        ],
                      ),
                      FormBuilder(
                        key: _fbKey,
                        initialValue: {'Description': ''},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'เหตุผลยกเลิกงาน',
                                style: MyStyle().garyStyle(),
                              ),
                              //Text input
                              Container(
                                margin: EdgeInsets.only(top: 16),
                                child: TextFormField(
                                  controller: Description,
                                  maxLines: 4,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Description',
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: MyStyle().garyColor),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: MyStyle().garyColor),
                                    ),
                                    hintStyle: MyStyle().h3Style(),
                                  ),
                                  validator: descriptionValidator,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              color: MyStyle().buttongray,
                              textColor: Colors.white,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'ยกเลิก',
                                style: MyStyle().whiteStyle(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              color: MyStyle().buttongreen,
                              textColor: Colors.white,
                              onPressed: () {
                                if (_fbKey.currentState!.saveAndValidate()) {
                                  _work();
                                }
                              },
                              child: Text(
                                'ยืนยัน',
                                style: MyStyle().whiteStyle(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  //button ยืนยันรับรถ
  Widget buttonConfirmCar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        color: MyStyle().buttonblue, // background
        child: Text(
          'ยืนยันรับรถ',
          style: MyStyle().whiteStyle(),
        ),
        onPressed: () => {
          Navigator.pushNamed(
            context,
            '/evidence-car',
            arguments: {
              'RequestID': RequestID,
              'RequestStatus': requestDetail.requestStatus
            },
          )
        },
      ),
    );
  }

  //Validate IconCar
  final itemCodeValidator = MultiValidator([
    RequiredValidator(errorText: 'Enter your itemCode'),
  ]);
  final brandNameEngValidator = MultiValidator(
    [
      RequiredValidator(errorText: 'Enter your BrandNameEng'),
    ],
  );
  final modelNameValidator = MultiValidator(
    [
      RequiredValidator(errorText: 'Enter your ModelName'),
    ],
  );
  final colorValidator = MultiValidator(
    [
      RequiredValidator(errorText: 'Enter your Color'),
    ],
  );
  final licensePlateNoValidator = MultiValidator(
    [
      RequiredValidator(errorText: 'Enter your LicensePlateNo'),
    ],
  );
  final manufactureYearValidator = MultiValidator(
    [
      RequiredValidator(errorText: 'Enter your ManufactureYear'),
    ],
  );
  //icon car
  Widget buildButton() => FloatingActionButton(
        backgroundColor: MyStyle().buttongreen,
        child: const Icon(
          Icons.directions_car,
          size: 30,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Container(
                  height: 600,
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 30),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'เพิ่มรายการรถ',
                              style: MyStyle().blueHeaderStyle(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('รูปภาพประกอบ'),
                                Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: new InkWell(
                                      onTap: () async {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pushNamed('/camera');
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                50, 15, 50, 15),
                                            child: Column(
                                              children: [
                                                Icon(
                                                  Icons.camera_alt,
                                                  size: 80,
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          FormBuilder(
                            key: _fbKey,
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('รหัสรายการรถ'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: itemCode,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'รหัสรายการรถ',
                                        ),
                                        validator: itemCodeValidator,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('ยี่ห้อ'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: brandNameEng,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'brandNameEng',
                                        ),
                                        validator: brandNameEngValidator,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('รุ่น'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                          controller: modelName,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'ModelName',
                                          ),
                                          validator: modelNameValidator),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('สี'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: color,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Color',
                                        ),
                                        validator: colorValidator,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('ทะเบียนรถ'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: licensePlateNo,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'LicensePlateNo',
                                        ),
                                        validator: licensePlateNoValidator,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('ปีผลิต'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: manufactureYear,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'ManufactureYear',
                                        ),
                                        validator: manufactureYearValidator,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('รูปเล่มทะเบียนรถ'),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: new InkWell(
                                    onTap: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pushNamed('/camera');
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              50, 15, 50, 15),
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.camera_alt,
                                                size: 80,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: MaterialButton(
                                    height: 50,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    color: MyStyle().buttongray,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      Navigator.pop(context, '/detail');
                                    },
                                    child: Text(
                                      'ยกเลิก',
                                      style: MyStyle().whiteStyle(),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: MaterialButton(
                                    height: 50,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    color: MyStyle().buttongreen,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      if (_fbKey.currentState!
                                          .saveAndValidate()) {
                                        _requestItemWithUser();
                                      }
                                    },
                                    child: Text(
                                      'ยืนยัน',
                                      style: MyStyle().whiteStyle(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );

  // button นำส่ง
  Widget buttonWaitingCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        minWidth: 360,
        height: 50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        color: MyStyle().buttonblue,
        child: Text(
          'นำส่ง',
          style: MyStyle().whiteStyle(),
        ),
        onPressed: () => {
          Navigator.pushNamed(
            context,
            '/evidence-car',
            arguments: {
              'RequestID': RequestID,
              'RequestStatus': requestDetail.requestStatus
            },
          )
        },
      ),
    );
  }
}
