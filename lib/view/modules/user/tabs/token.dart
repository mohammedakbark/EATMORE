import 'package:eatmore/utils/const.dart';
import 'package:eatmore/view%20model/database.dart';
import 'package:eatmore/view/modules/admin/homepagefoodlist.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class Tokens extends StatefulWidget {
  const Tokens({Key? key}) : super(key: key);

  @override
  State<Tokens> createState() => _TokensState();
}

class _TokensState extends State<Tokens> {
 

  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Token",
              style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Consumer<Database>(builder: (context, database, child) {
          return FutureBuilder(
              future: database.fetchCurrentUserOrder(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return indicator;
                }

                final data = database.currentUserOrderList;
                return data.isEmpty
                    ? const Center(
                        child: Text("No orders..."),
                      )
                    : ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 20,
                            ),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: width,
                            child: Center(
                              child: Stack(children: [
                                Center(
                                  child: Container(
                                    height: 150,
                                    width: width * .85,
                                    decoration: BoxDecoration(
                                      color: HexColor("E1FED3"),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              height: 70,
                                              width: 75,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      data[index]
                                                          .cartItemModel
                                                          .itemImage),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Token No   :${data[index].tokenNo}",
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16.55),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    data[index]
                                                        .cartItemModel
                                                        .itemName
                                                        .toUpperCase(),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "Quantity :${data[index].cartItemModel.quantity}",
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "Pyment :${data[index].paymentMode}",
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Text(
                                                data[index].orderdateAndTime,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: HexColor("9C9BA6")),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  bottom: 0,
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 25,
                                        ),
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 25,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          );
                        });
              });
        }));
  }
}
