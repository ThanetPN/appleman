import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterappleman/constants/Mystyle.dart';
import 'package:flutterappleman/models/RequestDetailModel.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class MyChoice {
  String choices;
  int index;
  MyChoice({
    required this.index,
    required this.choices,
  });
}

class AddMember extends StatefulWidget {
  AddMember({Key? key}) : super(key: key);

  @override
  _AddMemberState createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  List<RequestTeamMember> requestTeamMembers = [];
  List _selectedTeam = [];
  var RequestID;

  _getData() async {
    var url = Uri.parse(
        'https://apps.softsquaregroup.com/AAA.AppleMan.API/api/Requst/GetRequestDetail?RequestID=${RequestID.toString()}');
    final http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      final RequestDetailModel detail =
          RequestDetailModel.fromJson(convert.jsonDecode(response.body));
      if (mounted) {
        setState(() {
          this.requestTeamMembers = detail.data!.requestTeamMembers!;
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

  onTeamMenberSelected(bool selected, driverCode) {
    if (selected == true) {
      setState(() {
        _selectedTeam.add(driverCode);
      });
    } else {
      setState(() {
        _selectedTeam.remove(driverCode);
      });
    }
    print(_selectedTeam);
  }

  _addMember() async {
    var TeamMemberArr = [];
    var TeamMembers = jsonEncode(requestTeamMembers);
    var RawDataTeamMembers = convert.jsonDecode(TeamMembers);
    for (var i = 0; i < _selectedTeam.length; i++) {
      // print(RawDataTeamMembers[i]['driverCode']);
      print(RawDataTeamMembers.firstWhere(
          (item) => item['driverCode'] == _selectedTeam[i]));
      if (RawDataTeamMembers.firstWhere(
              (item) => item['driverCode'] == _selectedTeam[i]) !=
          '') {
        TeamMemberArr.add(RawDataTeamMembers.firstWhere(
            (item) => item['driverCode'] == _selectedTeam[i]));
      }
    }

    print(TeamMemberArr);
    /*var url = Uri.parse(
        'https://apps.softsquaregroup.com/AAA.AppleMan.API/api/RequestItem/RequestItemWithUser');
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode(TeamMemberArr),
    );
    if (response.statusCode == 500) {
      Alert(
        context: context,
        type: AlertType.success,
        title: "Succeed",
        desc: "เพิ่มสมาชิกสำเร็จ",
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
    }*/
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    Map eventCalendarDate = ModalRoute.of(context)!.settings.arguments as Map;
    late String _requestID = ("${eventCalendarDate['RequestID']}");
    RequestID = _requestID;
    _getData();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add Member',
          style: MyStyle().whiteTitleStyle(),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: requestTeamMembers.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        CheckboxListTile(
                          title:
                              Text('${requestTeamMembers[index].driverCode}'),
                          value: _selectedTeam
                              .contains(requestTeamMembers[index].driverCode),
                          activeColor: Colors.pink,
                          checkColor: Colors.white,
                          onChanged: (bool? selected) {
                            onTeamMenberSelected(
                              selected!,
                              requestTeamMembers[index].driverCode,
                            );
                          },
                        )
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      height: 50,
                      minWidth: 150,
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
                      height: 50,
                      minWidth: 150,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      color: MyStyle().buttongreen,
                      textColor: Colors.white,
                      onPressed: () {
                        print('เพิ่มสมาชิก');
                        _addMember();
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
      ),
    );
  }
}
