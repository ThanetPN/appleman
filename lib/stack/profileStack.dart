import 'package:flutter/material.dart';
import 'package:flutterappleman/ui/profile/editProfile.dart';
import 'package:flutterappleman/ui/profile/profile.dart';

class ProfileStack extends StatefulWidget {
  ProfileStack({Key? key}) : super(key: key);

  @override
  _ProfileStackState createState() => _ProfileStackState();
}

class _ProfileStackState extends State<ProfileStack> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'profilestack/profile',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'profilestack/profile':
            builder = (BuildContext _) => Profile();
            break;
          case 'profilestack/profile-edit':
            builder = (BuildContext _) => EditProfile();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
