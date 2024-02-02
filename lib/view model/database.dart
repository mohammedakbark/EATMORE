import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatmore/model/add_new_item.dart';
import 'package:eatmore/model/user_model.dart';
import 'package:eatmore/utils/instence.dart';
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
    await doc.set(addNewItem.toJson(doc.id)).then((value) async {
      notifyListeners();
    });
  }

  //--------------------------------delete
  deleteItem(selectedId) {
    db.collection("Items").doc(selectedId).delete();
    notifyListeners();
  }

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

  updatitemData(selectedId,newdetail,newprice) async {
    db.collection("Items").doc(selectedId).update({
      "moreDetail": newdetail,
      "itemPrice": newprice
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

  List<AddNewItemModel> itemList = [];
  fetchAddedItems(bool listen) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection("Items").get();

    itemList = snapshot.docs.map((e) {
      return AddNewItemModel.fromJson(e.data());
    }).toList();
    if (listen) {
      notifyListeners();
    }
  }
}
