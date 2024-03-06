class AddNewReview {
  String? reviewId;
  String uid;
  String review;
  double rating;
  // String proname;
  String proId;
  String date;

  AddNewReview(
      {required this.proId,
      required this.date,
      // required this.proname,
      required this.rating,
      required this.review,
      this.reviewId,
      required this.uid});

  Map<String, dynamic> toJson(id) => {
        "proId": proId,
        "date":date,
        // "proname": proname,
        "rating": rating,
        "review": review,
        "reviewId": id,
        "uid": uid
      };
  factory AddNewReview.fromJson(Map<String, dynamic> json) {
    return AddNewReview(
        proId: json["proId"],
        date: json["date"],
        // proname: json["proname"],
        rating: json["rating"],
        review: json["review"],
        reviewId: json["reviewId"],
        uid: json["uid"]);
  }
}
