import 'package:eatmore/utils/const.dart';
import 'package:eatmore/utils/instence.dart';
import 'package:eatmore/view%20model/database.dart';
import 'package:eatmore/view/modules/admin/homepagefoodlist.dart';
import 'package:eatmore/view/modules/user/menudetails.dart';
import 'package:eatmore/view/modules/user/ourmenuelist.dart';
import 'package:eatmore/view/modules/user/userprofile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class UserHome extends StatelessWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final instence = Provider.of<Database>(context);
    // print(instence.usermodel?.email);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Home",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserProfile(),
                    ));
              },
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UserProfile(),
                        ));
                  },
                  icon: const Icon(CupertinoIcons.person)),
            ),
            const SizedBox(width: 25),
          ],
        ),
        body: FutureBuilder(
            future: instence
                .fethcurrentUser(FirebaseAuth.instance.currentUser!.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return indicator;
                // showDialog(
                //     context: context,
                //     builder: (context) => const Center(
                //           child: CircularProgressIndicator(),
                //         ));
              }
              return SingleChildScrollView(
                child: Column(children: [
                  const SizedBox(height: 15),
                  Card(
                    margin: const EdgeInsets.all(10),
                    elevation: 5,
                    child: Container(
                      height: height * .22,
                      width: width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [HexColor("E1FED3"), Colors.white],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            // "${database.usermodel?.email}",
                            "What would you",
                            style: TextStyle(
                              color: HexColor("32343E"),
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                          Text(
                            //  "${instence.usermodel?.email}",
                            "like to order?",
                            style: TextStyle(
                              color: HexColor("32343E"),
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, bottom: 20),
                            child: SizedBox(
                                height: 55,
                                child: TextField(
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: HexColor("ADAAAA"),
                                      ),
                                      hintText: "Search our products...",
                                      hintStyle:
                                          TextStyle(color: HexColor("A8A7A7")),
                                      filled: true,
                                      fillColor: Colors.white,
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide.none)),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: height * .05),
                    child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          " Our Menu",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        )),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: SizedBox(
                      height: height * .12,
                      width: width,
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            width: 20,
                          );
                        },
                        scrollDirection: Axis.horizontal,
                        itemCount: Menue.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MenuDetails(
                                        name: Menue[index]['name'],
                                        img: Menue[index]['img'],
                                        price: Menue[index]['rate']),
                                  ));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  radius: 38,
                                  backgroundColor: Colors.white,
                                  backgroundImage: Menue[index]['img'],
                                ),
                                Text(
                                  Menue[index]['name'],
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20, top: height * .08, bottom: 10),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Popular",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width,
                    height: height * .22,
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 20,
                        );
                      },
                      padding: const EdgeInsets.all(5),
                      scrollDirection: Axis.horizontal,
                      itemCount: Popular.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          // height: height * .14,
                          // width: width * .45,
                          child: Column(
                            children: [
                              Container(
                                height: height *
                                    .15, // Set a specific height for the image container
                                width: width * .53,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: Popular[index]['image'],
                                    ),
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        Popular[index]['title'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        Popular[index]['rate'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  // RatingBar.builder(
                                  // initialRating: 4.5,
                                  // minRating: 1,
                                  // direction: Axis.horizontal,
                                  // allowHalfRating: true,
                                  // itemCount: 5,
                                  // itemSize: 15,
                                  // itemBuilder: (context, _) => Icon(
                                  // Icons.star,
                                  // color: HexColor("FFE120"),
                                  // ),
                                  // onRatingUpdate: (rating) {
                                  // // Handle rating updates here
                                  // print(rating);
                                  // },
                                  // ),

                                  Popular[index]['ratingbar']
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ]),
              );
            }),
      ),
    );
  }
}
