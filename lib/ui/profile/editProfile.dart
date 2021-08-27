import 'package:flutter/material.dart';
import 'package:flutterappleman/constants/Mystyle.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('EDIT PROFILE', style: MyStyle().whiteTitleStyle())),
      backgroundColor: MyStyle().garyAllColor,
      body: _buildbody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          floatingActionButton(),
        ],
      )),
    );
  }

  Widget floatingActionButton() {
    return Card(
        child: Padding(
      padding: EdgeInsets.fromLTRB(40, 5, 40, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),

            color: MyStyle().buttongray, // background
            textColor: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
            child: Text('ยกเลิก', style: MyStyle().whiteStyle()),
          ),
          SizedBox(width: 30),
          MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            color: MyStyle().buttongreen,
            textColor: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            child: Text('ยืนยัน', style: MyStyle().whiteStyle()),
          )
        ],
      ),
    ));
  }
}

Widget _buildbody() {
  return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
          Widget>[
    SafeArea(
        child: Padding(
      padding: EdgeInsets.all(10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: <
          Widget>[
        Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/profile.jpg'),
                              radius: 40,
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ชื่อ-นามสกุล', style: MyStyle().blueStyle()),
                            Container(
                              margin: EdgeInsets.only(top: 16),
                              child: TextFormField(
                                maxLines: 1,
                                decoration: InputDecoration(
                                  hintStyle: MyStyle().h3Style(),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyStyle().garyColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyStyle().garyColor),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Column(children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('ตำแหน่ง', style: MyStyle().blueStyle()),
                              Container(
                                margin: EdgeInsets.only(top: 16),
                                child: TextFormField(
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintStyle: MyStyle().h3Style(),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: MyStyle().garyColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: MyStyle().garyColor),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('ข้อมูลการติดต่อ',
                                  style: MyStyle().blueStyle()),
                              Container(
                                margin: EdgeInsets.only(top: 16),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelStyle: MyStyle().h3Style(),
                                    labelText: '',
                                    prefixIcon: Icon(
                                      Icons.call,
                                      color: MyStyle().garyColor,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: MyStyle().garyColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: MyStyle().garyColor),
                                    ),
                                  ),
                                ),
                              ),
                              // Row(
                              //   children: [
                              //     Text('ข้อมูลการติดต่อ',
                              //     style: MyStyle().blueStyle()),
                              //     Icon(
                              //       Icons.call,
                              //       size: 20,
                              //     ),
                              //     SizedBox(width: 10),
                              //   ],
                              // ),
                            ],
                          )
                        ]),
                      ],
                    ),
                  )
                ],
              ),
            )),
      ]),
    ))
  ]));
}
