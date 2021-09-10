import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterappleman/constants/Mystyle.dart';
import 'package:flutterappleman/models/CardModel.dart';
import 'package:flutterappleman/models/CardRequestItemModel.dart';
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
  List<InRequestHome> homeCard = [];
  List<InRequestItemCard> itemCard = [];
  bool isLoading = true;
  late String wareHouseNameTha;
  var EventCalendar;
  var _RequestID;

  _getCalendarByDay() async {
    final url = Uri.parse(
        'https://apps.softsquaregroup.com/AAA.AppleMan.API/api/Requst/GetRequestByDay?calendarEventDay=' +
            EventCalendar.toString());
    //print(url);
    final http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      final CardModel home =
          CardModel.fromJson(convert.jsonDecode(response.body));

      if (this.mounted) {
        setState(() {
          homeCard = home.homeCard;
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

  _getDataCard() async {
    final url = Uri.parse(
        'https://apps.softsquaregroup.com/AAA.AppleMan.API/api/RequestItem/GetRequestItem');
    //print(url);
    final http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      final CardRequestItem home =
          CardRequestItem.fromJson(convert.jsonDecode(response.body));

      if (this.mounted) {
        setState(() {
          itemCard = home.itemCard;
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
      _getDataCard();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _getCalendarByDay();
    _getDataCard();
  }

  //input การรับงานไม่รับงาน
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final Description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final z = new DateFormat('dd/MM/yyyy');
    final f = new DateFormat('hh:mm');
    Map eventCalendarDate = ModalRoute.of(context)!.settings.arguments as Map;

    late String _fromLongitude = ("${eventCalendarDate['EventCalendar']}");
    late String _requestID = ("${eventCalendarDate['RequestID']}");
    EventCalendar = _fromLongitude;
    _RequestID = _requestID;
    _getCalendarByDay();
    //print(_RequestID);

    // //validator
    // final descriptionValidator = MultiValidator([
    //   RequiredValidator(errorText: 'Enter your Description'),
    // ]);

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
          : new ListView.separated(
              itemCount: homeCard.length,
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemBuilder: (BuildContext context, int index) {
                return Column(children: [
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
                                    MaterialButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      color: MyStyle().greenColor,
                                      child: Text(homeCard[index].requestStatus,
                                          style: MyStyle().whiteStyle()),
                                      onPressed: () {},
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
                                      left: MediaQuery.of(context).size.width *
                                          0.05,
                                      right: MediaQuery.of(context).size.width *
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
                                          Text(homeCard[index].sellerName)
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
                                        children: [Text('นางณัฐพร พลอยไพริน')],
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
                                        Text(z.format(homeCard[index]
                                            .startEffectiveDate)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.watch_later),
                                        SizedBox(width: 10),
                                        Text(f.format(homeCard[index]
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
                                        '${homeCard[index].amount.toString()} คัน')
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
                                    'หมายเหตุ : ${homeCard[index].remark.toString()} น.'),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.05,
                                    right: MediaQuery.of(context).size.width *
                                        0.05,
                                    top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        Text(homeCard[index].locationNameTha)
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
                                                      homeCard[index].requestId,
                                                  'locationNameTha':
                                                      homeCard[index]
                                                          .locationNameTha,
                                                  'locationNameEng':
                                                      homeCard[index]
                                                          .locationNameEng,
                                                  //location
                                                  'fromLatitude':
                                                      homeCard[index]
                                                          .fromLatitude,
                                                  'fromLongitude':
                                                      homeCard[index]
                                                          .fromLongitude
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
                                        Text('แผนที่.jpg')
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
                                          Text(homeCard[index].wareHouseNameTha)
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
                                                    'requestId': homeCard[index]
                                                        .requestId,
                                                    'wareHouseNameTha':
                                                        homeCard[index]
                                                            .wareHouseNameTha,
                                                    'wareHouseNameEng':
                                                        homeCard[index]
                                                            .wareHouseNameEng,
                                                    //location
                                                    'toLatitude':
                                                        homeCard[index]
                                                            .toLatitude,
                                                    'toLongitude':
                                                        homeCard[index]
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

                  //card requestItem
                  // Container(
                  //     margin: EdgeInsets.only(
                  //         left: MediaQuery.of(context).size.width * 0.05,
                  //         right: MediaQuery.of(context).size.width * 0.05,
                  //         top: 20),
                  //     child: Card(
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(10)),
                  //         child: Column(
                  //           children: [
                  //             Container(
                  //               margin: EdgeInsets.only(
                  //                 left:
                  //                     MediaQuery.of(context).size.width * 0.05,
                  //                 right:
                  //                     MediaQuery.of(context).size.width * 0.05,
                  //               ),
                  //               child: Row(
                  //                 children: [
                  //                   Image.asset(
                  //                     'assets/images/car.jpg',
                  //                     height: 150,
                  //                     width: 150,
                  //                   ),
                  //                   SizedBox(width: 30),
                  //                   Column(
                  //                       crossAxisAlignment:
                  //                           CrossAxisAlignment.start,
                  //                       children: [
                  //                         Text(itemCard[index].brandNameTha),
                  //                         Text(itemCard[index].brandNameEng),
                  //                         Text(itemCard[index].modelName),
                  //                         Text(itemCard[index].color),
                  //                         Text(itemCard[index].licensePlateNo),
                  //                       ]),
                  //                 ],
                  //               ),
                  //             )
                  //           ],
                  //         ))),

                  //ไม่รับงาน
                  Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [buttonDeny(), buttonConfirm()]),
                  )
                ]);
              }),
    );
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
            onPressed: () => _workConfirm()));
  }
}
