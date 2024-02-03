import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';

Widget ratingBar(rating) {
  return RatingBar.builder(
    initialRating: rating,
    direction: Axis.horizontal,
    allowHalfRating: true,
    itemCount: 5,
    itemSize: 15,
    itemBuilder: (context, _) => Icon(
      Icons.star,
      color: HexColor("FFE120"),
    ),
    onRatingUpdate: (rating) {
      // Handle rating updates here
      print(rating);
    },
  );
}