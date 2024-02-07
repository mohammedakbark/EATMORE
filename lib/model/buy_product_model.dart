import 'package:eatmore/model/cart_item_model.dart';
import 'package:eatmore/model/user_model.dart';
import 'package:flutter/material.dart';

class BuyProductModel {
  String? id;
  String uid;

  CartItemModel cartItemModel;
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
      this.id,
      required this.userModel,
      required this.status,
      required this.tokenNo});
  Map<String, dynamic> tojsom(ids) => {
        "id": ids,
        "uid": uid,
        "day": day,
        "paymentMode": paymentMode,
        "cartItemModel": cartItemModel.toJson(cartItemModel.cartId),
        "status": status,
        "orderdateAndTime": orderdateAndTime,
        "tokenNo": tokenNo,
        "userModel": userModel.toJson(userModel.uid),
      };
  factory BuyProductModel.fromJson(Map<String, dynamic> json) {
    return BuyProductModel(
        uid: json["uid"],
        day: json["day"],
        orderdateAndTime: json["orderdateAndTime"],
        paymentMode: json["paymentMode"],
        cartItemModel: CartItemModel.fromJson(json["cartItemModel"]),
        userModel: UserModel.fromJson(json["userModel"]),
        id: json["id"],
        status: json["status"],
        tokenNo: json["tokenNo"]);
  }
}
