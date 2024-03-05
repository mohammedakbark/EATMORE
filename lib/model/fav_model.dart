class FavModel {
  // String favId;

  String proID;
  String img;
  String name;
  String details;
  String price;
  num rating;
  FavModel(
      {required this.proID,
      required this.details,
      required this.img,
      required this.name,
      required this.price,
      required this.rating});
  Map<String, dynamic> toJson() => {
        "proID": proID,
        "details": details,
        "img": img,
        "name": name,
        "price": price,
        "rating": rating
      };
  factory FavModel.fromJson(Map<String, dynamic> json) {
    return FavModel(
        proID: json["proID"],
        details: json["details"],
        img: json["img"],
        name: json["name"],
        price: json["price"],
        rating: json["rating"]);
  }
}
