import 'package:flutter/material.dart';
import 'package:flutterappleman/constants/Mystyle.dart';

class DetailSchedule extends StatefulWidget {
  DetailSchedule({Key? key}) : super(key: key);

  @override
  _DetailScheduleState createState() => _DetailScheduleState();
}

class _DetailScheduleState extends State<DetailSchedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('รายละเอียดงาน', style: MyStyle().whiteTitleStyle()),
      ),
      backgroundColor: MyStyle().garyAllColor,
      body: _buildbody(),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      //icon car
      //floatingActionButton: buildButton(),

      //ไม่รับงาน
      // floatingActionButton: Container(
      //   width: 380,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: [notAcceptingWork()],
      //   ),
      // ),

      //ยกเลิกงาน
      floatingActionButton: Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [cancelWork()],
      )),
    );
  }

  //ยกเลิกงาน
  Widget cancelWork() {
    return Card(
        child: Padding(
      padding: EdgeInsets.fromLTRB(40, 5, 40, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            color: MyStyle().redyColor, // background
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
                        height: 300,
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('ยกเลิกงาน', style: MyStyle().redStyle()),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('เหตุผลยกเลิกงาน',
                                      style: MyStyle().garyStyle()),

                                  //Text input
                                  Container(
                                    margin: EdgeInsets.only(top: 16),
                                    child: TextFormField(
                                      maxLines: 4,
                                      decoration: InputDecoration(
                                        hintStyle: MyStyle().h3Style(),
                                        hintText:
                                            'ไม่สามารถทำการติดต่อผู้ขายได้',
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    minWidth: 120,
                                    color: MyStyle().buttongray,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      Navigator.pushNamed(context, '');
                                    },
                                    child: Text('ยกเลิก',
                                        style: MyStyle().whiteStyle()),
                                  ),
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    minWidth: 120,
                                    color: MyStyle().buttongreen,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      Navigator.pushNamed(context, '');
                                    },
                                    child: Text('ยืนยัน',
                                        style: MyStyle().whiteStyle()),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            },
          ),
          SizedBox(width: 30),
          MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            color: MyStyle().buttonblue, // background
            textColor: Colors.white,

            onPressed: () {
              Navigator.pushNamed(context, '/evidence-car');
            },
            child: Text('ยืนยันรับรถ', style: MyStyle().whiteStyle()),
          )
        ],
      ),
    ));
  }

  //ไม่รับงาน
  Widget notAcceptingWork() {
    return Card(
        child: Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              MaterialButton(
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
                            height: 300,
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('ไม่รับงาน',
                                      style: MyStyle().redStyle()),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('เหตุผลไม่รับงาน',
                                          style: MyStyle().garyStyle()),
                                      //Text input
                                      Container(
                                        margin: EdgeInsets.only(top: 16),
                                        child: TextFormField(
                                          maxLines: 4,
                                          decoration: InputDecoration(
                                            hintStyle: MyStyle().h3Style(),
                                            hintText:
                                                'มีคนในทีมไม่พอ และบางคนไม่สามารถไปได้',
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
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      MaterialButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        color: MyStyle().buttongray,
                                        textColor: Colors.white,
                                        onPressed: () {
                                          Navigator.pushNamed(context, '');
                                        },
                                        child: Text('ยกเลิก',
                                            style: MyStyle().whiteStyle()),
                                      ),
                                      MaterialButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        color: MyStyle().buttongreen,
                                        textColor: Colors.white,
                                        onPressed: () {
                                          Navigator.pushNamed(context, '/');
                                        },
                                        child: Text('ยืนยัน',
                                            style: MyStyle().whiteStyle()),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
              ),
              SizedBox(width: 30),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                color: MyStyle().buttonblue, // background
                child: Text('ยืนยันรับงาน', style: MyStyle().whiteStyle()),
                onPressed: () {
                  Navigator.pushNamed(context, '/evidence');
                  // build(context);
                  // print(cardCarEditDelete());
                },
              )
            ],
          ),
        ],
      ),
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
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'เพิ่มรายการรถ',
                            style: MyStyle().blueHeaderStyle(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              ),
                            ],
                          ),
                          TextField(
                              decoration: InputDecoration(
                                  hintText: 'ยี่ห้อ :',
                                  prefixIcon: Icon(Icons.directions_car))),
                          TextField(
                              decoration: InputDecoration(
                                  hintText: 'รุ่น :',
                                  prefixIcon: Icon(Icons.directions_car))),
                          TextField(
                              decoration: InputDecoration(
                                  hintText: 'สี :',
                                  prefixIcon: Icon(Icons.format_color_fill))),
                          TextField(
                              decoration: InputDecoration(
                                  hintText: 'ทะเบียน :',
                                  prefixIcon: Icon(Icons.directions_car))),
                          TextField(
                              decoration: InputDecoration(
                                  hintText: 'ปีผลิต :',
                                  prefixIcon: Icon(Icons.date_range))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('รูปเล่มทะเบียนรถ'),
                              Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: new InkWell(
                                    onTap: () {},
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(
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
                          SizedBox(height: 20),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  color: Color(0xFFD8D8D8), // background
                                  textColor: Colors.white,
                                  // foreground
                                  onPressed: () {
                                    Navigator.pushNamed(context, '');
                                  },
                                  child: Text('ยกเลิก'),
                                ),
                                MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  color: Color(0xFF82DD55), // background
                                  textColor: Colors.white,
                                  // foreground
                                  onPressed: () {
                                    Navigator.pushNamed(context, '');
                                  },
                                  child: Text('ยืนยัน'),
                                )
                              ]),
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
      );

  Widget _buildbody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SafeArea(
              child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('รายละเอียดงาน',
                                  style: MyStyle().blueHeaderStyle()),
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                color: MyStyle().buttongray,
                                child: Text('รอการยืนยัน',
                                    style: MyStyle().whiteStyle()),
                                onPressed: () {},
                              )
                            ],
                          ),
                          Divider(
                            color: Colors.black,
                            thickness: 1,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('ผู้ขาย', style: MyStyle().blueStyle()),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        children: [
                                          Text('นายสมจิตร มั่นเกียรติเจริญ')
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
                                Text('ผู้ติดต่อ', style: MyStyle().blueStyle()),
                                Row(
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.calendar_today),
                                        SizedBox(width: 10),
                                        Text('18/07/2021'),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.watch_later),
                                        SizedBox(width: 10),
                                        Text('02:30'),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.directions_car),
                                    SizedBox(width: 10),
                                    Text('15 คัน')
                                  ],
                                ),
                                Text('หมายเหตุ : มาให้ถึงก่อนเวลา 30 นาที'),
                                SizedBox(height: 20),
                                Column(
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
                                        Text('apple auction บางนา ')
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(width: 20),
                                        Icon(Icons.map),
                                        SizedBox(width: 5),
                                        Text('เปิด Google Map')
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
                                SizedBox(height: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        Text('ซอยลาดพร้าว 1')
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
                                            Navigator.pushNamed(context,
                                                '/map'); //Link go to map
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
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                          child: Column(
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.all(30),
                                                  child: add()),
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
                                          ),
                                        ),
                                      );
                                    });
                              },
                            )
                          ],
                        ),
                        Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('นายยึดมั่น รักษาเกียรติ',
                                  style: MyStyle().garyStyle()),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('นายสมชาย ใจดี',
                                      style: MyStyle().garyStyle()),
                                  Icon(
                                    Icons.delete,
                                    color: MyStyle().redyColor,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ]),
                      ],
                    ),
                  )),
              Padding(padding: EdgeInsets.all(10), child: bluttondownload()),
              cardCar(),
              cardCarEditDelete(),
              cardCarEditDelete(),
              cardCarEditDelete()
            ]),
          ))
        ],
      ),
    );
  }
}

