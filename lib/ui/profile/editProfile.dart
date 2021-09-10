import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterappleman/constants/Mystyle.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  bool isLoading = false;
  late SharedPreferences prefs;

  _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  _updateProfile(Map<String, dynamic> values) async {
    setState(() {
      isLoading = true;
    });
    // print(values);

    //get token
    var tokenString = prefs.getString('token');
    var token = convert.jsonDecode(tokenString!);

    final url = Uri.parse(
        'https://apps.softsquaregroup.com/AAA.AppleMan.Authen/api/Authentication');
    //print(url);
    final http.Response response = await http.post(url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: convert.jsonEncode(
            {'userCode': values['userCode'], 'username': values['username']}));

    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      //save token
      await prefs.setString('token', response.body);

      //save profile to prefs
      var profile = response.body;
      await _saveProfile(profile);

      //ไปหน้า calendar
      Navigator.pushNamed(context, '/navigationBar');
      Navigator.pushNamedAndRemoveUntil(
          context, '/profile', (Route<dynamic> route) => false);
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

  Future<void> _saveProfile(String profile) async {
    //save user profile to prefs
    var profileUpdate = convert.jsonDecode(profile);
    await prefs.setString('profile', convert.jsonEncode(profileUpdate));
  }

  @override
  Widget build(BuildContext context) {
    Map user = ModalRoute.of(context)!.settings.arguments as Map;

    final userNameValidator = MultiValidator([
      RequiredValidator(errorText: 'กรุณากรอกชื่อ-นามสกุล'),
    ]);
    final positionValidator = MultiValidator([
      RequiredValidator(errorText: 'กรุณากรอกตำแหน่ง'),
    ]);
    final telValidator = MultiValidator([
      RequiredValidator(errorText: 'กรุณากรอกข้อมูลติดต่อ'),
    ]);
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('EDIT PROFILE', style: MyStyle().whiteTitleStyle())),
      backgroundColor: MyStyle().garyAllColor,
      body: SingleChildScrollView(
          child: SafeArea(
              child: Padding(
                  padding: EdgeInsets.all(20),
                  child: FormBuilder(
                      key: _fbKey,
                      initialValue: {
                        'UserName': user['UserName'],
                        'DriverCode': user['DriverCode']
                      },
                      child: Card(
                          child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: AssetImage(
                                            'assets/images/profile.jpg'),
                                        radius: 40,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('ชื่อ-นามสกุล',
                                          style: MyStyle().blueStyle()),
                                      Container(
                                        margin: EdgeInsets.only(top: 16),
                                        child: FormBuilderTextField(
                                            name: "UserName",
                                            maxLines: 1,
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            decoration: InputDecoration(
                                                labelText: "",
                                                labelStyle: TextStyle(
                                                    color: Colors.black87),
                                                fillColor: Colors.white,
                                                filled: true,
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                errorStyle: TextStyle(
                                                    color: Colors.red)),
                                            validator: userNameValidator),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('ตำแหน่ง',
                                          style: MyStyle().blueStyle()),
                                      Container(
                                        margin: EdgeInsets.only(top: 16),
                                        child: FormBuilderTextField(
                                            name: "DriverCode",
                                            maxLines: 1,
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            decoration: InputDecoration(
                                                labelText: "",
                                                labelStyle: TextStyle(
                                                    color: Colors.black87),
                                                fillColor: Colors.white,
                                                filled: true,
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                errorStyle: TextStyle(
                                                    color: Colors.red)),
                                            validator: positionValidator),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('ข้อมูลการติดต่อ',
                                          style: MyStyle().blueStyle()),
                                      Container(
                                        margin: EdgeInsets.only(top: 16),
                                        child: FormBuilderTextField(
                                            name: "",
                                            maxLines: 1,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                                labelText: "",
                                                labelStyle: TextStyle(
                                                    color: Colors.black87),
                                                fillColor: Colors.white,
                                                filled: true,
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                errorStyle: TextStyle(
                                                    color: Colors.red)),
                                            validator: telValidator),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10)
                                ],
                              ))))))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Container(
                height: 50,
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width * 0.05,
                    top: 30),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  color: Color(0xFFD8D8D8),
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.pushNamed(context, '');
                  },
                  child: Text('ยกเลิก', style: MyStyle().whiteStyle()),
                )),
            Container(
                height: 50,
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width * 0.05,
                    top: 30),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  color: Color(0xFF82DD55),
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.pushNamed(context, '');
                  },
                  child: Text('ยืนยัน', style: MyStyle().whiteStyle()),
                )),
          ]),
        ],
      )),
    );
  }
}
