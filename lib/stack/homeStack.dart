import 'package:flutter/material.dart';
import 'package:flutterappleman/ui/home/navigationBar.dart';

class HomeStack extends StatefulWidget {
  HomeStack({Key? key}) : super(key: key);

  @override
  _HomeStackState createState() => _HomeStackState();
}

class _HomeStackState extends State<HomeStack> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'homeStack/NavigationBar',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'homeStack/NavigationBar':
            builder = (BuildContext _) => NavigationBar();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute<void>(builder: builder, settings: settings);
      },
    );
  }
}
