import 'package:flutter/material.dart';
import 'package:flutterappleman/ui/detail/camera/camera.dart';
import 'package:flutterappleman/ui/detail/camera/picture.dart';
import 'package:flutterappleman/ui/detail/detailSchedule.dart';
import 'package:flutterappleman/ui/detail/map/googleMap.dart';
import 'package:flutterappleman/ui/evidence/evidenceCar.dart';
import 'package:flutterappleman/ui/home/navigationBar.dart';
import 'package:flutterappleman/ui/login/login.dart';
import 'package:flutterappleman/ui/profile/editProfile.dart';
import 'package:flutterappleman/ui/profile/profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.red),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => NavigationBar(),
        '/login': (context) => Login(),
        '/detail': (context) => DetailSchedule(),
        '/map': (context) => MapsGoogle(),
        '/camera': (context) => Camera(),
        '/picture': (context) => Picture(),
        '/evidence-car': (context) => EvidenceCar(),
        '/profile': (context) => Profile(),
        '/profile-edit': (context) => EditProfile(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
