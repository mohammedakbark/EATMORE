class AddNewItemModel {
  String? itemId;
  String itemName;
  String itemImage;
  String itemCategory;
  String itemPrice;
  String moreDetail;
  num rating;
  bool popular;

  AddNewItemModel(
      {required this.itemCategory,
      required this.rating,
      required this.popular,
      this.itemId,
      required this.itemImage,
      required this.itemName,
      required this.itemPrice,
      required this.moreDetail});

  Map<String, dynamic> toJson(id) => {
        "itemId": id,
        "rating": rating,
        "popular": popular,
        "itemName": itemName,
        "itemImage": itemImage,
        "itemCategory": itemCategory,
        "itemPrice": itemPrice,
        "moreDetail": moreDetail
      };
  factory AddNewItemModel.fromJson(Map<String, dynamic> json) =>
      AddNewItemModel(
          popular: json["popular"],
          rating: json["rating"],
          itemCategory: json["itemCategory"],
          itemId: json["itemId"],
          itemImage: json["itemImage"],
          itemName: json["itemName"],
          itemPrice: json["itemPrice"],
          moreDetail: json["moreDetail"]);
}
