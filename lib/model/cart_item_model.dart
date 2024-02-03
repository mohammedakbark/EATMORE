class CartItemModel {
  String ?cartId;
  String itemId;
  String itemName;
  String itemImage;
  // String itemCategory;
  String itemPrice;

  CartItemModel({
     this.cartId,
    // required this.itemCategory,
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
        // "itemCategory": itemCategory,
        "itemPrice": itemPrice,
      };
  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
        cartId: json["cartId"],
        // itemCategory: json["itemCategory"],
        itemId: json["itemId"],
        itemImage: json["itemImage"],
        itemName: json["itemName"],
        itemPrice: json["itemPrice"],
      );
}
