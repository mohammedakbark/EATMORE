import 'package:eatmore/model/add_new_item.dart';
import 'package:eatmore/utils/const.dart';
import 'package:eatmore/utils/instence.dart';
import 'package:eatmore/view%20model/database.dart';
import 'package:eatmore/view/modules/admin/homepagefoodlist.dart';
import 'package:eatmore/view/modules/user/menudetails.dart';
import 'package:eatmore/view/modules/user/userprofile.dart';
import 'package:eatmore/view/widgets/rating_bar.dart';
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
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
                }
                final data = instence.itemList;

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
                                        hintStyle: TextStyle(
                                            color: HexColor("A8A7A7")),
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
                          child: data.isEmpty
                              ? const Center(
                                  child: Text("Loading..."),
                                )
                              : ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      width: 20,
                                    );
                                  },
                                  scrollDirection: Axis.horizontal,
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => MenuDetails(
                                                  itemId: data[index].itemId!,
                                                  name: data[index].itemName,
                                                  rating: data[index].rating,
                                                  details:
                                                      data[index].moreDetail,
                                                  img: data[index].itemImage,
                                                  price: data[index].itemPrice),
                                            ));
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CircleAvatar(
                                            radius: 38,
                                            backgroundColor: Colors.white,
                                            backgroundImage: NetworkImage(
                                                data[index].itemImage),
                                          ),
                                          Text(
                                            data[index]
                                                    .itemName[0]
                                                    .toUpperCase() +
                                                data[index]
                                                    .itemName
                                                    .substring(1),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                )),
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
                      child: instence.popularItemsList.isEmpty
                          ? const Center(
                              child: Text("Loading..!"),
                            )
                          : ListView.separated(
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  width: 20,
                                );
                              },
                              padding: const EdgeInsets.all(5),
                              scrollDirection: Axis.horizontal,
                              itemCount: instence.popularItemsList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MenuDetails(
                                              itemId: data[index].itemId!,
                                              name: data[index].itemName,
                                              rating: data[index].rating,
                                              details: data[index].moreDetail,
                                              img: data[index].itemImage,
                                              price: data[index].itemPrice),
                                        ));
                                  },
                                  child: SizedBox(
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
                                                image: NetworkImage(instence
                                                    .popularItemsList[index]
                                                    .itemImage),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: width * .5,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      instence
                                                          .popularItemsList[
                                                              index]
                                                          .itemName
                                                          .toUpperCase(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      " ₹ ${double.parse(instence.popularItemsList[index].itemPrice)}",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              ratingBar(
                                                  data[index].rating.toDouble())
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    )
                  ]),
                );
              })),
    );
  }
}
