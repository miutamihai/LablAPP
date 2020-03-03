import 'dart:io';
import 'dart:async';
import 'package:compare_that_price/helper_classes/take_picture_notification.dart';
import 'package:compare_that_price/widgets/show_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'smart_flare_animation.dart';


class CameraPage extends StatefulWidget {
  static const String id = 'camera_page';
  @override
  State<StatefulWidget> createState() {
    return CameraScreenstate();
  }
}

class CameraScreenstate extends State<CameraPage> {
  CameraController controller;
  List cameras;
  int selectedCameraIdx;
  String imagePath;

  @override
  void initState() {
    super.initState();

    // Get the list of available cameras.
    // Then set the first camera as selected.
    availableCameras().then((availableCameras) {
      cameras = availableCameras;

      if (cameras.length > 0) {
        setState(() {
          selectedCameraIdx = 0;
        });

        _onCameraSwitched(cameras[selectedCameraIdx]).then((void v) {});
      }
    }).catchError((err) {
      print('Error: $err.code\nError Message: $err.message');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*  body: Column(
          children: [ */
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Center(
            child: _cameraPreviewWidget(),
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.black,
        ),
      ),
    );
  }

  /// Display 'Loading' text when the camera is still loading.
  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(44),
        child: AppBar(
          centerTitle: true,
          title: Text(
              '~LABL~',
          style: TextStyle(
            color: Colors.white70
          ),),
          backgroundColor: Colors.amber,
          automaticallyImplyLeading: false,
        ),
      ),
      body: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: Stack(
            children: <Widget>[
              CameraPreview(controller),
              Align(
                alignment: Alignment.bottomCenter,
                child: NotificationListener<TakePictureNotification>(
                    onNotification: onCameraTap,
                    child: GestureDetector(
                      onTap: () {
                        if (SmartFlareAnimation.of(context).shouldTakePicture &&
                            controller != null &&
                            controller.value.isInitialized) {
                          _onCapturePressed();
                        }
                      },
                      child: SmartFlareAnimation('take picture'),
                    )),
              )
            ],
          )),
    );
  }

  Future _onCameraSwitched(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }

    controller = CameraController(cameraDescription, ResolutionPreset.high);

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }

      if (controller.value.hasError) {
        Fluttertoast.showToast(
            msg: 'Camera error ${controller.value.errorDescription}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white);
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  Future _takePicture() async {
    if (!controller.value.isInitialized) {
      Fluttertoast.showToast(
          msg: 'Please wait',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white);

      return null;
    }

    // Do nothing if a capture is on progress
    if (controller.value.isTakingPicture) {
      return null;
    }

    final Directory appDirectory = await getApplicationDocumentsDirectory();
    final String pictureDirectory = '${appDirectory.path}/Pictures';
    await Directory(pictureDirectory).create(recursive: true);
    final String currentTime = DateTime.now().millisecondsSinceEpoch.toString();
    final String filePath = '$pictureDirectory/$currentTime.jpg';

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }

    return filePath;
  }

  void _onCapturePressed() {
    _takePicture().then((filePath) {
      if (mounted) {
        setState(() {
          imagePath = filePath;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ShowImage(imagePath)),
          );
        });
      }
    });
  }

  void _showCameraException(CameraException e) {
    String errorText = 'Error: ${e.code}\nError Message: ${e.description}';
    print(errorText);

    Fluttertoast.showToast(
        msg: 'Error: ${e.code}\n${e.description}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }

  bool onCameraTap(TakePictureNotification notification) {
    if (controller != null &&
        controller.value.isInitialized &&
        notification.title == 'take picture') _onCapturePressed();
  }
}
