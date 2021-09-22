import 'package:flutter/material.dart';
import 'package:flutterappleman/constants/Mystyle.dart';

class Picture extends StatefulWidget {
  Picture({Key? key}) : super(key: key);

  @override
  _PictureState createState() => _PictureState();
}

class _PictureState extends State<Picture> {
  //late Map picture;
  @override
  Widget build(BuildContext context) {
    //picture = ModalRoute().of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'PICTURE',
          style: MyStyle().whiteTitleStyle(),
        ),
      ),
      // body: Container(
      //   child: Image.file(
      //     // File(picture['path']),
      //     File(''),
      //     fit: BoxFit.contain,
      //     height: double.infinity,
      //     width: double.infinity,
      //     alignment: Alignment.center,
      //   ),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('picture'),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.file_upload),
        onPressed: () {},
      ),
    );
  }
}
