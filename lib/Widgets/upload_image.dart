import 'dart:io';
import 'package:chatapp/View/AuthScreen/auth_screen_viewmodel.dart';
import 'package:provider/provider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File _pickedimage;
  final ImagePicker _imagePicker = ImagePicker();
  _pickimage(ImageSource src) async {
    final takeimage = await _imagePicker.getImage(source: src);

    if (takeimage != null) {
      setState(() {
        _pickedimage = File(takeimage.path);

        Provider.of<AuthDataProvider>(context, listen: false).pickedimage =
            _pickedimage;
        print("   choosen path image  $_pickedimage");
        print(
            " choosen path image${Provider.of<AuthDataProvider>(context, listen: false).pickedimage}");
      });
    } else {
      print("no image selected");
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("no image selected"),
        backgroundColor: Colors.black26,

//         Theme.of(ctx).splashColor,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage:
                _pickedimage != null ? FileImage(_pickedimage) : null,
            backgroundColor: Colors.grey,
            radius: 40,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FlatButton.icon(
                  color: Theme.of(context).backgroundColor,
                  onPressed: () {
                    _pickimage(ImageSource.camera);
                  },
                  icon: Icon(Icons.photo_camera),
                  label: Text("Add image \nfrom camera ",
                      style: TextStyle(color: Colors.black87),
                      textAlign: TextAlign.center)),
              FlatButton.icon(
                  color: Theme.of(context).backgroundColor,
                  onPressed: () {
                    _pickimage(ImageSource.gallery);
                  },
                  icon: Icon(Icons.image_outlined),
                  label: Text(
                    "Add image \nfrom gallary",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black87),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
