import 'package:eatmore/model/user_model.dart';

class PreBookModel {
  String? prebookId;
  String status;
  String tokenNo;
  String itemName;
  String itemId;
  String currentDate;
  String bookedDate;
  String quantity;
  String price;
  String paymentMode;

  String uid;
  PreBookModel(
      {this.prebookId,
      required this.price,
      required  this.paymentMode,
      required this.itemId,
      required this.currentDate,
      required this.bookedDate,
      required this.itemName,
      required this.quantity,
      required this.uid,
      required this.status,
      required this.tokenNo});

  Map<String, dynamic> tojsom(ids) => {
        "prebookId": ids,
        "paymentMode":paymentMode,
        "price": price,
        "currentDate": currentDate,
        "bookedDate": bookedDate,
        "itemName": itemName,
        "quantity": quantity,
        "status": status,
        "tokenNo": tokenNo,
        "itemId": itemId,
        "uid": uid
      };
  factory PreBookModel.fromJson(Map<String, dynamic> json) {
    return PreBookModel(
        price: json["price"],
        paymentMode:json["paymentMode"],
        currentDate: json["currentDate"],
        itemId: json["itemId"],
        bookedDate: json["bookedDate"],
        itemName: json["itemName"],
        quantity: json["quantity"],
        uid: json["uid"],
        prebookId: json["prebookId"],
        status: json["status"],
        tokenNo: json["tokenNo"]);
  }
}
