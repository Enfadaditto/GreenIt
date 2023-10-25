import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class PickImageDialog extends StatefulWidget {
  @override
  _PickImageState createState() => _PickImageState();
}

class _PickImageState extends State<PickImageDialog> {
  File? _userSelectedImage;

  Future<void> _selectImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _userSelectedImage = File(pickedImage.path);
      });
    }
  }

  File? getUserSelectedImage() {
    return _userSelectedImage;
  }

  @override
  Widget build(BuildContext context) {
    return _userSelectedImage != null
        ? Image.file(_userSelectedImage!, width: 150, height: 150)
        : SizedBox(
            height: 150,
            width: 150,
            child: ElevatedButton(
                onPressed: _selectImage,
                child: Text('Select image'),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)))));
  }
}
