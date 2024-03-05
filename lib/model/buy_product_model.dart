import 'package:eatmore/model/cart_item_model.dart';
import 'package:eatmore/model/user_model.dart';
import 'package:flutter/material.dart';

class BuyProductModel {
  String? purchaseId;
  String uid;

  List<CartItemModel> cartItemModel;
  String orderdateAndTime;
  String status;
  double day;
  String tokenNo;
  String paymentMode;
  UserModel userModel;

  BuyProductModel(
      {required this.cartItemModel,
      required this.day,
      required this.paymentMode,
      required this.uid,
      required this.orderdateAndTime,
      this.purchaseId,
      required this.userModel,
      required this.status,
      required this.tokenNo});
  Map<String, dynamic> tojsom(ids) => {
        "purchaseId": ids,
        "uid": uid,
        "day": day,
        "paymentMode": paymentMode,
        "cartItemModel": cartItemModel.map((e) => e.toJson(e.cartId)),
        "status": status,
        "orderdateAndTime": orderdateAndTime,
        "tokenNo": tokenNo,
        "userModel": userModel.toJson(userModel.uid),
      };
  factory BuyProductModel.fromJson(Map<String, dynamic> json) {
    var list = json["cartItemModel"] as List;
    return BuyProductModel(
        uid: json["uid"],
        day: json["day"],
        orderdateAndTime: json["orderdateAndTime"],
        paymentMode: json["paymentMode"],
        cartItemModel: list.map((e) {
          return CartItemModel.fromJson(e);
        }).toList(),
        userModel: UserModel.fromJson(json["userModel"]),
        purchaseId: json["purchaseId"],
        status: json["status"],
        tokenNo: json["tokenNo"]);
  }
}
