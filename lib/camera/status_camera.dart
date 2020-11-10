import 'package:flutter/material.dart';

class StatusCameraHome extends StatefulWidget {

  @override
  _StatusCameraHomeState createState() => _StatusCameraHomeState();
}

class _StatusCameraHomeState extends State<StatusCameraHome> {
 
  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/camera_ios.png',fit: BoxFit.fitWidth,);
  }
}