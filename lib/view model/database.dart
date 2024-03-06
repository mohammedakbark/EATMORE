import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatmore/model/addNewReview.dart';
import 'package:eatmore/model/add_new_item.dart';
import 'package:eatmore/model/buy_product_model.dart';
import 'package:eatmore/model/cart_item_model.dart';
import 'package:eatmore/model/fav_model.dart';
import 'package:eatmore/model/pre_book_model.dart';
import 'package:eatmore/model/user_model.dart';
import 'package:eatmore/utils/instence.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  buyaProductbyUser(
    BuyProductModel buyProductModel,
  ) async {
    final docs = db.collection("My orders").doc();
    await docs.set(buyProductModel.tojsom(docs.id)).then((value) {
      CollectionReference collection = db
          .collection("User")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("Cart");
      _deleteCollection(collection);
    });
  }

  addToCart(CartItemModel cartItemModel) async {
    final docId = db
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Cart")
        .doc();
    await docId.set(cartItemModel.toJson(docId.id));
  }

  Future prebook(PreBookModel preBookModel) async {
    final doc = db.collection("Pre-book").doc();
    await doc.set(preBookModel.tojsom(doc.id));
  }

  addtoFavorate(proId, FavModel favModel) {
    final docId = db
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Favorate")
        .doc(proId);

    docId.set(favModel.toJson());
    notifyListeners();
  }

  bool? isFavorate = false;
  checkTheItemIsFav(id) async {
    DocumentSnapshot<Map<String, dynamic>> docs = await db
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Favorate")
        .doc(id)
        .get();
    if (docs.exists) {
      print("exist");
      isFavorate = true;
    } else {
      print("not exist");
      isFavorate = false;
    }
    notifyListeners();
  }

  Future addNewReview(AddNewReview addNewReview) async {
    final doc = db.collection("Reviews").doc();
    await doc.set(addNewReview.toJson(doc.id));
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

  deletefromFav(id) {
    db
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Favorate")
        .doc(id)
        .delete();
    notifyListeners();
  }

  Future<void> _deleteCollection(
      CollectionReference collectionReference) async {
    final QuerySnapshot snapshot = await collectionReference.get();

    for (QueryDocumentSnapshot doc in snapshot.docs) {
      if (doc.exists) {
        await doc.reference.delete();
        notifyListeners();
      }
    }
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

  updatepreOrderStatus(id, newStatus) {
    db.collection("Pre-book").doc(id).update({"status": newStatus});
    notifyListeners();
  }

  updatemaintanence(bool newvalue) {
    db.collection("Maintanence").doc("0000").update({"value": newvalue});
    notifyListeners();
  }

  //--------------------------------read
  bool? maintanancevalue;
  Future<bool?> fetchMaintanancevalue() async {
    DocumentSnapshot<Map<String, dynamic>> docs =
        await db.collection("Maintanence").doc("0000").get();
    if (docs.exists) {
      final data = docs.data();
      maintanancevalue = data?["value"];
    } else {
      db.collection("Maintanence").doc("0000").set({"value": false});
      fetchMaintanancevalue();
    }
    return maintanancevalue;
  }

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
      String selectedCategory, bool lis) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection("Items")
        .where("itemCategory", isEqualTo: selectedCategory)
        .get();
    selectedCategoryItem = snapshot.docs.map((e) {
      print(e);
      return AddNewItemModel.fromJson(e.data());
    }).toList();

    if (lis) {
      notifyListeners();
    }

    return selectedCategoryItem;
  }

  Future<List<AddNewItemModel>> fetchAllCatergoryItem() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection("Items").get();
    selectedCategoryItem = snapshot.docs.map((e) {
      print(e);
      return AddNewItemModel.fromJson(e.data());
    }).toList();

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

  List<PreBookModel> currentUserPreOrderList = [];
  fetchCurrentUserPreorder() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection("Pre-book")
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("status", isEqualTo: "PENDING")
        .get();
    currentUserPreOrderList = snapshot.docs.map((e) {
      return PreBookModel.fromJson(e.data());
    }).toList();

    print("length :${currentUserPreOrderList.length}");
  }

  AddNewItemModel? product;
  Future<AddNewItemModel?> fetchSelectedProductImage(proId) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await db.collection("Items").doc(proId).get();
    if (snapshot.exists) {
      product = AddNewItemModel.fromJson(snapshot.data()!);
    }
    return product;
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

  List<PreBookModel> allPreOrderList = [];
  fetchAllPreOrderOrders() async {
    print("P R E O R D E R ");
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection("Pre-book").get();
    try {
      allPreOrderList = snapshot.docs.map((e) {
        return PreBookModel.fromJson(e.data());
      }).toList();
    } catch (e) {
      print("${e}");
    }
  }

  // int? pendingOrderLength = 0;
  int allPendingOrderLength = 0;
  calculatePendingOrderLength() async {
    QuerySnapshot<Map<String, dynamic>> snaps = await db
        .collection("Pre-book")
        .where("status", isEqualTo: "PENDING")
        .get();
    QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection("My orders")
        .where("status", isEqualTo: "PENDING")
        .get();
    int a = snaps.docs.length;
    int b = snapshot.docs.length;
    allPendingOrderLength = a + b;
  }

  listen() {
    notifyListeners();
  }

  int totalRevenue = 0;
  List<Map<String, dynamic>> incomeLine = [];
  List<BuyProductModel> pendingOrdersList = [];
  List<PreBookModel> prependingOrderList = [];
  fetchPEndingPreOrder() async {
    QuerySnapshot<Map<String, dynamic>> snaps = await db
        .collection("Pre-book")
        .where("status", isEqualTo: "PENDING")
        .get();
    prependingOrderList = snaps.docs.map((e) {
      return PreBookModel.fromJson(e.data());
    }).toList();
    // pendingOrderLength = pendingOrderLength! + prependingOrderList.length;
  }

  fetchpendingOrder() async {
    // totalRevenue = 0;
    QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection("My orders")
        .where("status", isEqualTo: "PENDING")
        .get();

    // pendingOrderLength = pendingOrderLength! + snapshot.docs.length;
    print("kbjn");
    pendingOrdersList = snapshot.docs.map((e) {
      return BuyProductModel.fromJson(e.data());
    }).toList();

    // print("object");

    // print("bkjk,d.mz");
    // totalRevenue = 0;
    // // incomeLine = [];
    // // int index = 0;
    // for (var data1 in pendingOrdersList) {
    //   print("in");
    //   totalRevenue += data1.cartItemModel.totalPrice;

    //   incomeLine.add({
    //     "date": data1.day,
    //     "income": data1.cartItemModel.totalPrice.toDouble()
    //   });
    // index++;
    // }

    // print(totalRevenue);
    // print(incomeLine);
    // if (listen) {
    //   notifyListeners();
    // }
  }

  List<FavModel> favList = [];

  fetchAllFav() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Favorate")
        .get();
    favList = snapshot.docs.map((e) {
      return FavModel.fromJson(e.data());
    }).toList();
  }
 List<AddNewReview> reviwList = [];
  fetchAllReviews()async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await db.collection("Reviews").get();
   reviwList = snapshot.docs.map((e) {
      return AddNewReview.fromJson(e.data());
    }).toList();
  }
}
