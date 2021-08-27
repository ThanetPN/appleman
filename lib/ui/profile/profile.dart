import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterappleman/constants/Mystyle.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text('PROFILE', style: MyStyle().whiteTitleStyle())),
        backgroundColor: MyStyle().garyAllColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SafeArea(
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Card(
                              child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('LM001',
                                              style: MyStyle().blueStyle()),
                                          IconButton(
                                            icon: new Icon(Icons.edit),
                                            color: Colors.yellow[600],
                                            iconSize: 30,
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, '/profile-edit');
                                            },
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.black,
                                        thickness: 1,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Stack(
                                              children: [
                                                CircleAvatar(
                                                  backgroundImage: AssetImage(
                                                      'assets/images/profile.jpg'),
                                                  radius: 50,
                                                ),
                                                Positioned(
                                                  bottom: 10,
                                                  right: 10,
                                                  child: InkWell(
                                                      onTap: () {
                                                        showModalBottomSheet(
                                                          context: context,
                                                          builder: ((builder) =>
                                                              Container(
                                                                height: 100.0,
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                  horizontal:
                                                                      20,
                                                                  vertical: 20,
                                                                ),
                                                                child: Column(
                                                                  children: [
                                                                    Text(
                                                                      "Choose Profile photo",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            20.0,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            20),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            IconButton(
                                                                              icon: const Icon(Icons.camera),
                                                                              onPressed: () {},
                                                                            ),
                                                                            Text("Camera"),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            IconButton(
                                                                              icon: const Icon(Icons.image),
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
                                                        color: MyStyle()
                                                            .garyAllColor,
                                                        size: 20,
                                                      )),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                30, 0, 0, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('ชื่อ-นามสกุล',
                                                    style:
                                                        MyStyle().blueStyle()),
                                                Text('นายยึดมั่น รักษาเกียรติ')
                                              ],
                                            ),
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
                                          Row(
                                            children: [
                                              Text(
                                                  'หัวหน้าทีมงานเคลื่อนย้ายที่ 1')
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('ข้อมูลการติดต่อ',
                                              style: MyStyle().blueStyle()),
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
                          SizedBox(height: 20),
                          //เปลี่ยน Password
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            minWidth: 350,
                            color: MyStyle().buttongray,
                            child: Text('เปลี่ยน Password',
                                style: MyStyle().whiteStyle()),
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
                                        height: 450,
                                        child: Padding(
                                          padding: EdgeInsets.all(30),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text('เปลี่ยน Password',
                                                      style: MyStyle()
                                                          .blueStyle()),
                                                ],
                                              ),
                                              SizedBox(height: 30),
                                              Text('Password เก่า',
                                                  style: MyStyle().garyStyle()),
                                              FormBuilderTextField(
                                                  name: '',
                                                  maxLines: 1,
                                                  obscureText: true,
                                                  keyboardType: TextInputType
                                                      .visiblePassword,
                                                  decoration: InputDecoration(
                                                      labelText: "",
                                                      labelStyle: TextStyle(
                                                          color:
                                                              Colors.black87),
                                                      fillColor: Colors.white,
                                                      filled: true,
                                                      border: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                      errorStyle: TextStyle(
                                                          color: Colors.white)),
                                                  validator:
                                                      FormBuilderValidators
                                                          .compose([
                                                    FormBuilderValidators
                                                        .required(context),
                                                    FormBuilderValidators
                                                        .numeric(context),
                                                    FormBuilderValidators
                                                        .minLength(context, 3),
                                                  ])),
                                              Text('Password ใหม่',
                                                  style: MyStyle().garyStyle()),
                                              FormBuilderTextField(
                                                  name: '',
                                                  maxLines: 1,
                                                  obscureText: true,
                                                  keyboardType: TextInputType
                                                      .visiblePassword,
                                                  decoration: InputDecoration(
                                                      labelText: "",
                                                      labelStyle: TextStyle(
                                                          color:
                                                              Colors.black87),
                                                      fillColor: Colors.white,
                                                      filled: true,
                                                      border: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                      errorStyle: TextStyle(
                                                          color: Colors.white)),
                                                  validator:
                                                      FormBuilderValidators
                                                          .compose([
                                                    FormBuilderValidators
                                                        .required(context),
                                                    FormBuilderValidators
                                                        .numeric(context),
                                                    FormBuilderValidators
                                                        .minLength(context, 3),
                                                  ])),
                                              Text('ยืนยัน Password ใหม่',
                                                  style: MyStyle().garyStyle()),
                                              FormBuilderTextField(
                                                  name: '',
                                                  maxLines: 1,
                                                  obscureText: true,
                                                  keyboardType: TextInputType
                                                      .visiblePassword,
                                                  decoration: InputDecoration(
                                                      labelText: "",
                                                      labelStyle: TextStyle(
                                                          color:
                                                              Colors.black87),
                                                      fillColor: Colors.white,
                                                      filled: true,
                                                      border: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                      errorStyle: TextStyle(
                                                          color: Colors.white)),
                                                  validator:
                                                      FormBuilderValidators
                                                          .compose([
                                                    FormBuilderValidators
                                                        .required(context),
                                                    FormBuilderValidators
                                                        .numeric(context),
                                                    FormBuilderValidators
                                                        .minLength(context, 3),
                                                  ])),
                                              SizedBox(height: 20),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: <Widget>[
                                                    MaterialButton(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5))),
                                                      color: Color(0xFFD8D8D8),
                                                      textColor: Colors.white,
                                                      onPressed: () {
                                                        Navigator.pushNamed(
                                                            context, '');
                                                      },
                                                      child: Text('ยกเลิก',
                                                          style: MyStyle()
                                                              .whiteStyle()),
                                                    ),
                                                    MaterialButton(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5))),
                                                      color: Color(0xFF82DD55),
                                                      textColor: Colors.white,
                                                      onPressed: () {
                                                        Navigator.pushNamed(
                                                            context, '');
                                                      },
                                                      child: Text('ยืนยัน',
                                                          style: MyStyle()
                                                              .whiteStyle()),
                                                    )
                                                  ])
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            },
                          ),
                          SizedBox(height: 50),
                          //LOG OUT
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            minWidth: 350,
                            color: MyStyle().buttongray,
                            child:
                                Text('LOG OUT', style: MyStyle().whiteStyle()),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pushNamedAndRemoveUntil('/login',
                                      (Route<dynamic> router) => false);
                            },
                          ),
                        ],
                      )))
            ],
          ),
        ));
  }
}
