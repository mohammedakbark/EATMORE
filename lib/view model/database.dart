import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatmore/model/add_new_item.dart';
import 'package:eatmore/model/buy_product_model.dart';
import 'package:eatmore/model/cart_item_model.dart';
import 'package:eatmore/model/pre_book_model.dart';
import 'package:eatmore/model/user_model.dart';
import 'package:eatmore/utils/instence.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  buyaProductbyUser(BuyProductModel buyProductModel, docId) async {
    final docs = db.collection("My orders").doc();
    await docs
        .set(buyProductModel.tojsom(docs.id))
        .then((value) => removeFromCart(docId));
  }

  addToCart(CartItemModel cartItemModel) async {
    final docId = db
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Cart")
        .doc();
    await docId.set(cartItemModel.toJson(docId.id));
  }

  prebook(PreBookModel preBookModel) {
    final doc = db.collection("Pre-book").doc();
    doc.set(preBookModel.tojsom(doc.id));
  }

  //--------------------------------delete
  deleteItem(selectedId) {
    db.collection("Items").doc(selectedId).delete();
    notifyListeners();
  }

  removeFromCart(docId) async {
    await db
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Cart")
        .doc(docId)
        .delete();
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

  updatitemData(selectedId, newdetail, newprice) async {
    db
        .collection("Items")
        .doc(selectedId)
        .update({"moreDetail": newdetail, "itemPrice": newprice});
    notifyListeners();
  }

  updateCartPric(docID, price, quantity) async {
    await db
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Cart")
        .doc(docID)
        .update({
      "totalPrice": price,
      "quantity": quantity,
    });
  }

  updatebroughtProductStatus(id, newStatus) {
    db.collection("My orders").doc(id).update({"status": newStatus});
    notifyListeners();
  }

  //--------------------------------read
  UserModel? usermodel;
  fethcurrentUser(currentID) async {
    DocumentSnapshot<Map<String, dynamic>> docSnap =
        await db.collection("User").doc(currentID).get();
    if (docSnap.exists) {
      usermodel = UserModel.fromJson(docSnap.data()!);
      await fetchAddedItems(false);
      await fetchPopularItems();
    }
  }

  List<AddNewItemModel> popularItemsList = [];
  fetchPopularItems() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection("Items").where("popular", isEqualTo: true).get();
    popularItemsList = snapshot.docs.map((e) {
      return AddNewItemModel.fromJson(e.data());
    }).toList();
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

  List<CartItemModel> cartList = [];
  fetchCartItems() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Cart")
        .get();
    cartList = snapshot.docs.map((e) {
      print(e);
      return CartItemModel.fromJson(e.data());
    }).toList();
  }

  List<AddNewItemModel> selectedCategoryItem = [];
  Future<List<AddNewItemModel>> fetchselectedCategoryItem(
      String selectedCategory) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection("Items")
        .where("itemCategory", isEqualTo: selectedCategory)
        .get();
    selectedCategoryItem = snapshot.docs.map((e) {
      print(e);
      return AddNewItemModel.fromJson(e.data());
    }).toList();
    notifyListeners();

    return selectedCategoryItem;
  }

  List<BuyProductModel> currentUserOrderList = [];
  fetchCurrentUserOrder() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection("My orders")
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("status", isEqualTo: "PENDING")
        .get();
    currentUserOrderList = snapshot.docs.map((e) {
      return BuyProductModel.fromJson(e.data());
    }).toList();
  }

  List<BuyProductModel> allUsersOrderList = [];
  fetchUserOrders() async {
    print("hjsd");
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection("My orders").get();
    try {
      allUsersOrderList = snapshot.docs.map((e) {
        return BuyProductModel.fromJson(e.data());
      }).toList();
    } catch (e) {
      print("${e}");
    }
  }

  int? pendingOrder;
  List<BuyProductModel> pendingOrdersList = [];
  fetchpendingOrder(bool listen) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection("My orders")
        .where("status", isEqualTo: "PENDING")
        .get();
    pendingOrder = snapshot.docs.length;
    pendingOrdersList = snapshot.docs.map((e) {
      return BuyProductModel.fromJson(e.data());
    }).toList();
    if (listen) {
      notifyListeners();
    }
  }
}
