import 'package:eatmore/utils/const.dart';
import 'package:eatmore/view%20model/controller.dart';
import 'package:eatmore/view%20model/database.dart';
import 'package:eatmore/view/modules/user/payment.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class Carts extends StatefulWidget {
  @override
  State<Carts> createState() => _CartsState();
}

class _CartsState extends State<Carts> {
  bool isFavorite = false; // Initial favorite state
  // Initial quantity

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Database>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text(
          "Cart",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder(
            future: provider.fetchCartItems(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return indicator;
              }
              final data = provider.cartList;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, right: 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 11.0),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 95,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: HexColor("F3EFEF"),
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image:
                                          NetworkImage(data[index].itemImage)),
                                ),
                              ),
                              Consumer2<Controller, Database>(builder:
                                  (context, controller, database, child) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: SizedBox(
                                    width: 235,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              data[index]
                                                  .itemName
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  color: HexColor("605E5E"),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  database.removeFromCart(
                                                      data[index].cartId);
                                                },
                                                icon: const Icon(
                                                  Icons.close_rounded,
                                                  size: 15,
                                                  color: Colors.black,
                                                ))
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                const SizedBox(height: 5),
                                                Text(
                                                  "₹${controller.totatlPrice.toDouble().toStringAsFixed(2)}",

                                                  // '₹${(controller.quantity * data[index].itemPrice)).toStringAsFixed(2)}', // Dynamic rate calculation
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(height: 5),
                                              ],
                                            ),
                                            const SizedBox(width: 65),
                                            Row(
                                              children: [
                                                IconButton(
                                                    style: ButtonStyle(
                                                        shape: MaterialStatePropertyAll(
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8))),
                                                        backgroundColor:
                                                            MaterialStatePropertyAll(
                                                                HexColor(
                                                                    "F3EFEF"))),
                                                    onPressed: () {
                                                      controller
                                                          .incrementQunatity(
                                                              data[index]
                                                                  .itemPrice);
                                                    },
                                                    icon:
                                                        const Icon(Icons.add)),
                                                const SizedBox(width: 5),
                                                Text(
                                                  controller.quantity
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(width: 5),
                                                IconButton(
                                                    style: ButtonStyle(
                                                        shape: MaterialStatePropertyAll(
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8))),
                                                        backgroundColor:
                                                            MaterialStatePropertyAll(
                                                                HexColor(
                                                                    "F3EFEF"))),
                                                    onPressed: () {
                                                      if (controller.quantity >
                                                          0) {
                                                        controller
                                                            .decrementQunatity(
                                                                data[index]
                                                                    .itemPrice);
                                                      }
                                                    },
                                                    icon: const Icon(
                                                        Icons.remove))
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Payment(),
                  ));
            },
            child: Container(
              alignment: Alignment.center,
              height: 50,
              width: 315,
              decoration: BoxDecoration(
                  color: HexColor("54E70F"),
                  borderRadius: BorderRadius.circular(25)),
              child: const Text("Proceed to Buy",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ),
    );
  }
}
