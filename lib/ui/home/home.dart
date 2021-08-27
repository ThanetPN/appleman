import 'package:flutter/material.dart';
import 'package:flutterappleman/constants/Mystyle.dart';
import 'package:flutterappleman/models/CardModel.dart';
//import 'package:flutterappleman/ui/detail/detailSchedule.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Datum> data = [];
  bool isLoading = true;
  var EventCalendar = DateFormat('yyyy-MM-dd').format(DateTime.now());

  _getData() async {
    final url = Uri.parse(
        'https://apps.softsquaregroup.com/AAA.AppleMan.API/api/Requst/GetRequest?calendarEvent=' +
            EventCalendar.toString());
    //print(url);

    final http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      final CardModel home =
          CardModel.fromJson(convert.jsonDecode(response.body));
      setState(() {
        data = home.data;
        isLoading = false;
      });
      print(response.body);
    } else {
      print('error from backend ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  //calendar
  //late Map<DateTime, List<Datum>> selectedEvents;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  // List<Datum> _getEventsfromDay(DateTime date) {
  //   return selectedEvents[date] ?? [];
  // }

  @override
  Widget build(BuildContext context) {
    final d = new DateFormat('yyyy-MM-dd');
    final z = new DateFormat('dd-MM-yyyy');
    //final f = new DateFormat('hh:mm');
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: MyStyle().garyAllColor,
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            child: TableCalendar(
                              focusedDay: selectedDay,
                              firstDay: DateTime(1990),
                              lastDay: DateTime(2050),
                              startingDayOfWeek: StartingDayOfWeek.sunday,
                              daysOfWeekVisible: true,

                              //Day Changed
                              onDaySelected:
                                  (DateTime selectDay, DateTime focusDay) {
                                setState(() {
                                  selectedDay = selectDay;
                                  focusedDay = focusDay;
                                });
                                EventCalendar = d.format(focusedDay);
                                //print(EventCalendar);
                                _getData();
                              },
                              selectedDayPredicate: (DateTime date) {
                                return isSameDay(selectedDay, date);
                              },
                              //eventLoader: _getEventsfromDay,
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(35, 20, 0, 20),
                              child: Text(z.format(focusedDay),
                                  style: MyStyle().redStyle())),
                          //addd()
                          // data.forEach((d) {
                          //   print("$data.locationNameTha");
                          // })
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  // app bar methods:-----------------------------------------------------------
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text('CALENDAR', style: MyStyle().whiteTitleStyle()),
    );
  }

  Widget addd() {
    final f = new DateFormat('hh:mm');
    return isLoading == true
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Expanded(
            child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: new InkWell(
                        onTap: () async {
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed('/detail');
                        },
                        child: Column(
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Image.asset(
                                            'assets/icons/logo.png',
                                            height: 50,
                                            width: 50,
                                          ),
                                          Icon(
                                            Icons.chevron_right,
                                            color: Colors.grey,
                                            size: 50,
                                          ),
                                          Icon(
                                            Icons.home,
                                            color: Colors.yellow,
                                            size: 50,
                                          ),
                                        ]),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.place,
                                              color: Colors.red,
                                            ),
                                            SizedBox(width: 10),
                                            Text(data[index].wareHouseNameTha,
                                                style: MyStyle().garyStyle())
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.place,
                                              color: Colors.red,
                                            ),
                                            SizedBox(width: 10),
                                            Text(data[index].locationNameTha,
                                                style: MyStyle().garyStyle())
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(children: <Widget>[
                                              Icon(
                                                Icons.watch_later,
                                              ),
                                              SizedBox(width: 10),
                                              Text(f.format(
                                                  data[index].endEffectiveDate))
                                            ]),
                                            SizedBox(width: 15),
                                            Row(children: <Widget>[
                                              Icon(
                                                Icons.drive_eta,
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                  '${data[index].amount.toString()} คัน')
                                            ]),
                                          ],
                                        ),
                                        Row(children: <Widget>[
                                          MaterialButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5))),
                                            color: MyStyle().buttongreen,
                                            textColor: Colors.white,
                                            onPressed: () {},
                                            child: Text(
                                                data[index].requestStatus,
                                                style: MyStyle().whiteStyle()),
                                          )
                                        ])
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text(data[index].remark)
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  'assets/images/profile.jpg'),
                                              radius: 20,
                                            ),
                                            CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  'assets/images/profile.jpg'),
                                              radius: 20,
                                            ),
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  Text('+10'),
                                                  Icon(
                                                    Icons.more_horiz,
                                                  ),
                                                ])
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ));
                },
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
                itemCount: data.length));
  }
}
