// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';

// class TakePicture extends StatefulWidget {
//   //final cameras = await availableCameras();
//   //final firstCamera = cameras.first;
//   final CameraDescription camera;
  
//   const TakePicture({
//     Key key,
//     @required this.camera,
//   }) : super(key: key);

//   @override
//   _TakePictureState createState() => _TakePictureState();
// }

// class _TakePictureState extends State<TakePicture> {
  
//   CameraController _controller;
//   Future<void> _initializeControllerFuture;

//   void initState() {
//     super.initState();
//     // To display the current output from the camera,
//     // create a CameraController.
//     _controller = CameraController(
//       // Get a specific camera from the list of available cameras.
//       widget.camera,
//       // Define the resolution to use.
//       ResolutionPreset.max,
//     );
//     _initializeControllerFuture = _controller.initialize();
//   }

//   void dispose() {
//     // Dispose of the controller when the widget is disposed.
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }