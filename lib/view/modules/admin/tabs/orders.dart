import 'package:eatmore/utils/const.dart';
import 'package:eatmore/view%20model/database.dart';
import 'package:eatmore/view/modules/admin/homepagefoodlist.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final hight = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            // leading: IconButton(
            //   onPressed: () {},
            //   icon: const Icon(Icons.arrow_back_ios_new_rounded),
            // ),
            title: const Text(
              "Orders History",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(hight * .03),
                child: const TabBar(tabs: [
                  Tab(
                    child: Text("O R D E R"),
                  ),
                  Tab(
                    child: Text("P R E - O R D E R"),
                  )
                ])),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Consumer<Database>(builder: (context, database, child) {
              return TabBarView(
                children: [
                  FutureBuilder(
                      future: database.fetchUserOrders(),
                      builder: (context, snapshpt) {
                        if (snapshpt.connectionState ==
                            ConnectionState.waiting) {
                          return indicator;
                        }

                        final data = database.allUsersOrderList;

                        return data.isEmpty
                            ? const Center(
                                child: Text("No orders Found"),
                              )
                            : ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                  height: 20,
                                  color: Colors.black,
                                  thickness: .2,
                                ),
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(right: width * .08),
                                    // color: Colors.amber,
                                    height: hight *
                                        data[index].cartItemModel.length *
                                        .13,
                                    width: width * .7,
                                    child: ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            data[index].cartItemModel.length,
                                        itemBuilder: (context, cartItemIndex) {
                                          return Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 11.0),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: 95,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(data[
                                                                index]
                                                            .cartItemModel[
                                                                cartItemIndex]
                                                            .itemImage),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            data[index]
                                                                .cartItemModel[
                                                                    cartItemIndex]
                                                                .itemName,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        const SizedBox(
                                                            height: 5),
                                                        Text(
                                                            "Token No. ${data[index].tokenNo}",
                                                            style: TextStyle(
                                                                color: HexColor(
                                                                    "9C9BA6"))),
                                                        const SizedBox(
                                                            height: 5),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                    "Quantity :${data[index].cartItemModel[cartItemIndex].quantity.toString()}",
                                                                    style: TextStyle(
                                                                        color: HexColor(
                                                                            "9C9BA6"))),
                                                                const SizedBox(
                                                                    height: 5),
                                                                Text(
                                                                    "₹ ${data[index].cartItemModel[cartItemIndex].itemPrice}",
                                                                    style: const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                                const SizedBox(
                                                                    height: 5),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                                width: 85),
                                                            statustText(
                                                                data[index]
                                                                    .status),
                                                            // GestureDetector(
                                                            //   onTap: () {
                                                            //     // database
                                                            //     //     .updatebroughtProductStatus(
                                                            //     //         data[index].id,
                                                            //     //         data[index].status ==
                                                            //     //                 "PENDING"
                                                            //     //             ? "ACCEPTED"
                                                            //     //             : "PENDING");
                                                            //     // // Toggle the order status between "Pending" and "Accepted";
                                                            //   },
                                                            //   child: Container(
                                                            //     alignment:
                                                            //         Alignment
                                                            //             .center,
                                                            //     height: 44,
                                                            //     width: 66,
                                                            //     decoration:
                                                            //         BoxDecoration(
                                                            //       border: data[index]
                                                            //                   .status ==
                                                            //               "PENDING"
                                                            //           ? Border.all(
                                                            //               color:
                                                            //                   HexColor("FF3326"))
                                                            //           : null,
                                                            //       borderRadius:
                                                            //           BorderRadius
                                                            //               .circular(
                                                            //                   6),
                                                            //       color: data[index]
                                                            //                   .status ==
                                                            //               "DONE"
                                                            //           ? HexColor(
                                                            //               "54E70F")
                                                            //           : null,
                                                            //     ),

                                                            //   ),
                                                            // ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  );
                                },
                              );
                      }),
                  FutureBuilder(
                    future: database.fetchAllPreOrderOrders(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return indicator;
                      }
                      final data = database.allPreOrderList;
                      return ListView.separated(
                        separatorBuilder: (context, index) => const Divider(
                          endIndent: 20,
                          indent: 20,
                        ),
                        itemBuilder: (context, index) {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 11.0),
                              child: Row(
                                children: [
                                  FutureBuilder(
                                      future:
                                          database.fetchSelectedProductImage(
                                              data[index].itemId),
                                      builder: (context, snap) {
                                        if (snap.connectionState ==
                                            ConnectionState.waiting) {
                                          return const SizedBox(
                                            height: 95,
                                            width: 100,
                                          );
                                        }
                                        return Container(
                                          height: 95,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  snap.data!.itemImage),
                                            ),
                                          ),
                                        );
                                      }),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(data[index].itemName,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 5),
                                        Text("Token No. ${data[index].tokenNo}",
                                            style: TextStyle(
                                                color: HexColor("9C9BA6"))),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "Quantity :${data[index].quantity.toString()}",
                                                    style: TextStyle(
                                                        color: HexColor(
                                                            "9C9BA6"))),
                                                const SizedBox(height: 5),
                                                Text("₹ ${data[index].price}",
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                const SizedBox(height: 5),
                                              ],
                                            ),
                                            const SizedBox(width: 85),
                                            statustText(data[index].status)
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: data.length,
                      );
                    },
                  )
                ],
              );
            }),
          )),
    );
  }

  statustText(status) {
    switch (status) {
      case "DONE":
        {
          return const Text(
            'Completed',
            style: TextStyle(color: Colors.green),
          );
        }
      case "PENDING":
        {
          return const Text(
            'Pending',
            style: TextStyle(color: Colors.red),
          );
        }
      case "CANCELED":
        {
          return const Text(
            'Canceled',
            style: TextStyle(color: Colors.grey),
          );
        }
    }
  }
}
