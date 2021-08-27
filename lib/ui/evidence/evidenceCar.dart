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
      body: signature(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: 350,
        child: MaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          minWidth: 350,
          color: MyStyle().buttonblue,
          child: Text('ยืนยันการรับมอบรถ', style: MyStyle().whiteStyle()),
          onPressed: () {},
        ),
      ),
    );
  }

  Widget signature() {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
      SafeArea(
        child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Container(
                                          height: 500,
                                          child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 30, 10, 10),
                                              child: SingleChildScrollView(
                                                  child: dialogEvidence())),
                                        ),
                                      );
                                    });
                              },
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                        Column(
                          children: [
                            Text('ไม่มีเอกสารแนบ',
                                style: MyStyle().garyStyle()),
                            Padding(
                                padding: EdgeInsets.all(20),
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
                                            child: Text(
                                                'รูปหน้าโกดังลาดพร้าว.jpg'),
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
                                ))
                          ],
                        ),
                        SizedBox(height: 20)
                      ],
                    )),
                boxDecoration(),
                boxDecorat(),
                // Container(
                //   padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                //   height: 60,
                //   width: 300,
                //   alignment: Alignment.center,
                //   child: new Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Container(
                //         padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                //         width: 100,
                //         height: 42,
                //         child: Material(
                //           shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(12)),
                //           elevation: 1.0,
                //           color: MyStyle().blueColor,
                //           clipBehavior: Clip.antiAlias,
                //           child: MaterialButton(
                //             minWidth: 100,
                //             height: 32,
                //             color: Colors.red,
                //             child: Text(
                //               'Clesr',
                //               style: MyStyle().whiteStyle(),
                //             ),
                //             onPressed: () {
                //               _controller.clear();
                //             },
                //           ),
                //         ),
                //       ),
                //       Container(
                //         padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                //         width: 100,
                //         height: 42,
                //         child: Material(
                //           shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(12)),
                //           elevation: 1.0,
                //           color: MyStyle().blueColor,
                //           clipBehavior: Clip.antiAlias,
                //           child: MaterialButton(
                //             minWidth: 100,
                //             height: 32,
                //             color: Colors.blue,
                //             child:
                //                 new Text('Save', style: MyStyle().whiteStyle()),
                //             onPressed: () async {
                //               if (_controller.isNotEmpty) {
                //                 final Uint8List? data =
                //                     await _controller.toPngBytes();
                //                 print(data);
                //               }
                //             },
                //           ),
                //         ),
                //       )
                //     ],
                //   ),
                // ),
              ],
            )),
      )
    ]));
  }

  Widget boxDecoration() {
    return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Container(
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.all(10),
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
                  ))
            ],
          ),
        ));
  }

  Widget boxDecorat() {
    return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Container(
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.all(10),
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
                              )))
                    ],
                  ))
            ],
          ),
        ));
  }

  Widget dialogEvidence() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'เอกสารแนบ',
          style: MyStyle().redStyle(),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.attach_file,
                  color: Colors.grey,
                  size: 50,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('หนังสือมอบอำนาจ', style: MyStyle().garyStyle()),
                Text('ขนาดไฟล์ 0.0 MB')
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.attach_file,
                  color: Colors.grey,
                  size: 50,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ทะเบียนรถ', style: MyStyle().garyStyle()),
                Text('ขนาดไฟล์ 0.0 MB')
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.attach_file,
                  color: Colors.grey,
                  size: 50,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('บัตรประจำตัวประชาชน', style: MyStyle().garyStyle()),
                Text('ขนาดไฟล์ 0.0 MB')
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.attach_file,
                  color: Colors.grey,
                  size: 50,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('เอกสารยืนยันตัวตน', style: MyStyle().garyStyle()),
                Text('ขนาดไฟล์ 0.0 MB')
              ],
            )
          ],
        ),
        SizedBox(height: 30),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                minWidth: 120,
                color: MyStyle().buttongray,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, '');
                },
                child: Text('ยกเลิก', style: MyStyle().whiteStyle()),
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                minWidth: 120,
                color: MyStyle().redyColor,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, '');
                },
                child: Text('ยืนยัน', style: MyStyle().whiteStyle()),
              )
            ]),
      ],
    );
  }
}
