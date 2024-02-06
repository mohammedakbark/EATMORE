import 'package:eatmore/model/user_model.dart';

class PreBookModel {
  String? id;
  String status;
  String tokenNo;
  String itemName;
  String bookedDate;
  String quantity;

  UserModel userModel;
  PreBookModel(
      {this.id,
      required this.bookedDate,
      required this.itemName,
      required this.quantity,
      required this.userModel,
      required this.status,
      required this.tokenNo});

  Map<String, dynamic> tojsom(ids) => {
        "id": ids,
        "bookedDate": bookedDate,
        "itemName": itemName,
        "quantity": quantity,
        "status": status,
        "tokenNo": tokenNo,
        "userModel": userModel.toJson(userModel.uid),
      };
  factory PreBookModel.fromJson(Map<String, dynamic> json) {
    return PreBookModel(
        bookedDate: json["bookedDate"],
        itemName: json["itemName"],
        quantity: json["quantity"],
        userModel: json["userModel"],
        id: json["id"],
        status: json["status"],
        tokenNo: json["tokenNo"]);
  }
}
