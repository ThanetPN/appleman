import 'package:flutter/material.dart';
import 'package:flutterappleman/constants/Mystyle.dart';
import 'package:flutterappleman/models/CardModel.dart';
import 'package:flutterappleman/ui/home/setCalendar.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<InRequestHome> homeCard = [];
  bool isLoading = true;
  late String wareHouseNameTha;
  var EventCalendar = DateFormat('yyyy-MM-dd').format(
    DateTime.now(),
  );
  final d = new DateFormat('yyyy-MM-dd');

  _getCalendarByDay() async {
    var url = Uri.parse(
        'https://apps.softsquaregroup.com/AAA.AppleMan.API/api/Requst/GetRequestByDay?calendarEventDay=${EventCalendar.toString()}');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      final CardModel home = CardModel.fromJson(
        convert.jsonDecode(response.body),
      );

      setState(() {
        homeCard = home.homeCard;
        isLoading = false;
      });
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

  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat calendarFormat = CalendarFormat.month;
  RangeSelectionMode rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? selectedDay;
  DateTime? rangeStart;
  DateTime? rangeEnd;

  @override
  void initState() {
    super.initState();
    _getCalendarByDay();

    selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(
      getEventsForDay(selectedDay!),
    );
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ...getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      selectedDay = selectedDay;
      _focusedDay = focusedDay;
      rangeStart = null; // Important to clean those
      rangeEnd = null;
      rangeSelectionMode = RangeSelectionMode.toggledOff;
    });
    EventCalendar = d.format(focusedDay);
    _getCalendarByDay();
    _selectedEvents.value = getEventsForDay(selectedDay);
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      selectedDay = null;
      _focusedDay = focusedDay;
      rangeStart = start;
      rangeEnd = end;
      rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    final z = new DateFormat('dd-MM-yyyy');
    final f = new DateFormat('hh:mm');
    return Scaffold(
        appBar: _buildAppBar(),
        backgroundColor: MyStyle().garyAllColor,
        body: isLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Card(
                        child: TableCalendar<Event>(
                          firstDay: kFirstDay,
                          lastDay: kLastDay,
                          focusedDay: _focusedDay,
                          selectedDayPredicate: (DateTime date) {
                            return isSameDay(selectedDay, date);
                          },
                          rangeStartDay: rangeStart,
                          rangeEndDay: rangeEnd,
                          calendarFormat: calendarFormat,
                          rangeSelectionMode: rangeSelectionMode,
                          eventLoader: getEventsForDay,
                          startingDayOfWeek: StartingDayOfWeek.sunday,
                          calendarStyle: CalendarStyle(
                            outsideDaysVisible: false,
                          ),
                          onDaySelected: _onDaySelected,
                          onRangeSelected: _onRangeSelected,
                          onFormatChanged: (format) {
                            if (calendarFormat != format) {
                              setState(() {
                                calendarFormat = format;
                              });
                            }
                          },
                          onPageChanged: (focusedDay) {
                            _focusedDay = focusedDay;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(50, 10, 0, 0),
                      child: Text(
                        z.format(_focusedDay),
                        style: MyStyle().redStyle(),
                      ),
                    ),
                    Expanded(
                      child: ValueListenableBuilder<List<Event>>(
                        valueListenable: _selectedEvents,
                        builder: (context, items, _) {
                          // return ListView.builder(
                          //   itemCount: items.length,
                          //   itemBuilder: (context, index) {
                          //     return Container(
                          //       margin: const EdgeInsets.symmetric(
                          //         horizontal: 12.0,
                          //         vertical: 4.0,
                          //       ),
                          //       decoration: BoxDecoration(
                          //         border: Border.all(),
                          //         borderRadius: BorderRadius.circular(12.0),
                          //       ),
                          //       child: ListTile(
                          //         onTap: () => print('${items[index]}'),
                          //         title: Text('${items[index]}'),
                          //       ),
                          //     );
                          //   },
                          // );

                          return ListView.separated(
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: new InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, '/detail',
                                              arguments: {
                                                'RequestID':
                                                    homeCard[index].requestId,
                                                'EventCalendar':
                                                    d.format(_focusedDay),
                                                'RequestStatus': homeCard[index]
                                                    .requestStatus
                                              });
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          Image.asset(
                                                            'assets/icons/logo.webp',
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
                                                            color:
                                                                Colors.yellow,
                                                            size: 50,
                                                          ),
                                                        ]),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons.place,
                                                              color: Colors.red,
                                                            ),
                                                            SizedBox(width: 10),
                                                            Text(
                                                              homeCard[index]
                                                                  .wareHouseNameTha,
                                                              style: MyStyle()
                                                                  .garyStyle(),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            Icon(
                                                              Icons.place,
                                                              color: Colors.red,
                                                            ),
                                                            SizedBox(width: 10),
                                                            Text(
                                                              homeCard[index]
                                                                  .locationNameTha,
                                                              style: MyStyle()
                                                                  .garyStyle(),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(children: <
                                                                Widget>[
                                                              Icon(
                                                                Icons
                                                                    .watch_later,
                                                              ),
                                                              SizedBox(
                                                                  width: 10),
                                                              Text(
                                                                f.format(homeCard[
                                                                        index]
                                                                    .endEffectiveDate),
                                                              )
                                                            ]),
                                                            SizedBox(width: 15),
                                                            Row(
                                                              children: <
                                                                  Widget>[
                                                                Icon(
                                                                  Icons
                                                                      .drive_eta,
                                                                ),
                                                                SizedBox(
                                                                    width: 10),
                                                                Text(
                                                                    '${homeCard[index].amount.toString()} คัน')
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              child: homeCard[index]
                                                                          .requestStatus ==
                                                                      'รอการยืนยัน'
                                                                  ? MaterialButton(
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.all(
                                                                          Radius.circular(
                                                                              5),
                                                                        ),
                                                                      ),
                                                                      color: MyStyle()
                                                                          .garyssColor,
                                                                      child:
                                                                          Text(
                                                                        homeCard[index]
                                                                            .requestStatus,
                                                                        style: MyStyle()
                                                                            .whiteStyle(),
                                                                      ),
                                                                      onPressed:
                                                                          () {},
                                                                    )
                                                                  : errorA(),
                                                            ),
                                                            Container(
                                                              child: homeCard[index]
                                                                          .requestStatus ==
                                                                      'รอดำเนินการ'
                                                                  ? MaterialButton(
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.all(
                                                                          Radius.circular(
                                                                              5),
                                                                        ),
                                                                      ),
                                                                      color: MyStyle()
                                                                          .yellowColor,
                                                                      child:
                                                                          Text(
                                                                        homeCard[index]
                                                                            .requestStatus,
                                                                        style: MyStyle()
                                                                            .whiteStyle(),
                                                                      ),
                                                                      onPressed:
                                                                          () {},
                                                                    )
                                                                  : errorA(),
                                                            ),
                                                            Container(
                                                              child: homeCard[index]
                                                                          .requestStatus ==
                                                                      'รอนำส่งรถ'
                                                                  ? MaterialButton(
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.all(
                                                                          Radius.circular(
                                                                              5),
                                                                        ),
                                                                      ),
                                                                      color: MyStyle()
                                                                          .yellowColor,
                                                                      child:
                                                                          Text(
                                                                        homeCard[index]
                                                                            .requestStatus,
                                                                        style: MyStyle()
                                                                            .whiteStyle(),
                                                                      ),
                                                                      onPressed:
                                                                          () {},
                                                                    )
                                                                  : errorA(),
                                                            ),
                                                            Container(
                                                              child: homeCard[index]
                                                                          .requestStatus ==
                                                                      'เสร็จสิ้น'
                                                                  ? MaterialButton(
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.all(
                                                                          Radius.circular(
                                                                              5),
                                                                        ),
                                                                      ),
                                                                      color: MyStyle()
                                                                          .greenColor,
                                                                      child:
                                                                          Text(
                                                                        homeCard[index]
                                                                            .requestStatus,
                                                                        style: MyStyle()
                                                                            .whiteStyle(),
                                                                      ),
                                                                      onPressed:
                                                                          () {},
                                                                    )
                                                                  : errorA(),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Row(
                                                          children: <Widget>[
                                                            Text(
                                                                'หมายเหตุ : ${homeCard[index].remark.toString()} น.')
                                                          ],
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            CircleAvatar(
                                                              backgroundImage:
                                                                  AssetImage(
                                                                      'assets/images/profile.jpg'),
                                                              radius: 20,
                                                            ),
                                                            CircleAvatar(
                                                              backgroundImage:
                                                                  AssetImage(
                                                                      'assets/images/profile.jpg'),
                                                              radius: 20,
                                                            ),
                                                            Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: <
                                                                    Widget>[
                                                                  Text('+10'),
                                                                  Icon(
                                                                    Icons
                                                                        .more_horiz,
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
                                      )));
                            },
                            separatorBuilder:
                                (BuildContext context, int index) => Divider(),
                            itemCount: homeCard.length,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ));
  }

  // app bar methods:---------------------------------------
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        'CALENDAR',
        style: MyStyle().whiteTitleStyle(),
      ),
    );
  }

  Widget errorA() {
    return Container(
      child: Text(''),
    );
  }
}
