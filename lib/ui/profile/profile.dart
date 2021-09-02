import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterappleman/constants/Mystyle.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  Map<String, dynamic> profile = {
    'UserCode': '',
    'UserName': '',
    'DriverCode': ''
  };

  _getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var profileString = prefs.getString('profile');
    //print(profileString);
    if (profileString != null) {
      setState(() {
        profile = convert.jsonDecode(profileString);
      });
    }
  }

  _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('profile');
    Navigator.pushNamedAndRemoveUntil(
        context, '/login', (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  @override
  Widget build(BuildContext context) {
    final passwordValidator = MultiValidator([
      RequiredValidator(errorText: 'กรุณากรอกชื่อ-นามสกุล'),
    ]);
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('PROFILE', style: MyStyle().whiteTitleStyle())),
      backgroundColor: MyStyle().garyAllColor,
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
          ),
          Container(
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05,
                top: 10),
            child: Card(
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${profile['UserCode']}',
                                style: MyStyle().blueStyle()),
                            IconButton(
                              icon: new Icon(Icons.edit),
                              color: Colors.yellow[600],
                              iconSize: 30,
                              onPressed: () {
                                Navigator.pushNamed(context, '/profile-edit',
                                    arguments: {
                                      'UserName': profile['UserName'],
                                      'DriverCode': profile['DriverCode']
                                    });
                              },
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/images/profile.jpg'),
                                    radius: 50,
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    right: 10,
                                    child: InkWell(
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: ((builder) => Container(
                                                  height: 100.0,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  margin: EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 20,
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "Choose Profile photo",
                                                        style: TextStyle(
                                                          fontSize: 20.0,
                                                        ),
                                                      ),
                                                      SizedBox(height: 20),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              IconButton(
                                                                icon: const Icon(
                                                                    Icons
                                                                        .camera),
                                                                onPressed:
                                                                    () {},
                                                              ),
                                                              Text("Camera"),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              IconButton(
                                                                icon: const Icon(
                                                                    Icons
                                                                        .image),
                                                                onPressed:
                                                                    () {},
                                                              ),
                                                              Text("Gallery"),
                                                            ],
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )),
                                          );
                                        },
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: MyStyle().garyAllColor,
                                          size: 20,
                                        )),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('ชื่อ-นามสกุล',
                                      style: MyStyle().blueStyle()),
                                  SizedBox(height: 10),
                                  Text('${profile['UserName']}')
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ตำแหน่ง', style: MyStyle().blueStyle()),
                            SizedBox(height: 10),
                            Row(
                              children: [Text('${profile['DriverCode']}')],
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ข้อมูลการติดต่อ',
                                style: MyStyle().blueStyle()),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(
                                  Icons.call,
                                  size: 20,
                                ),
                                SizedBox(width: 10),
                                Text('081-1234322')
                              ],
                            ),
                          ],
                        )
                      ],
                    ))),
          ),
          SizedBox(height: 20),
          Container(
            height: 50,
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05,
                top: 10),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              color: MyStyle().buttongray,
              child: Text('เปลี่ยน Password', style: MyStyle().whiteStyle()),
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
                          child: Padding(
                              padding: EdgeInsets.all(30),
                              child: FormBuilder(
                                  key: _fbKey,
                                  initialValue: {
                                    'password': '',
                                    'passwordNew': '',
                                    'confirmPassword': ''
                                  },
                                  child: Column(
                                    children: [
                                      Text('เปลี่ยน Password',
                                          style: MyStyle().blueStyle()),
                                      SizedBox(height: 20),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Password เก่า',
                                                style: MyStyle().garyStyle()),
                                            SizedBox(height: 10),
                                            FormBuilderTextField(
                                                name: "password",
                                                maxLines: 1,
                                                keyboardType: TextInputType
                                                    .visiblePassword,
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
                                                validator: passwordValidator),
                                          ]),
                                      SizedBox(height: 20),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Password ใหม่',
                                                style: MyStyle().garyStyle()),
                                            SizedBox(height: 10),
                                            FormBuilderTextField(
                                                name: "passwordNew",
                                                maxLines: 1,
                                                keyboardType: TextInputType
                                                    .visiblePassword,
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
                                                validator: passwordValidator),
                                          ]),
                                      SizedBox(height: 20),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('ยืนยัน Password ใหม่',
                                                style: MyStyle().garyStyle()),
                                            SizedBox(height: 10),
                                            FormBuilderTextField(
                                                name: "confirmPassword",
                                                maxLines: 1,
                                                keyboardType: TextInputType
                                                    .visiblePassword,
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
                                                validator: passwordValidator),
                                          ]),
                                      SizedBox(height: 20),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            MaterialButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5))),
                                              color: Color(0xFFD8D8D8),
                                              textColor: Colors.white,
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context, '');
                                              },
                                              child: Text('ยกเลิก',
                                                  style:
                                                      MyStyle().whiteStyle()),
                                            ),
                                            MaterialButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5))),
                                              color: Color(0xFF82DD55),
                                              textColor: Colors.white,
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context, '');
                                              },
                                              child: Text('ยืนยัน',
                                                  style:
                                                      MyStyle().whiteStyle()),
                                            )
                                          ])
                                    ],
                                  ))),
                        ),
                      );
                    });
              },
            ),
          ),
          SizedBox(height: 50),
          Container(
            height: 50,
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05,
                top: 10),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              color: MyStyle().buttongray,
              child: Text('LOG OUT', style: MyStyle().whiteStyle()),
              onPressed: () {
                _logout();
              },
            ),
          ),
          SizedBox(height: 30)
        ],
      ),
    );
  }
}
