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
        title: Text(
          'PROFILE',
          style: MyStyle().whiteTitleStyle(),
        ),
      ),
      backgroundColor: MyStyle().garyAllColor,
      body: ListView(
        children: [
          Padding(
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
                        '${profile['UserCode']}',
                        style: MyStyle().blueStyle(),
                      ),
                      IconButton(
                        icon: new Icon(Icons.edit),
                        color: Colors.yellow[600],
                        iconSize: 30,
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/profile-edit',
                            arguments: {
                              'UserName': profile['UserName'],
                              'DriverCode': profile['DriverCode']
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
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
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
                                                              Icons.camera,
                                                            ),
                                                            onPressed: () {},
                                                          ),
                                                          Text(
                                                            "Camera",
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          IconButton(
                                                            icon: const Icon(
                                                              Icons.image,
                                                            ),
                                                            onPressed: () {},
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
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ชื่อ-นามสกุล',
                                  style: MyStyle().blueStyle(),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '${profile['UserName']}',
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ตำแหน่ง',
                            style: MyStyle().blueStyle(),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                '${profile['DriverCode']}',
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ข้อมูลการติดต่อ',
                            style: MyStyle().blueStyle(),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.call,
                                size: 20,
                              ),
                              SizedBox(width: 10),
                              Text(
                                '081-1234322',
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              height: 50,
              color: MyStyle().buttongray,
              child: Text(
                'เปลี่ยน Password',
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
                        height: 500,
                        child: ListView(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 30),
                                ),
                                Text(
                                  'เปลี่ยน Password',
                                  style: MyStyle().blueStyle(),
                                ),
                                FormBuilder(
                                  key: _fbKey,
                                  initialValue: {
                                    'password': '',
                                    'passwordNew': '',
                                    'confirmPassword': '',
                                  },
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Password เก่า',
                                              style: MyStyle().garyStyle(),
                                            ),
                                            SizedBox(height: 10),
                                            TextFormField(
                                              //controller: password,
                                              keyboardType:
                                                  TextInputType.visiblePassword,
                                              obscureText: true,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'password',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Password ใหม่',
                                              style: MyStyle().garyStyle(),
                                            ),
                                            SizedBox(height: 10),
                                            TextFormField(
                                              //controller: password,
                                              keyboardType:
                                                  TextInputType.visiblePassword,
                                              obscureText: true,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'passwordNew',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'ยืนยัน Password ใหม่',
                                              style: MyStyle().garyStyle(),
                                            ),
                                            SizedBox(height: 10),
                                            TextFormField(
                                              //controller: password,
                                              keyboardType:
                                                  TextInputType.visiblePassword,
                                              obscureText: true,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'confirmPassword',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                        Navigator.pushNamed(context, '');
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
                                        Navigator.pushNamed(context, '');
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
                      ),
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              height: 50,
              color: MyStyle().buttongray,
              child: Text(
                'LOG OUT',
                style: MyStyle().whiteStyle(),
              ),
              onPressed: () {
                _logout();
              },
            ),
          ),
        ],
      ),
    );
  }
}
