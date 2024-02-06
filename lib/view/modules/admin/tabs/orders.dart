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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text(
          "Orders",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0, top: 5, right: 5),
          child: SizedBox(
            height: 655,
            child: Consumer<Database>(builder: (context, database, child) {
              return FutureBuilder(
                  future: database.fetchUserOrders(),
                  builder: (context, snapshpt) {
                    if (snapshpt.connectionState == ConnectionState.waiting) {
                      return indicator;
                    }

                    final data = database.allUsersOrderList;

                    return data.isEmpty
                        ? const Center(
                            child: Text("No orders Found"),
                          )
                        : ListView.separated(
                            separatorBuilder: (context, index) => const Divider(
                              thickness: .2,
                            ),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 11.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 95,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(data[index]
                                                .cartItemModel
                                                .itemImage),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 5.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                data[index]
                                                    .cartItemModel
                                                    .itemName,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const SizedBox(height: 5),
                                            Text(
                                                "Token No. ${data[index].tokenNo}",
                                                style: TextStyle(
                                                    color: HexColor("9C9BA6"))),
                                            const SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        "Quantity :${data[index].cartItemModel.quantity.toString()}",
                                                        style: TextStyle(
                                                            color: HexColor(
                                                                "9C9BA6"))),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                        "₹ ${data[index].cartItemModel.itemPrice}",
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    const SizedBox(height: 5),
                                                  ],
                                                ),
                                                const SizedBox(width: 85),
                                                GestureDetector(
                                                  onTap: () {
                                                    // database
                                                    //     .updatebroughtProductStatus(
                                                    //         data[index].id,
                                                    //         data[index].status ==
                                                    //                 "PENDING"
                                                    //             ? "ACCEPTED"
                                                    //             : "PENDING");
                                                    // // Toggle the order status between "Pending" and "Accepted";
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 44,
                                                    width: 66,
                                                    decoration: BoxDecoration(
                                                      border: data[index]
                                                                  .status ==
                                                              "PENDING"
                                                          ? Border.all(
                                                              color: HexColor(
                                                                  "FF3326"))
                                                          : null,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      color: data[index]
                                                                  .status ==
                                                              "DONE"
                                                          ? HexColor("54E70F")
                                                          : null,
                                                    ),
                                                    child: Text(
                                                      data[index].status,
                                                      style: TextStyle(
                                                        color: data[index]
                                                                    .status ==
                                                                "DONE"
                                                            ? Colors.white
                                                            : HexColor(
                                                                "FF3326"),
                                                      ),
                                                    ),
                                                  ),
                                                ),
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
                          );
                  });
            }),
          ),
        ),
      ),
    );
  }
}
