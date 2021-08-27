import 'package:flutter/material.dart';
import 'package:flutterappleman/ui/evidence/evidenceCar.dart';

class EcidenceStack extends StatefulWidget {
  EcidenceStack({Key? key}) : super(key: key);

  @override
  _EcidenceStackState createState() => _EcidenceStackState();
}

class _EcidenceStackState extends State<EcidenceStack> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'evidenceStack/evidence',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'evidenceStack/evidence':
            builder = (BuildContext _) => EvidenceCar();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute<void>(builder: builder, settings: settings);
      },
    );
  }
}
