class CartItemModel {
  String? cartId;
  String itemId;
  String itemName;
  String itemImage;
  // String itemCategory;
  String itemPrice;
  int totalPrice;
  int quantity;

  CartItemModel({
    this.cartId,
    // required this.itemCategory,
    required this.totalPrice,
    required this.quantity,
    required this.itemId,
    required this.itemImage,
    required this.itemName,
    required this.itemPrice,
  });

  Map<String, dynamic> toJson(id) => {
        "itemId": itemId,
        "cartId": id,
        "itemName": itemName,
        "itemImage": itemImage,
        'itemPrice': itemPrice,
        "quantity": quantity,
        // "itemCategory": itemCategory,
        "totalPrice": totalPrice,
      };
  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
        cartId: json["cartId"],
        totalPrice: json["totalPrice"],
        quantity: json["quantity"],

        // itemCategory: json["itemCategory"],
        itemId: json["itemId"],
        itemImage: json["itemImage"],
        itemName: json["itemName"],
        itemPrice: json["itemPrice"],
      );
}
