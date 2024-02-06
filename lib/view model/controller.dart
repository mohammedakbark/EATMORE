import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatmore/view%20model/database.dart';
import 'package:eatmore/view/modules/user/sign/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Controller with ChangeNotifier {
  bool processingImage = false;
  DateTime selectedDate = DateTime.now();
  String? pickedate;
  selectedate(context) async {
    selectedDate = (await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023, 1, 1),
        lastDate: DateTime(2050, 12, 31)))!;
    pickedate =
        "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
    notifyListeners();
  }

  Future<int?> incrementQunatity(
      price, int currentTotalPrice, int quantity, context, docId) async {
    quantity++;
    int pr = int.parse(price);
    currentTotalPrice = pr * quantity;
    Provider.of<Database>(context, listen: false)
        .updateCartPric(docId, currentTotalPrice, quantity);
    notifyListeners();
  }

  decrementQunatity(
      price, int quantity, int currentTotalPrice, context, docId) {
    quantity--;
    int pr = int.parse(price);
    if (currentTotalPrice != 0) {
      currentTotalPrice = currentTotalPrice - pr;
      Provider.of<Database>(context, listen: false)
          .updateCartPric(docId, currentTotalPrice, quantity);
      notifyListeners();
    }
  }

  int selectedRadio = 1;
  onTheItemPopularChange(value) {
    selectedRadio = value;
    notifyListeners();
  }

  final itemName = TextEditingController();

  final itemPrice = TextEditingController();

  final itemDetail = TextEditingController();

  File? itemImage;
  final firbaseStorage = FirebaseStorage.instance;
  Future addItemImage() async {
    processingImage = true;
    notifyListeners();
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
      processingImage = false;
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

  clearData() {
    itemImage = null;
    itemDetail.clear();
    itemPrice.clear();
    itemName.clear();
    selectedItem = "Non";
    notifyListeners();
  }
}
