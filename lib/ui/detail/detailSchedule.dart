import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterappleman/constants/Mystyle.dart';
import 'package:flutterappleman/models/RequestDetailModel.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DetailSchedule extends StatefulWidget {
  DetailSchedule({Key? key}) : super(key: key);

  @override
  _DetailScheduleState createState() => _DetailScheduleState();
}

class _DetailScheduleState extends State<DetailSchedule> {
  late RequestDetail requestDetail = requestDetail;
  List<RequestItem> requestItems = [];
  List<RequestTeamMember> requestTeamMembers = [];
  bool isLoading = true;
  late String wareHouseNameTha;
  //var EventCalendar;
  var _RequestID;

  _getDetail() async {
    final url = Uri.parse(
        'https://apps.softsquaregroup.com/AAA.AppleMan.API/api/Requst/GetRequestDetail?RequestID=' +
            _RequestID.toString());
    //print(url);
    final http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      final RequestDetailModel detail =
          RequestDetailModel.fromJson(convert.jsonDecode(response.body));

      if (this.mounted) {
        setState(() {
          requestDetail = detail.data.requestDetail;
          requestItems = detail.data.requestItems;
          requestTeamMembers = detail.data.requestTeamMembers;
          isLoading = false;
        });
      }
      //print(response.body);
    } else {
      Flushbar(
        title: 'เกิดข้อผิดพลาด',
        message: 'error from backend ${response.statusCode}',
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

  _work() async {
    final url = Uri.parse(
        'https://apps.softsquaregroup.com/AAA.AppleMan.API/api/Requst/UpdateRequestStatus');
    //print(url);
    final http.Response response = await http.post(url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: convert.jsonEncode({
          "RequestStatus": "Draft",
          "RequestID": _RequestID,
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
      setState(() {
        isLoading = false;
      });
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

  _workConfirm() async {
    final url = Uri.parse(
        'https://apps.softsquaregroup.com/AAA.AppleMan.API/api/Requst/UpdateRequestStatus');
    final http.Response response = await http.post(url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: convert.jsonEncode({
          "RequestStatus": "Pending",
          "RequestID": _RequestID,
          "Description": 'null',
        }));
    if (response.statusCode == 200) {
      setState(() {
        isLoading = true;
      });
      //print(response.body);
      //ไปหน้า calendar
      // Navigator.pushNamedAndRemoveUntil(
      //     context, '/detail', (Route<dynamic> route) => false);
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pop(context);
      });
    } else {
      setState(() {
        isLoading = false;
      });
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
  void initState() {
    if (mounted) {
      super.initState();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _getDetail();
  }

  //input การรับงานไม่รับงาน
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final Description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final z = new DateFormat('dd/MM/yyyy');
    final f = new DateFormat('hh:mm');
    Map eventCalendarDate = ModalRoute.of(context)!.settings.arguments as Map;

    // late String _fromLongitude = ("${eventCalendarDate['EventCalendar']}");
    late String _requestID = ("${eventCalendarDate['RequestID']}");
    late String _requestStatus = ("${eventCalendarDate['RequestStatus']}");
    // EventCalendar = _fromLongitude;
    _RequestID = _requestID;
    _getDetail();
    //print(_RequestID);

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
                  Column(children: [
                    Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05,
                            top: 30),
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.05,
                                      right: MediaQuery.of(context).size.width *
                                          0.05,
                                      top: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('รายละเอียดงาน',
                                          style: MyStyle().blueHeaderStyle()),
                                      Row(
                                        children: [
                                          Container(
                                            child: requestDetail
                                                        .requestStatus ==
                                                    'Draft'
                                                ? MaterialButton(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5))),
                                                    color:
                                                        MyStyle().garyssColor,
                                                    child: Text(
                                                        requestDetail
                                                            .requestStatus,
                                                        style: MyStyle()
                                                            .whiteStyle()),
                                                    onPressed: () {},
                                                  )
                                                : errorA(),
                                          ),
                                          Container(
                                            child: requestDetail
                                                        .requestStatus ==
                                                    'Pending'
                                                ? MaterialButton(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5))),
                                                    color:
                                                        MyStyle().yellowColor,
                                                    child: Text(
                                                        requestDetail
                                                            .requestStatus,
                                                        style: MyStyle()
                                                            .whiteStyle()),
                                                    onPressed: () {},
                                                  )
                                                : errorA(),
                                          ),
                                          Container(
                                            child: requestDetail
                                                        .requestStatus ==
                                                    'waiting'
                                                ? MaterialButton(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5))),
                                                    color:
                                                        MyStyle().yellowColor,
                                                    child: Text(
                                                        requestDetail
                                                            .requestStatus,
                                                        style: MyStyle()
                                                            .whiteStyle()),
                                                    onPressed: () {},
                                                  )
                                                : errorA(),
                                          ),
                                          Container(
                                            child: requestDetail
                                                        .requestStatus ==
                                                    'Finish'
                                                ? MaterialButton(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5))),
                                                    color: MyStyle().greenColor,
                                                    child: Text(
                                                        requestDetail
                                                            .requestStatus,
                                                        style: MyStyle()
                                                            .whiteStyle()),
                                                    onPressed: () {},
                                                  )
                                                : errorA(),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: Colors.black,
                                  thickness: 1,
                                ),
                                Container(
                                    margin: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        top: 10),
                                    child: Text('ผู้ขาย',
                                        style: MyStyle().blueStyle())),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.05,
                                      right: MediaQuery.of(context).size.width *
                                          0.05,
                                      top: 10),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          children: [
                                            Text(requestDetail.sellerName)
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.call),
                                            SizedBox(width: 10),
                                            Text('081-1234564')
                                          ],
                                        )
                                      ]),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.05,
                                      right: MediaQuery.of(context).size.width *
                                          0.05,
                                      top: 10),
                                  child: Text('ผู้ติดต่อ',
                                      style: MyStyle().blueStyle()),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.05,
                                      right: MediaQuery.of(context).size.width *
                                          0.05,
                                      top: 10),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          children: [
                                            Text('นางณัฐพร พลอยไพริน')
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.call),
                                            SizedBox(width: 10),
                                            Text('081-1234562')
                                          ],
                                        )
                                      ]),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.05,
                                      right: MediaQuery.of(context).size.width *
                                          0.05,
                                      top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.calendar_today),
                                          SizedBox(width: 10),
                                          Text(z.format(requestDetail
                                              .startEffectiveDate)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.watch_later),
                                          SizedBox(width: 10),
                                          Text(f.format(requestDetail
                                              .startEffectiveDate)),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.05,
                                      right: MediaQuery.of(context).size.width *
                                          0.05,
                                      top: 10),
                                  child: Row(
                                    children: [
                                      Icon(Icons.directions_car),
                                      SizedBox(width: 10),
                                      Text(
                                          '${requestDetail.amount.toString()} คัน')
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.05,
                                      right: MediaQuery.of(context).size.width *
                                          0.05,
                                      top: 10),
                                  child: Text(
                                      'หมายเหตุ : ${requestDetail.remark.toString()} น.'),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.05,
                                      right: MediaQuery.of(context).size.width *
                                          0.05,
                                      top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('สถานที่รับรถ',
                                          style: MyStyle().blueStyle()),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: Colors.red,
                                          ),
                                          SizedBox(width: 10),
                                          Text(requestDetail.locationNameTha)
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
                                                  context, '/pickUpLocation',
                                                  arguments: {
                                                    'requestId':
                                                        requestDetail.requestId,
                                                    'locationNameTha':
                                                        requestDetail
                                                            .locationNameTha,
                                                    'locationNameEng':
                                                        requestDetail
                                                            .locationNameEng,
                                                    //location
                                                    'fromLatitude':
                                                        requestDetail
                                                            .fromLatitude,
                                                    'fromLongitude':
                                                        requestDetail
                                                            .fromLongitude
                                                  });
                                            },
                                            child:
                                                const Text('เปิด Google Map'),
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
                                Container(
                                    margin: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        top: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('สถานที่ส่ง',
                                            style: MyStyle().blueStyle()),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color: Colors.red,
                                            ),
                                            SizedBox(width: 10),
                                            Text(requestDetail.wareHouseNameTha)
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
                                                      'requestId': requestDetail
                                                          .requestId,
                                                      'wareHouseNameTha':
                                                          requestDetail
                                                              .wareHouseNameTha,
                                                      'wareHouseNameEng':
                                                          requestDetail
                                                              .wareHouseNameEng,
                                                      //location
                                                      'toLatitude':
                                                          requestDetail
                                                              .toLatitude,
                                                      'toLongitude':
                                                          requestDetail
                                                              .toLongitude
                                                    }); //Link go to map
                                              },
                                              child:
                                                  const Text('เปิด Google Map'),
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
                                            Text('แผนที่.jpg')
                                          ],
                                        )
                                      ],
                                    )),
                                SizedBox(height: 30)
                              ],
                            ))),

                    //Add Teams
                    Container(
                      child: requestDetail.requestStatus == 'Pending'
                          ? cardAA()
                          : errorA(),
                    ),

                    //card requestItem Draft
                    Container(
                      child: requestDetail.requestStatus == 'Draft'
                          ? draftAA()
                          : errorA(),
                    ),

                    //card requestItem Pending
                    Container(
                      child: requestDetail.requestStatus == 'Pending'
                          ? pendingAA()
                          : errorA(),
                    ),

                    //card requestItem การเพิ่มรายการรับรถ Pending
                    Container(
                      child: requestDetail.requestStatus == 'Pending'
                          ? insertAddCarCard()
                          : errorA(),
                    ),

                    //ไม่รับงาน
                    Container(
                      child: requestDetail.requestStatus == 'Draft'
                          ? Container(
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.05,
                                  right:
                                      MediaQuery.of(context).size.width * 0.05),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [buttonDeny(), buttonConfirm()]),
                            )
                          : errorA(),
                    ),

                    //ยกเลิกงาน
                    Container(
                      child: requestDetail.requestStatus == 'Pending'
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
                                    buttonConfirmCar()
                                  ]),
                            )
                          : errorA(),
                    ),
                  ])
                ],
              )

        //iconcar
        // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        // floatingActionButton: Container(
        //   child: _requestStatus == 'Pending' ? buildButton() : errorA(),
        // ),
        );
  }

  //items Card == Draft
  Widget draftAA() {
    return Column(
        children: requestItems
            .map((e) => Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width * 0.05,
                    top: 10),
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05,
                          ),
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
                                    Text(e.brandNameTha),
                                    Text(e.brandNameEng),
                                    Text(e.modelName),
                                    Text(e.color),
                                    Text(e.licensePlateNo),
                                  ]),
                            ],
                          ),
                        )
                      ],
                    ))))
            .toList());
  }

  //items Card == Pending
  Widget pendingAA() {
    return Column(
        children: requestItems
            .map((e) => Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width * 0.05,
                    top: 10),
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(e.brandNameTha),
                                        Text(e.brandNameEng),
                                        Text(e.modelName),
                                        Text(e.color),
                                        Text(e.licensePlateNo),
                                      ]),
                                ],
                              ),
                              Icon(Icons.block, color: MyStyle().redyColor)
                            ],
                          ),
                        )
                      ],
                    ))))
            .toList());
  }

  //card requestItem การเพิ่มรายการรับรถ Pending
  Widget insertAddCarCard() {
    return Column(
        children: requestItems
            .map((e) => Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width * 0.05,
                    top: 10),
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(e.brandNameTha),
                                        Text(e.brandNameEng),
                                        Text(e.modelName),
                                        Text(e.color),
                                        Text(e.licensePlateNo),
                                      ]),
                                ],
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
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: Container(
                                                  height: 600,
                                                  child: ListView(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 30),
                                                      ),
                                                      Column(
                                                        children: [
                                                          Container(
                                                            margin: EdgeInsets.only(
                                                                left: MediaQuery
                                                                            .of(
                                                                                context)
                                                                        .size
                                                                        .width *
                                                                    0.05,
                                                                right: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.05,
                                                                top: 10),
                                                            child: Text(
                                                              'เพิ่มรายการรถ',
                                                              style: MyStyle()
                                                                  .blueHeaderStyle(),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin: EdgeInsets.only(
                                                                left: MediaQuery
                                                                            .of(
                                                                                context)
                                                                        .size
                                                                        .width *
                                                                    0.05,
                                                                right: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.05,
                                                                top: 10),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Text(
                                                                    'รูปภาพประกอบ'),
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5),
                                                                  child: Card(
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              10)),
                                                                      child:
                                                                          new InkWell(
                                                                        onTap:
                                                                            () async {
                                                                          Navigator.of(context, rootNavigator: true)
                                                                              .pushNamed('/camera');
                                                                        },
                                                                        child:
                                                                            Column(
                                                                          children: <
                                                                              Widget>[
                                                                            Padding(
                                                                                padding: const EdgeInsets.fromLTRB(50, 15, 50, 15),
                                                                                child: Column(
                                                                                  children: [
                                                                                    Icon(
                                                                                      Icons.camera_alt,
                                                                                      size: 80,
                                                                                    )
                                                                                  ],
                                                                                )),
                                                                          ],
                                                                        ),
                                                                      )),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          FormBuilder(
                                                              child: Column(
                                                            children: [
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        left: MediaQuery.of(context).size.width *
                                                                            0.05,
                                                                        right: MediaQuery.of(context).size.width *
                                                                            0.05,
                                                                        top:
                                                                            10),
                                                                    child: Text(
                                                                        'ยี่ห้อ'),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        left: MediaQuery.of(context).size.width *
                                                                            0.05,
                                                                        right: MediaQuery.of(context).size.width *
                                                                            0.05,
                                                                        top:
                                                                            10),
                                                                    child:
                                                                        TextFormField(
                                                                      //controller: password,
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .visiblePassword,
                                                                      obscureText:
                                                                          true,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        border:
                                                                            OutlineInputBorder(),
                                                                        labelText:
                                                                            'Password',
                                                                      ),
                                                                      //validator: passwordValidator
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        left: MediaQuery.of(context).size.width *
                                                                            0.05,
                                                                        right: MediaQuery.of(context).size.width *
                                                                            0.05,
                                                                        top:
                                                                            10),
                                                                    child: Text(
                                                                        'รุ่น'),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        left: MediaQuery.of(context).size.width *
                                                                            0.05,
                                                                        right: MediaQuery.of(context).size.width *
                                                                            0.05,
                                                                        top:
                                                                            10),
                                                                    child:
                                                                        TextFormField(
                                                                      //controller: password,
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .visiblePassword,
                                                                      obscureText:
                                                                          true,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        border:
                                                                            OutlineInputBorder(),
                                                                        labelText:
                                                                            'Password',
                                                                      ),
                                                                      //validator: passwordValidator
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        left: MediaQuery.of(context).size.width *
                                                                            0.05,
                                                                        right: MediaQuery.of(context).size.width *
                                                                            0.05,
                                                                        top:
                                                                            10),
                                                                    child: Text(
                                                                        'สี'),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        left: MediaQuery.of(context).size.width *
                                                                            0.05,
                                                                        right: MediaQuery.of(context).size.width *
                                                                            0.05,
                                                                        top:
                                                                            10),
                                                                    child:
                                                                        TextFormField(
                                                                      //controller: password,
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .visiblePassword,
                                                                      obscureText:
                                                                          true,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        border:
                                                                            OutlineInputBorder(),
                                                                        labelText:
                                                                            'Password',
                                                                      ),
                                                                      //validator: passwordValidator
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        left: MediaQuery.of(context).size.width *
                                                                            0.05,
                                                                        right: MediaQuery.of(context).size.width *
                                                                            0.05,
                                                                        top:
                                                                            10),
                                                                    child: Text(
                                                                        'ทะเบียน'),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        left: MediaQuery.of(context).size.width *
                                                                            0.05,
                                                                        right: MediaQuery.of(context).size.width *
                                                                            0.05,
                                                                        top:
                                                                            10),
                                                                    child:
                                                                        TextFormField(
                                                                      //controller: password,
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .visiblePassword,
                                                                      obscureText:
                                                                          true,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        border:
                                                                            OutlineInputBorder(),
                                                                        labelText:
                                                                            'Password',
                                                                      ),
                                                                      //validator: passwordValidator
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        left: MediaQuery.of(context).size.width *
                                                                            0.05,
                                                                        right: MediaQuery.of(context).size.width *
                                                                            0.05,
                                                                        top:
                                                                            10),
                                                                    child: Text(
                                                                        'ปีผลิต'),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        left: MediaQuery.of(context).size.width *
                                                                            0.05,
                                                                        right: MediaQuery.of(context).size.width *
                                                                            0.05,
                                                                        top:
                                                                            10),
                                                                    child:
                                                                        TextFormField(
                                                                      //controller: password,
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .visiblePassword,
                                                                      obscureText:
                                                                          true,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        border:
                                                                            OutlineInputBorder(),
                                                                        labelText:
                                                                            'Password',
                                                                      ),
                                                                      //validator: passwordValidator
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          )),
                                                          Container(
                                                            margin: EdgeInsets.only(
                                                                left: MediaQuery
                                                                            .of(
                                                                                context)
                                                                        .size
                                                                        .width *
                                                                    0.05,
                                                                right: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.05,
                                                                top: 10),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Text(
                                                                    'รูปเล่มทะเบียนรถ'),
                                                                Card(
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                10)),
                                                                    child:
                                                                        new InkWell(
                                                                      onTap:
                                                                          () {},
                                                                      child:
                                                                          Column(
                                                                        children: <
                                                                            Widget>[
                                                                          Padding(
                                                                              padding: const EdgeInsets.fromLTRB(50, 15, 50, 15),
                                                                              child: Column(
                                                                                children: [
                                                                                  Icon(
                                                                                    Icons.camera_alt,
                                                                                    size: 80,
                                                                                  )
                                                                                ],
                                                                              )),
                                                                        ],
                                                                      ),
                                                                    )),
                                                              ],
                                                            ),
                                                          ),
                                                          Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                Container(
                                                                    height: 50,
                                                                    margin: EdgeInsets.only(
                                                                        left: MediaQuery.of(context).size.width *
                                                                            0.05,
                                                                        right: MediaQuery.of(context).size.width *
                                                                            0.05,
                                                                        top:
                                                                            30),
                                                                    child:
                                                                        MaterialButton(
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(5))),
                                                                      color: Color(
                                                                          0xFFD8D8D8),
                                                                      textColor:
                                                                          Colors
                                                                              .white,
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pushNamed(
                                                                            context,
                                                                            '');
                                                                      },
                                                                      child: Text(
                                                                          'ยกเลิก',
                                                                          style:
                                                                              MyStyle().whiteStyle()),
                                                                    )),
                                                                Container(
                                                                    height: 50,
                                                                    margin: EdgeInsets.only(
                                                                        left: MediaQuery.of(context).size.width *
                                                                            0.05,
                                                                        right: MediaQuery.of(context).size.width *
                                                                            0.05,
                                                                        top:
                                                                            30),
                                                                    child:
                                                                        MaterialButton(
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(5))),
                                                                      color: Color(
                                                                          0xFF82DD55),
                                                                      textColor:
                                                                          Colors
                                                                              .white,
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pushNamed(
                                                                            context,
                                                                            '');
                                                                      },
                                                                      child: Text(
                                                                          'ยืนยัน',
                                                                          style:
                                                                              MyStyle().whiteStyle()),
                                                                    )),
                                                              ]),
                                                          SizedBox(height: 20)
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ));
                                          });
                                    },
                                  ),
                                  SizedBox(width: 10),
                                  Icon(Icons.delete,
                                      color: MyStyle().redyColor),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ))))
            .toList());
  }

  //button ปัฎิเสธ
  Widget buttonDeny() {
    final descriptionValidator = MultiValidator([
      RequiredValidator(errorText: 'Enter your Description'),
    ]);
    return Container(
        height: 50,
        margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
            top: 20,
            bottom: 20),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          color: MyStyle().redyColor,
          textColor: Colors.white,
          child: Text('ไม่รับงาน', style: MyStyle().whiteStyle()),
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
                                Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.05,
                                      right: MediaQuery.of(context).size.width *
                                          0.05,
                                      top: 30),
                                  child: Text('ไม่รับงาน',
                                      style: MyStyle().redStyle()),
                                ),
                              ],
                            ),
                            FormBuilder(
                              key: _fbKey,
                              initialValue: {'Description': ''},
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.05,
                                    right: MediaQuery.of(context).size.width *
                                        0.05,
                                    top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('เหตุผลไม่รับงาน',
                                        style: MyStyle().garyStyle()),
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
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                          top: 30,
                                          bottom: 30),
                                      child: MaterialButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        color: Color(0xFFD8D8D8),
                                        textColor: Colors.white,
                                        onPressed: () {
                                          Navigator.pop(context, '/detail');
                                        },
                                        child: Text('ยกเลิก',
                                            style: MyStyle().whiteStyle()),
                                      )),
                                  Container(
                                      height: 50,
                                      margin: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                          top: 30,
                                          bottom: 30),
                                      child: MaterialButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        color: Color(0xFF82DD55),
                                        textColor: Colors.white,
                                        onPressed: () {
                                          if (_fbKey.currentState!
                                              .saveAndValidate()) {
                                            _work();
                                          }
                                        },
                                        child: Text('ยืนยัน',
                                            style: MyStyle().whiteStyle()),
                                      )),
                                ]),
                          ],
                        )),
                  );
                });
          },
        ));
  }

  //button ยืนยันรับงาน
  Widget buttonConfirm() {
    return Container(
        height: 50,
        margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
            top: 20,
            bottom: 20),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          color: MyStyle().buttonblue, // background
          child: Text('ยืนยันรับงาน', style: MyStyle().whiteStyle()),
          onPressed: () => _workConfirm(),
        ));
  }

  Widget cardAA() {
    int _radioSelected = 1;
    String _radioVal;
    return Container(
        margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
            top: 20),
        child: Card(
          child: Container(
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05,
                top: 20,
                bottom: 20,
              ),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('ทีมงาน', style: MyStyle().blueStyle()),
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
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Container(
                                          height: 500,
                                          child: ListView(
                                            children: [
                                              Container(
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
                                                  child: Column(
                                                    children: [
                                                      Text('เพิ่มคนในทีม',
                                                          style: MyStyle()
                                                              .blueStyle()),
                                                      SizedBox(height: 20),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Radio(
                                                            value: 2,
                                                            groupValue:
                                                                _radioSelected,
                                                            activeColor:
                                                                Colors.pink,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                _radioSelected =
                                                                    1;
                                                                _radioVal =
                                                                    'female';
                                                              });
                                                            },
                                                          ),
                                                          CircleAvatar(
                                                            backgroundImage:
                                                                AssetImage(
                                                                    'assets/images/profile.jpg'),
                                                            radius: 20,
                                                          ),
                                                          Text('นายสมศรี มีชัย',
                                                              style: MyStyle()
                                                                  .garyStyle()),
                                                          Row(
                                                            children: [
                                                              Text('พนักงาน',
                                                                  style: MyStyle()
                                                                      .garyStyle())
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                              SizedBox(height: 30),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  MaterialButton(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5))),
                                                    color: MyStyle().buttongray,
                                                    child: Text('ยกเลิก',
                                                        style: MyStyle()
                                                            .whiteStyle()),
                                                    onPressed: () {},
                                                  ),
                                                  MaterialButton(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5))),
                                                    color:
                                                        MyStyle().buttongreen,
                                                    child: Text('เพิ่ม',
                                                        style: MyStyle()
                                                            .whiteStyle()),
                                                    onPressed: () {},
                                                  )
                                                ],
                                              )
                                            ],
                                          )),
                                    );
                                  });
                            }),
                      ]),
                  Divider(color: Colors.black, thickness: 1),
                  Column(
                      children: requestTeamMembers
                          .map(
                            (e) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text('นายยึดมั่น รักษาเกียรติ',
                                  //     style: MyStyle().garyStyle()),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(e.driverCode,
                                          style: MyStyle().garyStyle()),
                                      Icon(
                                        Icons.delete,
                                        color: MyStyle().redyColor,
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                ]),
                          )
                          .toList())
                ],
              )),
        ));
  }

  Widget errorA() {
    return Container(child: Text(''));
  }

  //button ปัฎิเสธ
  Widget buttonCancel() {
    final descriptionValidator = MultiValidator([
      RequiredValidator(errorText: 'Enter your Description'),
    ]);
    return Container(
        height: 50,
        margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
            top: 20,
            bottom: 20),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          color: MyStyle().redyColor,
          textColor: Colors.white,
          child: Text('ยกเลิกงาน', style: MyStyle().whiteStyle()),
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
                                Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.05,
                                      right: MediaQuery.of(context).size.width *
                                          0.05,
                                      top: 30),
                                  child: Text('ยกเลิกงาน',
                                      style: MyStyle().redStyle()),
                                ),
                              ],
                            ),
                            FormBuilder(
                              key: _fbKey,
                              initialValue: {'Description': ''},
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.05,
                                    right: MediaQuery.of(context).size.width *
                                        0.05,
                                    top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('เหตุผลยกเลิกงาน',
                                        style: MyStyle().garyStyle()),
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
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                          top: 30,
                                          bottom: 30),
                                      child: MaterialButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        color: Color(0xFFD8D8D8),
                                        textColor: Colors.white,
                                        onPressed: () {
                                          Navigator.pop(context, '/detail');
                                        },
                                        child: Text('ยกเลิก',
                                            style: MyStyle().whiteStyle()),
                                      )),
                                  Container(
                                      height: 50,
                                      margin: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                          top: 30,
                                          bottom: 30),
                                      child: MaterialButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        color: Color(0xFF82DD55),
                                        textColor: Colors.white,
                                        onPressed: () {
                                          if (_fbKey.currentState!
                                              .saveAndValidate()) {
                                            _work();
                                          }
                                        },
                                        child: Text('ยืนยัน',
                                            style: MyStyle().whiteStyle()),
                                      )),
                                ]),
                          ],
                        )),
                  );
                });
          },
        ));
  }

  //button ยืนยันรับงาน
  Widget buttonConfirmCar() {
    return Container(
        height: 50,
        margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
            top: 20,
            bottom: 20),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          color: MyStyle().buttonblue, // background
          child: Text('ยืนยันรับรถ', style: MyStyle().whiteStyle()),
          onPressed: () => {Navigator.pushNamed(context, '/evidence-car')},
        ));
  }

  //icon car
  Widget buildButton() => FloatingActionButton(
        backgroundColor: Color(0xFF82DD55),
        child: const Icon(
          Icons.directions_car,
          size: 30,
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
                      height: 500,
                      child: ListView(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 30),
                          ),
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.05,
                                    right: MediaQuery.of(context).size.width *
                                        0.05,
                                    top: 10),
                                child: Text(
                                  'เพิ่มรายการรถ',
                                  style: MyStyle().blueHeaderStyle(),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.05,
                                    right: MediaQuery.of(context).size.width *
                                        0.05,
                                    top: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('รูปภาพประกอบ'),
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: new InkWell(
                                            onTap: () async {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pushNamed('/camera');
                                            },
                                            child: Column(
                                              children: <Widget>[
                                                Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        50, 15, 50, 15),
                                                    child: Column(
                                                      children: [
                                                        Icon(
                                                          Icons.camera_alt,
                                                          size: 80,
                                                        )
                                                      ],
                                                    )),
                                              ],
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                              FormBuilder(
                                  child: Column(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            top: 10),
                                        child: Text('ยี่ห้อ'),
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
                                        child: TextFormField(
                                          //controller: password,
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Password',
                                          ),
                                          //validator: passwordValidator
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            top: 10),
                                        child: Text('รุ่น'),
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
                                        child: TextFormField(
                                          //controller: password,
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Password',
                                          ),
                                          //validator: passwordValidator
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            top: 10),
                                        child: Text('สี'),
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
                                        child: TextFormField(
                                          //controller: password,
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Password',
                                          ),
                                          //validator: passwordValidator
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            top: 10),
                                        child: Text('ทะเบียน'),
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
                                        child: TextFormField(
                                          //controller: password,
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Password',
                                          ),
                                          //validator: passwordValidator
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            top: 10),
                                        child: Text('ปีผลิต'),
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
                                        child: TextFormField(
                                          //controller: password,
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Password',
                                          ),
                                          //validator: passwordValidator
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                              Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.05,
                                    right: MediaQuery.of(context).size.width *
                                        0.05,
                                    top: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('รูปเล่มทะเบียนรถ'),
                                    Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: new InkWell(
                                          onTap: () {},
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          50, 15, 50, 15),
                                                  child: Column(
                                                    children: [
                                                      Icon(
                                                        Icons.camera_alt,
                                                        size: 80,
                                                      )
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        )),
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
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05,
                                            top: 30),
                                        child: MaterialButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          color: Color(0xFFD8D8D8),
                                          textColor: Colors.white,
                                          onPressed: () {
                                            Navigator.pushNamed(context, '');
                                          },
                                          child: Text('ยกเลิก',
                                              style: MyStyle().whiteStyle()),
                                        )),
                                    Container(
                                        height: 50,
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
                                        child: MaterialButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          color: Color(0xFF82DD55),
                                          textColor: Colors.white,
                                          onPressed: () {
                                            Navigator.pushNamed(context, '');
                                          },
                                          child: Text('ยืนยัน',
                                              style: MyStyle().whiteStyle()),
                                        )),
                                  ]),
                              SizedBox(height: 20)
                            ],
                          ),
                        ],
                      ),
                    ));
              });
        },
      );
}
