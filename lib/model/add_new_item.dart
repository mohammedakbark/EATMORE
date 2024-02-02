class AddNewItemModel {
  String? itemId;
  String itemName;
  String itemImage;
  String itemCategory;
  String itemPrice;
  String moreDetail;
  num rating;

  AddNewItemModel(
      {required this.itemCategory,
      required this.rating,
      this.itemId,
      required this.itemImage,
      required this.itemName,
      required this.itemPrice,
      required this.moreDetail});

  Map<String, dynamic> toJson(id) => {
        "itemId": id,
        "rating":rating,
        "itemName": itemName,
        "itemImage": itemImage,
        "itemCategory": itemCategory,
        "itemPrice": itemPrice,
        "moreDetail": moreDetail
      };
  factory AddNewItemModel.fromJson(Map<String, dynamic> json) =>
      AddNewItemModel(
        rating:json["rating"],
          itemCategory: json["itemCategory"],
          itemId: json["itemId"],
          itemImage: json["itemImage"],
          itemName: json["itemName"],
          itemPrice: json["itemPrice"],
          moreDetail: json["moreDetail"]);
}
