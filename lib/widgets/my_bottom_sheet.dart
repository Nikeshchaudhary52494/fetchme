import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void showImagePicker(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 18, 181, 135),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.only(top: 40),
        height: 300,
        child: Column(
          children: <Widget>[
            ListTile(
              leading: const Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
              title: const Text(
                'Take a photo',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () async {
                Navigator.pop(context);
                final image =
                    await ImagePicker().pickImage(source: ImageSource.camera);
                if (image != null) {
                  _processImage(File(image.path));
                }
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.photo,
                color: Colors.white,
              ),
              title: const Text(
                'Choose from gallery',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () async {
                Navigator.pop(context);
                final image =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (image != null) {
                  // Process the image from the gallery
                  _processImage(File(image.path));
                }
              },
            ),
          ],
        ),
      );
    },
  );
}

void _processImage(File image) {
  print('Selected image: ${image.path}');
}
