import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SelectedImageProvider extends ChangeNotifier{
  File? _selectedImage;

  File? get selectedImage => _selectedImage;

  Future get pickedImageFromGallery => _pickedImageFromGallery();

  Future _pickedImageFromGallery() async{
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    _selectedImage = File(returnedImage!.path);
    notifyListeners();
  }

}