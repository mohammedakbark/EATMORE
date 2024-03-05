import 'package:eatmore/model/add_new_item.dart';
import 'package:eatmore/utils/const.dart';
import 'package:eatmore/view%20model/database.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../admin/homepagefoodlist.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  var Payments;
  bool isFavorite = false; // Initial favorite state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          title: const Text(
            "Favorite",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Consumer<Database>(builder: (context, datab, child) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              // Padding(
              //   padding: const EdgeInsets.only(left: 15.0, right: 15),
              //   child: TextField(
              //     decoration: InputDecoration(
              //       hintText: "Search ",
              //       hintStyle: TextStyle(color: HexColor("ADAAAA")),
              //       prefixIcon: Icon(
              //         Icons.search,
              //         color: HexColor("ADAAAA"),
              //       ),
              //       fillColor: HexColor("E1FED3"),
              //       filled: true,
              //       enabledBorder: OutlineInputBorder(
              //         borderSide: BorderSide.none,
              //         borderRadius: BorderRadius.circular(25),
              //       ),
              //       focusedBorder: OutlineInputBorder(
              //         borderSide: BorderSide.none,
              //         borderRadius: BorderRadius.circular(25),
              //       ),
              //       contentPadding: const EdgeInsets.only(
              //           left: 10,
              //           top: 10,
              //           bottom: 10), // Adjust the left padding here
              //     ),
              //   ),
              // ),
              FutureBuilder(
                  future: datab.fetchAllFav(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return indicator;
                    }
                    return Expanded(
                      child: datab.favList.isEmpty
                          ? const Center(
                              child: Text("No favorates"),
                            )
                          : ListView.separated(
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    title: Text(datab.favList[index].name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    leading: Container(
                                      height: 100,
                                      width: 95,
                                      decoration: BoxDecoration(
                                        color: HexColor("F3EFEF"),
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                datab.favList[index].img)),
                                      ),
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(
                                        Icons.favorite,

                                        color: Colors
                                            .red, // Customize the color as needed
                                      ),
                                      onPressed: () {
                                        datab.deletefromFav(
                                            datab.favList[index].proID);
                                      },
                                    ),
                                    subtitle: Text(
                                        "₹${datab.favList[index].price}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemCount: datab.favList.length),
                    );
                  })
            ]),
          );
        }));
  }
}
