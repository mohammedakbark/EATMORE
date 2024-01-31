import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';

import 'cart.dart';

class MenuDetails extends StatefulWidget {
  MenuDetails(
      {super.key, required this.img, required this.name, required this.price});
  var img, name, price;
  @override
  State<MenuDetails> createState() => _MenuDetailsState();
}

class _MenuDetailsState extends State<MenuDetails> {
  bool isFavorite = false; // Initial favorite state

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * .1,
            ),
            Center(
              child: Container(
                height: 205,
                width: 270,
                decoration: BoxDecoration(
                    image:
                        DecorationImage(fit: BoxFit.cover, image: widget.img)),
              ),
            ),
            SizedBox(
              width: 330,
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red, // Customize the color as needed
                  ),
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite; // Toggle the favorite state
                    });
                  },
                ),
              ),
            ),
            const Expanded(
              child: SizedBox(
                height: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 0,
                right: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  RatingBar.builder(
                    initialRating: 4.5,
                    minRating: 1,
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
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0.0, right: 15, bottom: 20),
              child: Text(
                '''Get ready for a flavor-packed adventurewith our samosas! These golden, crispy delights are like flavor bombs, explodingwith each bite. Ideal for satisfying yousnack cravings at our canteen.''',
                style: TextStyle(
                    fontSize: 20, color: Colors.black.withOpacity(.5)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(widget.price,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, bottom: 30),
              child: Text(
                "Total Price",
                style: TextStyle(color: HexColor("A59898")),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Center(
                      child: InkWell(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => Carts(
                      //           img: widget.img,
                      //           name: widget.name,
                      //           price: widget.price),
                      //     ));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 295,
                      decoration: BoxDecoration(
                          color: HexColor("232622"),
                          borderRadius: BorderRadius.circular(25)),
                      child: const Text("Add to Cart",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                    ),
                  )),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Center(
                      child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 295,
                    decoration: BoxDecoration(
                        color: HexColor("54E70F"),
                        borderRadius: BorderRadius.circular(25)),
                    child: const Text("Buy Now",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500)),
                  )),
                ),
                SizedBox(
                  height: height * .05,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
