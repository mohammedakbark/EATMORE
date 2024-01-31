import 'dart:async';
import 'dart:io';

import 'package:eatmore/view/modules/user/sign/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Controller with ChangeNotifier {
  File? itemImage;
  final firbaseStorage = FirebaseStorage.instance;
  Future addItemImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
    if (pickedFile != null) {
      final currenttime = TimeOfDay.now();
      itemImage = File(pickedFile.path);

      notifyListeners();
      UploadTask uploadTask = firbaseStorage
          .ref()
          .child("itemPicture/$currenttime")
          .putFile(itemImage!, metadata);
      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();

      notifyListeners();
      return downloadURL;
    }
  }

  //-------------------------------------------------
  String selectedItem = "Non";
  selectItem(value) {
    selectedItem = value;
    notifyListeners();
  }
}
