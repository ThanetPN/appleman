import 'package:flutter/material.dart';
import 'package:flutterappleman/ui/detail/camera/camera.dart';
import 'package:flutterappleman/ui/detail/camera/picture.dart';
import 'package:flutterappleman/ui/detail/detailSchedule.dart';
import 'package:flutterappleman/ui/detail/map/pickUpLocation.dart';

class DetailStack extends StatefulWidget {
  DetailStack({Key? key}) : super(key: key);

  @override
  _DetailStackState createState() => _DetailStackState();
}

class _DetailStackState extends State<DetailStack> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'detailstack/detail',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'detailstack/detail':
            builder = (BuildContext _) => DetailSchedule();
            break;
          // case 'detailstack/camera':
          //   builder = (BuildContext _) => Camera();
          //   break;
          // case 'detailstack/picture':
          //   builder = (BuildContext _) => Picture();
          //   break;
          // case 'detailstack/map':
          //   builder = (BuildContext _) => MapsGoogle();
          //   break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
