import 'package:eatmore/model/addNewReview.dart';
import 'package:eatmore/utils/const.dart';
import 'package:eatmore/utils/instence.dart';
import 'package:eatmore/view%20model/controller.dart';
import 'package:eatmore/view%20model/database.dart';
import 'package:eatmore/view/modules/user/navigation_user.dart';
import 'package:eatmore/view/widgets/rating_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({super.key});

  @override
  State<FeedBack> createState() => _FeedBackState();
}

String idd = "";
final textController = TextEditingController();
double ratings = 0.0;
final _formkey = GlobalKey<FormState>();

class _FeedBackState extends State<FeedBack> {
    String date = DateFormat("dd/m/yyyy").format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<Controller>(context);
    return Scaffold(
        appBar: AppBar(
            // leading: IconButton(onPressed: () {}, icon: Icon(Icons.close)),

            // title: Row(
            //   children: [
            //     Container(
            //       height: 55,
            //       width: 50,
            //       decoration: BoxDecoration(
            //         color: HexColor("F3EFEF"),
            //         borderRadius: BorderRadius.circular(10),
            //         image: DecorationImage(
            //             fit: BoxFit.cover,
            //             image: AssetImage("img/samosa 1 (1).png")),
            //       ),
            //     ),
            //     SizedBox(
            //       width: 10,
            //     ),
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           "Samosa",
            //           style: TextStyle(fontWeight: FontWeight.bold),
            //         ),
            //         Text("Rate this item",
            //             style: TextStyle(color: HexColor("605E5E"), fontSize: 14)),
            //       ],
            //     ),
            //   ],
            // ),
            ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Consumer<Database>(builder: (context, datab, child) {
                  datab.fetchAllCatergoryItem();
                  final data = datab.selectedCategoryItem;
                  return DropdownButtonFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "select product before submit";
                        } else {
                          return null;
                        }
                      },
                      hint: const Text("Select item "),
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                      items: data.map((e) {
                        return DropdownMenuItem(
                            value: e.itemId, child: Text(e.itemName));
                      }).toList(),
                      onChanged: (value) {
                        idd = value!;
                        // datab
                        //     .fetchSelectedProductImage(value)
                        //     .then((value) {
                        //   datab.listen();
                        // });
                      });
                }),

                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  controller: textController,
                  maxLines: 5,
                  decoration: InputDecoration(
                      hintText: "Describe your experience (optional)",
                      filled: true,
                      fillColor: HexColor("EDEDED"),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8))),
                ),

                const SizedBox(
                  height: 50,
                ),
                const Align(
                    alignment: Alignment.centerLeft, child: Text("Rate me")),
                RatingBar.builder(
                  // initialRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: MediaQuery.of(context).size.width * .1,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: HexColor("FFE120"),
                  ),
                  onRatingUpdate: (rating) {
                    ratings = rating;
                    // Handle rating updates here
                    print(ratings);
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        if (idd == null || idd.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Pick the product")));
                        } else {
                          if (ratings <= 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("rate the product")));
                          } else {
                            database
                                .addNewReview(AddNewReview(
                                  date: date,
                                    proId: idd,
                                    rating: ratings,
                                    review: textController.text ?? "",
                                    uid:
                                        FirebaseAuth.instance.currentUser!.uid))
                                .then((value) {
                              idd = "";
                              textController.clear();
                              ratings = 0.0;
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) =>
                                    const UserBottomNavigation(),
                              ));
                            });
                          }
                        }
                      },
                      child: Text(
                        "Post",
                        style:
                            TextStyle(color: HexColor("54E70F"), fontSize: 20),
                      )),
                )
                // FutureBuilder(future: datab.fetchSelectedProductImage(proId), builder: builder)
              ],
            ),
          ),
        )

        // body: Container(
        //   height: MediaQuery.of(context).size.height,
        //   width: MediaQuery.of(context).size.width,
        //   child: Column(
        //     children: [
        //       SizedBox(
        //         height: 22,
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.only(left: 11.0),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           children: [
        //             CircleAvatar(
        //               radius: 40,
        //               backgroundColor: HexColor("E1FED3"),
        //               child: const Icon(
        //                 Icons.person_outline,
        //                 size: 35,
        //               ),
        //             ),
        //             const SizedBox(
        //               width: 25,
        //             ),
        //             Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 const Text(
        //                   "MUHAMMED V",
        //                   style: TextStyle(
        //                       fontWeight: FontWeight.bold, fontSize: 15),
        //                 ),
        //                 Text(
        //                   "Reviews are public.",
        //                   style: TextStyle(color: HexColor("A0A5BA")),
        //                 ),
        //               ],
        //             ),
        //           ],
        //         ),
        //       ),
        //       RatingBar.builder(
        //         initialRating: 4.5,
        //         minRating: 1,
        //         direction: Axis.horizontal,
        //         allowHalfRating: true,
        //         itemCount: 5,
        //         itemSize: 25,
        //         itemBuilder: (context, _) => Icon(
        //           Icons.star,
        //           color: HexColor("FFE120"),
        //         ),
        //         onRatingUpdate: (rating) {
        //           // Handle rating updates here
        //           print(rating);
        //         },
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.only(left: 12.0, right: 12, top: 13),
        //         child: TextField(
        //           maxLines: 5,
        //           decoration: InputDecoration(
        //               hintText: "Describe your experience (optional)",
        //               filled: true,
        //               fillColor: HexColor("EDEDED"),
        //               focusedBorder: OutlineInputBorder(
        //                   borderSide: BorderSide.none,
        //                   borderRadius: BorderRadius.circular(8)),
        //               enabledBorder: OutlineInputBorder(
        //                   borderSide: BorderSide.none,
        //                   borderRadius: BorderRadius.circular(8))),
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        );
  }
}
