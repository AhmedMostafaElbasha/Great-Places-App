import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as systemPaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takeImage(String source) async {
    if (source == 'camera') {
      final imageFile = await ImagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 600,
      );
      if (imageFile == null) {
        return;
      }

      setState(() {
        _storedImage = imageFile;
      });

      final appDirectory = await systemPaths.getApplicationDocumentsDirectory();
      final fileName = path.basename(imageFile.path);
      final savedImage = await imageFile.copy('${appDirectory.path}/$fileName');
      widget.onSelectImage(savedImage);
    } else if (source == 'gallery') {
      final imageFile = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 600,
      );
      if (imageFile == null) {
        return;
      }

      setState(() {
        _storedImage = imageFile;
      });

      final appDirectory = await systemPaths.getApplicationDocumentsDirectory();
      final fileName = path.basename(imageFile.path);
      final savedImage = await imageFile.copy('${appDirectory.path}/$fileName');
      widget.onSelectImage(savedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera),
              label: Text('Take Image'),
              textColor: Theme.of(context).primaryColor,
              onPressed: () => _takeImage('camera'),
            ),
            FlatButton.icon(
              icon: Icon(Icons.photo_library),
              label: Text('Choose Image'),
              textColor: Theme.of(context).primaryColor,
              onPressed: () => _takeImage('gallery'),
            ),
          ]),
        ),
      ],
    );
  }
}
