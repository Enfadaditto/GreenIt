import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class PickImageDialog extends StatefulWidget {
  final Function(String) onImageSelected;
  final Widget child;

  PickImageDialog({required this.onImageSelected, required this.child});

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
        widget.onImageSelected(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        width: 250,
        child: _userSelectedImage != null
            ? Image.file(_userSelectedImage!, width: 150, height: 150)
            : ElevatedButton(
                onPressed: _selectImage,
                child: widget.child,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFCFF4D2),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(width: 3, color: Color(0xFF269A66)),
                        borderRadius: BorderRadius.circular(10.0)))));
  }
}
