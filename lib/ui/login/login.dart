import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterappleman/constants/Mystyle.dart';
import 'package:flutterappleman/widget/logo.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  bool isLoading = false;
  late SharedPreferences prefs;

  _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  _login(Map<String, dynamic> values) async {
    final url = Uri.parse(
        'https://apps.softsquaregroup.com/AAA.AppleMan.Authen/api/Authentication');
    //print(url);
    final http.Response response = await http.post(url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: convert.jsonEncode({
          'password': values['password'],
          'clientId': 'Mobile',
          'userCode': values['userCode'],
        }));

    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      //print(response.body);
      //save token
      await prefs.setString('token', response.body);

      //get profile
      await _getProfile();

      //ไปหน้า calendar
      Navigator.pushNamedAndRemoveUntil(
          context, '/navigationBar', (Route<dynamic> route) => false);
    } else {
      setState(() {
        isLoading = false;
      });
      var feedback = convert.jsonDecode(response.body);
      Flushbar(
        title: '${feedback['errorMessages']}',
        message: 'เกิดข้อผิดพลาดจากระบบ ${feedback['isSuccess']}',
        backgroundColor: MyStyle().redyColor,
        icon: Icon(
          Icons.error,
          size: 28.0,
          color: Colors.white,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.redAccent,
      )..show(context);
    }
  }

  Future<void> _getProfile() async {
    //get token from prefs
    var tokenString = prefs.getString('token');
    var token = convert.jsonDecode(tokenString!);
    String tokennn = "$token['data']";
    Map<String, dynamic> payload = Jwt.parseJwt(tokennn);
    //print(payload);
    await prefs.setString('profile', convert.jsonEncode(payload));
    //print(prefs.setString('profile', convert.jsonEncode(payload)));
  }

  @override
  Widget build(BuildContext context) {
    final userNameValidator = MultiValidator([
      RequiredValidator(errorText: 'Enter your Usercode'),
    ]);
    final passwordValidator = MultiValidator([
      RequiredValidator(errorText: 'Enter your Password '),
      MinLengthValidator(3,
          errorText: 'password must be at least 3 digits long'),
    ]);

    return Scaffold(
        body: Container(
      child: Center(
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
          Logo(),
          Padding(
            padding: EdgeInsets.all(10),
            child: FormBuilder(
              key: _fbKey,
              initialValue: {'userCode': '', 'password': ''},
              child: Column(
                children: <Widget>[
                  FormBuilderTextField(
                      name: "userCode",
                      maxLines: 1,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          labelText: "UserCode",
                          labelStyle: TextStyle(color: Colors.black87),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          errorStyle: TextStyle(color: Colors.red)),
                      validator: userNameValidator),
                  SizedBox(height: 20),
                  FormBuilderTextField(
                      name: "password",
                      maxLines: 1,
                      obscureText: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.black87),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          errorStyle: TextStyle(color: Colors.red)),
                      validator: passwordValidator),
                  SizedBox(height: 30),
                  SizedBox(
                    width: 200,
                    child: MaterialButton(
                      onPressed: () {
                        if (_fbKey.currentState!.saveAndValidate()) {
                          _login(_fbKey.currentState!.value);
                        }
                      },
                      child: Text('Log In',
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                      padding: EdgeInsets.all(15),
                      color: MyStyle().blueSkyColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ])),
      ),
    ));
  }
}
