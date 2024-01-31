import 'package:eatmore/view/modules/admin/donationhistorylist.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Reviews extends StatefulWidget {
  const Reviews({Key? key}) : super(key: key);

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  @override
  Widget build(BuildContext context) {
    // Set the locale to en_IN for Indian time

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text(
          "Reviews",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: Reviewcomment.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage("img/download.jpeg"),
                    radius: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      color: HexColor("E1FED3"),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5),

                            Row(
                              children: [
                                const Text(
                                  'Starbi',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  " ${DateFormat.yMMMM().format(DateTime.now())}",
                                  style: const TextStyle(color: Colors.black45),
                                ),
                                const Spacer(),
                                const Icon(Icons.more_horiz),
                              ],
                            ),
                            const Text(
                              'Great Food and Service',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            RatingBar.builder(
                              initialRating: 4.5,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 17,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 2.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                // Handle rating update if needed
                              },
                            ),

                            //add a comment for food
                            const SizedBox(height: 5),

                            Container(
                              height: 85,
                              width: 280,
                              child: const Text('''
This Food is so tasty & delicious. Breakfast is delivered so fast to my place. The chef is veryfriendly. I really like the chef for Home FoodOrder. Thanks.
        '''),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
