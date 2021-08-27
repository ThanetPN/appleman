import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutterappleman/constants/Mystyle.dart';

class Camera extends StatefulWidget {
  Camera({Key? key}) : super(key: key);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  late CameraController _controller;
  late List<CameraDescription> cameras;
  late CameraDescription camera;
  late Widget cameraPreview;

  Future<void> initCamera() async {
    cameras = await availableCameras();
    camera = cameras.first;
    _controller = CameraController(camera, ResolutionPreset.medium);
    await _controller.initialize();

    cameraPreview = Center(child: CameraPreview(_controller));

    setState(() {
      cameraPreview = cameraPreview;
    });
  }

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('CAMERA', style: MyStyle().whiteTitleStyle()),
      ),
      body: Container(child: cameraPreview),
      backgroundColor: Colors.black,

      //button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.radio_button_unchecked),
        backgroundColor: MyStyle().buttonwhite,
        onPressed: () {
          Navigator.pushNamed(context, '/picture');
        },
      ),
    );
  }
}
