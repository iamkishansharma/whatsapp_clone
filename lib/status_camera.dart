import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class StatusCameraHome extends StatefulWidget {
  List<CameraDescription> cameras;
  StatusCameraHome(this.cameras);

  @override
  _StatusCameraHomeState createState() => _StatusCameraHomeState();
}

class _StatusCameraHomeState extends State<StatusCameraHome> {
  CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return AspectRatio(
        aspectRatio:
        controller.value.aspectRatio,
        child: CameraPreview(controller));
  }
}