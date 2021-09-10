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
  late SharedPreferences prefs;

  _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  _login() async {
    final url = Uri.parse(
        'https://apps.softsquaregroup.com/AAA.AppleMan.Authen/api/Authentication');
    //print(url);
    final http.Response response = await http.post(url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: convert.jsonEncode({
          "userCode": userCode.text,
          "clientId": "Mobile",
          "password": password.text,
        }));
    if (response.statusCode == 200) {
      //print(response.body);
      //save token
      await prefs.setString('token', response.body);

      //get profile
      await _getProfile();

      //ไปหน้า calendar
      Navigator.pushNamedAndRemoveUntil(
          context, '/navigationBar', (Route<dynamic> route) => false);
    } else {
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

  final userCode = TextEditingController();
  final password = TextEditingController();

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
        body: ListView(
      children: [
        Logo(),
        FormBuilder(
            key: _fbKey,
            initialValue: {'userCode': '', 'password': ''},
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05),
                  child: TextFormField(
                    controller: userCode,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'UserCode',
                    ),
                    validator: userNameValidator,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05,
                      top: 10),
                  child: TextFormField(
                      controller: password,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                      validator: passwordValidator),
                ),
              ],
            )),
        Container(
          margin: EdgeInsets.only(top: 30),
        ),
        Container(
          height: 50,
          margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
              top: 10),
          child: MaterialButton(
            onPressed: () => {
              if (_fbKey.currentState!.saveAndValidate()) {_login()}
            },
            child: Text("Login",
                style: TextStyle(fontSize: 20, color: Colors.white)),
            color: Colors.blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    ));
  }
}
