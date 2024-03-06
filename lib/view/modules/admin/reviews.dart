import 'package:eatmore/utils/const.dart';
import 'package:eatmore/view%20model/database.dart';
import 'package:eatmore/view/modules/admin/donationhistorylist.dart';
import 'package:eatmore/view/widgets/rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

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
        child: Consumer<Database>(builder: (context, datn, child) {
          return Builder(builder: (context) {
            return FutureBuilder(
                future: datn.fetchAllReviews(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return indicator;
                  }
                  final data = datn.reviwList;
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 20,
                              child: Icon(CupertinoIcons.profile_circled),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(right: 20),
                                color: HexColor("E1FED3"),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 5),

                                      Row(
                                        children: [
                                          Text(
                                            "USER :- ${data[index].uid.substring(1, 5)}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            " ${data[index].date}",
                                            style: const TextStyle(
                                                color: Colors.black45),
                                          ),
                                          const Spacer(),
                                          // const Icon(Icons.more_horiz),
                                        ],
                                      ),
                                      // const Text(

                                      //   style: TextStyle(
                                      //       color: Colors.black87,
                                      //       fontWeight: FontWeight.bold),
                                      // ),
                                      const SizedBox(height: 5),
                                      ratingBar(data[index].rating),
                                      // RatingBar.builder(
                                      //   initialRating:,
                                      //   minRating: 1,
                                      //   direction: Axis.horizontal,
                                      //   allowHalfRating: true,
                                      //   itemCount: 5,
                                      //   itemSize: 17,
                                      //   itemPadding: const EdgeInsets.symmetric(
                                      //       horizontal: 2.0),
                                      //   itemBuilder: (context, _) => const Icon(
                                      //     Icons.star,
                                      //     color: Colors.amber,
                                      //   ),
                                      //   onRatingUpdate: (rating) {
                                      //     // Handle rating update if needed
                                      //   },
                                      // ),

                                      //add a comment for food
                                      const SizedBox(height: 5),

                                      Container(
                                        height: 85,
                                        width: 280,
                                        child: Text(data[index].review),
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
                  );
                });
          });
        }),
      ),
    );
  }
}
