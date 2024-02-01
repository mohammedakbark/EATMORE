import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatmore/model/add_new_item.dart';
import 'package:eatmore/model/user_model.dart';
import 'package:flutter/material.dart';

class Database with ChangeNotifier {
  final db = FirebaseFirestore.instance;
//--------------------------------create
  addUser(uid, UserModel userModel) async {
    final docRef = db.collection("User").doc(uid);
    await docRef.set(userModel.toJson(docRef.id));
  }

  addNewProduct(AddNewItemModel addNewItem) async {
    final doc = db.collection("Items").doc();
    doc.set(addNewItem.toJson(doc.id));
    notifyListeners();
  }

  //--------------------------------delete
  //--------------------------------update
  updateUserData(currentUid, UserModel usermodel, context) async {
    await db
        .collection("User")
        .doc(currentUid)
        .update(usermodel.toJson(currentUid))
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile Edited Succesful..!")));
    });
    notifyListeners();
  }

  //--------------------------------read
  UserModel? usermodel;
  fethcurrentUser(currentID) async {
    DocumentSnapshot<Map<String, dynamic>> docSnap =
        await db.collection("User").doc(currentID).get();
    if (docSnap.exists) {
      usermodel = UserModel.fromJson(docSnap.data()!);
    }
  }
}
