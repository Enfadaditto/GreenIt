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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('New Step'),
      content: _userSelectedImage != null
          ? Image.file(_userSelectedImage!, width: 150, height: 150)
          : ElevatedButton(
              onPressed: _selectImage, child: Text('Select image')),
      actions: <Widget>[
        TextButton(
          child: Text('Close'),
          onPressed: () {
            Navigator.of(context).pop(); // Cierra el diálogo
          },
        ),
        TextButton(
          child: Text('Create'),
          onPressed: () {
            //Guarda el paso en steps[]
            Navigator.of(context).pop(); // Cierra el diálogo
          },
        ),
      ],
    );
  }
}
