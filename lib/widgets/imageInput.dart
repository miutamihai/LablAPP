import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
      );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 150,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
              ),
            ))
      ],
    );
  }
}