Widget bluttondownload() {
  return MaterialButton(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5))),
    onPressed: () {},
    color: MyStyle().buttongray,
    child: Text('ดาวน์โหลดหนังสือมอบอำนาจ', style: MyStyle().whiteStyle()),
  );
}

Widget cardCar() {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Image.asset(
              'assets/images/car.jpg',
              height: 150,
              width: 150,
            ),
          ],
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('TOYOTA VIGO'),
          Text('สีขาว ปี 2019'),
          Text('ผร-3018 นครราชสีมา')
        ]),
      ],
    ),
  );
}

Widget cardCarEditDelete() {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Image.asset(
              'assets/images/car.jpg',
              height: 150,
              width: 150,
            ),
          ],
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('TOYOTA VIGO'),
          Text('สีขาว ปี 2019'),
          Text('ผร-3018 นครราชสีมา')
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.edit,
              color: MyStyle().yellowColor,
            ),
            SizedBox(width: 10),
            Icon(
              Icons.delete,
              color: MyStyle().redyColor,
            ),
          ],
        )
      ],
    ),
  );
}

Widget add() {
  return SingleChildScrollView(
    child: Column(
      children: [
        SafeArea(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('เพิ่มคนในทีม', style: MyStyle().blueStyle()),
                teams(),
                teams(),
                teams(),
                teams(),
              ]),
        )
      ],
    ),
  );
}

Widget teams() {
  return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(width: 15),
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/profile.jpg'),
                radius: 20,
              ),
              SizedBox(width: 10),
              Text('นายสมศรี มีชัย', style: MyStyle().garyStyle())
            ],
          ),
          Row(
            children: [Text('พนักงาน', style: MyStyle().garyStyle())],
          )
        ],
      ));
}
