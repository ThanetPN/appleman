import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutterappleman/constants/Mystyle.dart';
import 'package:signature/signature.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class EvidenceCar extends StatefulWidget {
  EvidenceCar({Key? key}) : super(key: key);

  @override
  _EvidenceCarState createState() => _EvidenceCarState();
}

class _EvidenceCarState extends State<EvidenceCar> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.red,
    exportBackgroundColor: Colors.blue,
  );
  bool isLoading = false;
  var RequestID;
  var RequestStatus;

  _workConfirmWaitingCar() async {
    final url = Uri.parse(
        'https://apps.softsquaregroup.com/AAA.AppleMan.API/api/Requst/UpdateRequestStatus');
    final http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode(
        {
          "RequestStatus": "รอนำส่งรถ",
          "RequestID": RequestID,
          "Description": 'null',
        },
      ),
    );
    if (response.statusCode == 200) {
      setState(() {
        isLoading = true;
      });
      //print(response.body);
      //ไปหน้า calendar
      Navigator.pushNamed(
        context,
        '/detail',
        arguments: {'RequestID': RequestID, 'RequestStatus': RequestStatus},
      );
    } else {
      setState(
        () {
          isLoading = false;
        },
      );
      var feedback = convert.jsonDecode(response.body);
      Flushbar(
        title: '${feedback['errorMessages']}',
        message: 'เกิดข้อผิดพลาดจากระบบ ${feedback['isSuccess']}',
        backgroundColor: MyStyle().redyColor,
        icon: Icon(
          Icons.error,
          size: 28.0,
          color: Colors.white,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.redAccent,
      )..show(context);
    }
  }

  _workConfirmr() async {
    final url = Uri.parse(
        'https://apps.softsquaregroup.com/AAA.AppleMan.API/api/Requst/UpdateRequestStatus');
    final http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode(
        {
          "RequestStatus": "เสร็จสิ้น",
          "RequestID": RequestID,
          "Description": 'null',
        },
      ),
    );
    if (response.statusCode == 200) {
      setState(
        () {
          isLoading = true;
        },
      );
      //print(response.body);
      //ไปหน้า calendar
      Navigator.pushNamed(
        context,
        '/detail',
        arguments: {'RequestID': RequestID, 'RequestStatus': RequestStatus},
      );
    } else {
      setState(
        () {
          isLoading = false;
        },
      );
      var feedback = convert.jsonDecode(response.body);
      Flushbar(
        title: '${feedback['errorMessages']}',
        message: 'เกิดข้อผิดพลาดจากระบบ ${feedback['isSuccess']}',
        backgroundColor: MyStyle().redyColor,
        icon: Icon(
          Icons.error,
          size: 28.0,
          color: Colors.white,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.redAccent,
      )..show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    //get arguments
    Map eventCalendarDate = ModalRoute.of(context)!.settings.arguments as Map;
    late String _requestID = ("${eventCalendarDate['RequestID']}");
    late String _requestStatus = ("${eventCalendarDate['RequestStatus']}");
    RequestID = _requestID;
    RequestStatus = _requestStatus;
    //print(RequestStatus);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('หลักฐานการส่งมอบ', style: MyStyle().whiteTitleStyle()),
      ),
      backgroundColor: MyStyle().garyAllColor,
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
              top: 30,
              bottom: 30,
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05,
                      top: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'เอกสารที่เกี่ยวกับผู้ขาย',
                          style: MyStyle().garyStyle(),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.add_circle,
                          ),
                          iconSize: 30,
                          color: MyStyle().buttongreen,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  child: Container(
                                    height: 600,
                                    child: ListView(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.05,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.05,
                                                  top: 30),
                                              child: Text(
                                                'เอกสารแนบ',
                                                style: MyStyle().redStyle(),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.05,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.05,
                                                  top: 30),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Card(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Icon(
                                                        Icons.attach_file,
                                                        color: Colors.grey,
                                                        size: 50,
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text('หนังสือมอบอำนาจ',
                                                          style: MyStyle()
                                                              .garyStyle()),
                                                      Text('ขนาดไฟล์ 0.0 MB')
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.05,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.05,
                                                  top: 30),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Card(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Icon(
                                                        Icons.attach_file,
                                                        color: Colors.grey,
                                                        size: 50,
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'ทะเบียนรถ',
                                                        style: MyStyle()
                                                            .garyStyle(),
                                                      ),
                                                      Text('ขนาดไฟล์ 0.0 MB')
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.05,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.05,
                                                  top: 30),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Card(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Icon(
                                                        Icons.attach_file,
                                                        color: Colors.grey,
                                                        size: 50,
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          'บัตรประจำตัวประชาชน',
                                                          style: MyStyle()
                                                              .garyStyle()),
                                                      Text('ขนาดไฟล์ 0.0 MB')
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.05,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.05,
                                                  top: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Card(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Icon(
                                                        Icons.attach_file,
                                                        color: Colors.grey,
                                                        size: 50,
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text('เอกสารยืนยันตัวตน',
                                                          style: MyStyle()
                                                              .garyStyle()),
                                                      Text('ขนาดไฟล์ 0.0 MB')
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  height: 50,
                                                  margin: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.05,
                                                    right:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.05,
                                                    top: 30,
                                                  ),
                                                  child: MaterialButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(5),
                                                      ),
                                                    ),
                                                    color: Color(0xFFD8D8D8),
                                                    textColor: Colors.white,
                                                    onPressed: () {
                                                      Navigator.pushNamed(
                                                          context, '');
                                                    },
                                                    child: Text(
                                                      'ยกเลิก',
                                                      style: MyStyle()
                                                          .whiteStyle(),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: 50,
                                                  margin: EdgeInsets.only(
                                                      left:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.05,
                                                      right:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.05,
                                                      top: 30),
                                                  child: MaterialButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(5),
                                                      ),
                                                    ),
                                                    color: Color(0xFF82DD55),
                                                    textColor: Colors.white,
                                                    onPressed: () {
                                                      Navigator.pushNamed(
                                                          context, '');
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
                      ],
                    ),
                  ),
                  SizedBox(
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
                  Container(
                    margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05,
                      bottom: 10,
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05,
                            top: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'บัตรประชาชน',
                                style: MyStyle().garyStyle(),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.image),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          primary: Color(0xFF4A90E2),
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(context, '/');
                                        },
                                        child: Text('รูปหน้าโกดังลาดพร้าว.jpg'),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.delete,
                                        color: MyStyle().redyColor,
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          //card requestItem WaitingCar
          Container(
            child: RequestStatus == 'รอดำเนินการ'
                ? Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05,
                        top: 20,
                        bottom: 20),
                    child: MaterialButton(
                      height: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      color: MyStyle().buttonblue,
                      child: Text(
                        'ยืนยันการรับมอบรถ',
                        style: MyStyle().whiteStyle(),
                      ),
                      onPressed: () => _workConfirmWaitingCar(),
                    ),
                  )
                : errorA(),
          ),
          Container(
            child: RequestStatus == 'รอนำส่งรถ'
                ? Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05,
                        top: 20,
                        bottom: 20),
                    child: MaterialButton(
                      height: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      color: MyStyle().buttonblue,
                      child: Text(
                        'ยืนยันการส่งรถปลายทาง',
                        style: MyStyle().whiteStyle(),
                      ),
                      onPressed: () => _workConfirmr(),
                    ),
                  )
                : errorA(),
          ),
        ],
      ),
    );
  }

  Widget errorA() {
    return Container(
      child: Text(''),
    );
  }
}
