import 'package:flutter/material.dart';
import 'package:flutterappleman/constants/Mystyle.dart';
import 'package:signature/signature.dart';

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
  @override
  Widget build(BuildContext context) {
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
                top: 30),
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.05,
                          right: MediaQuery.of(context).size.width * 0.05,
                          top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('เอกสารที่เกี่ยวกับผู้ขาย',
                              style: MyStyle().garyStyle()),
                          IconButton(
                            icon: Icon(
                              Icons.add_circle,
                            ),
                            iconSize: 50,
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
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.05,
                                                        right: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.05,
                                                        top: 30),
                                                    child: Text('เอกสารแนบ',
                                                        style: MyStyle()
                                                            .redStyle()),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.05,
                                                        right: MediaQuery.of(
                                                                    context)
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
                                                                EdgeInsets.all(
                                                                    10),
                                                            child: Icon(
                                                              Icons.attach_file,
                                                              color:
                                                                  Colors.grey,
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
                                                                'หนังสือมอบอำนาจ',
                                                                style: MyStyle()
                                                                    .garyStyle()),
                                                            Text(
                                                                'ขนาดไฟล์ 0.0 MB')
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.05,
                                                        right: MediaQuery.of(
                                                                    context)
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
                                                                EdgeInsets.all(
                                                                    10),
                                                            child: Icon(
                                                              Icons.attach_file,
                                                              color:
                                                                  Colors.grey,
                                                              size: 50,
                                                            ),
                                                          ),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text('ทะเบียนรถ',
                                                                style: MyStyle()
                                                                    .garyStyle()),
                                                            Text(
                                                                'ขนาดไฟล์ 0.0 MB')
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.05,
                                                        right: MediaQuery.of(
                                                                    context)
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
                                                                EdgeInsets.all(
                                                                    10),
                                                            child: Icon(
                                                              Icons.attach_file,
                                                              color:
                                                                  Colors.grey,
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
                                                            Text(
                                                                'ขนาดไฟล์ 0.0 MB')
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: MediaQuery.of(
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
                                                              .spaceAround,
                                                      children: [
                                                        Card(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            child: Icon(
                                                              Icons.attach_file,
                                                              color:
                                                                  Colors.grey,
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
                                                                'เอกสารยืนยันตัวตน',
                                                                style: MyStyle()
                                                                    .garyStyle()),
                                                            Text(
                                                                'ขนาดไฟล์ 0.0 MB')
                                                          ],
                                                        )
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
                                                                top: 30),
                                                            child:
                                                                MaterialButton(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              5))),
                                                              color: Color(
                                                                  0xFFD8D8D8),
                                                              textColor:
                                                                  Colors.white,
                                                              onPressed: () {
                                                                Navigator
                                                                    .pushNamed(
                                                                        context,
                                                                        '');
                                                              },
                                                              child: Text(
                                                                  'ยกเลิก',
                                                                  style: MyStyle()
                                                                      .whiteStyle()),
                                                            )),
                                                        Container(
                                                            height: 50,
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
                                                                top: 30),
                                                            child:
                                                                MaterialButton(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              5))),
                                                              color: Color(
                                                                  0xFF82DD55),
                                                              textColor:
                                                                  Colors.white,
                                                              onPressed: () {
                                                                Navigator
                                                                    .pushNamed(
                                                                        context,
                                                                        '');
                                                              },
                                                              child: Text(
                                                                  'ยืนยัน',
                                                                  style: MyStyle()
                                                                      .whiteStyle()),
                                                            )),
                                                      ]),
                                                ],
                                              ),
                                            ],
                                          )),
                                    );
                                  });
                            },
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.05,
                          right: MediaQuery.of(context).size.width * 0.05),
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.05,
                                  right:
                                      MediaQuery.of(context).size.width * 0.05,
                                  top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('บัตรประชาชน',
                                      style: MyStyle().garyStyle()),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(children: [
                                        Icon(Icons.image),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            primary: Color(0xFF4A90E2),
                                          ),
                                          onPressed: () {
                                            Navigator.pushNamed(context, '/');
                                          },
                                          child:
                                              Text('รูปหน้าโกดังลาดพร้าว.jpg'),
                                        ),
                                      ]),
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
                              )),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
          Container(
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05,
                top: 20,
              ),
              child: Card(
                child: Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05,
                        top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ลายเซ็นผู้ขาย', style: MyStyle().blueStyle()),
                        Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                        Center(
                            child: Container(
                          padding: EdgeInsets.all(0),
                          child: Signature(
                            controller: _controller,
                            height: 130,
                            backgroundColor: Colors.white,
                          ),
                        ))
                      ],
                    )),
              )),
          Container(
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05,
                top: 10,
              ),
              child: Card(
                child: Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05,
                        top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ลายเซ็นผู้รับ', style: MyStyle().blueStyle()),
                        Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                        Center(
                            child: Container(
                          padding: EdgeInsets.all(0),
                          child: Signature(
                            controller: _controller,
                            height: 130,
                            backgroundColor: Colors.white,
                          ),
                        ))
                      ],
                    )),
              )),
          Container(
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05,
                top: 20,
                bottom: 20),
            child: MaterialButton(
              height: 50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              color: MyStyle().buttonblue,
              child: Text('ยืนยันการรับมอบรถ', style: MyStyle().whiteStyle()),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
