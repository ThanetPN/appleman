import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutterappleman/constants/Mystyle.dart';

class Camera extends StatefulWidget {
  Camera({Key? key}) : super(key: key);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'CAMERA',
          style: MyStyle().whiteTitleStyle(),
        ),
      ),
      body: CameraCamera(
        onFile: (file) => print(file),
      ),

      backgroundColor: Colors.black,

      //button
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyStyle().blueColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CameraCamera(
                onFile: (file) {
                  //photos.add(file);
                  //When take foto you should close camera
                  Navigator.pop(context);
                  setState(() {});
                },
              ),
            ),
          );
        },
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}
