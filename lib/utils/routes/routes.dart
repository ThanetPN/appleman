import 'package:flutter/material.dart';
import 'package:flutterappleman/stack/detailStack.dart';
import 'package:flutterappleman/stack/evidenceStack.dart';
import 'package:flutterappleman/stack/homeStack.dart';
import 'package:flutterappleman/stack/profileStack.dart';
import 'package:flutterappleman/ui/login/login.dart';

class Routes {
  Routes._();

  //static variables
  static const String homeStack = '/home';
  static const String login = '/';
  static const String detailStack = '/detailStack';
  static const String ecidenceStack = '/ecidenceStack';
  static const String profileStack = '/profileStack';

  static final routes = <String, WidgetBuilder>{
    homeStack: (BuildContext context) => HomeStack(),
    login: (BuildContext context) => Login(),
    detailStack: (BuildContext context) => DetailStack(),
    ecidenceStack: (BuildContext context) => EcidenceStack(),
    profileStack: (BuildContext context) => ProfileStack(),
  };
}
