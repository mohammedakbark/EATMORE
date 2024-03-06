import 'package:eatmore/utils/const.dart';
import 'package:eatmore/view%20model/database.dart';
import 'package:eatmore/view/modules/admin/profile.dart';
import 'package:eatmore/view/modules/admin/tabs/myfoodlist.dart';
import 'package:eatmore/view/widgets/rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final higth = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Home",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Profile(),
                      ));
                },
                icon: const Icon(CupertinoIcons.person)),
            const SizedBox(width: 25),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 15),
            Consumer<Database>(builder: (context, database, child) {
              return FutureBuilder(
                  future: database.calculatePendingOrderLength(),
                  builder: (context, snapshot) {
                    return GestureDetector(
                      onTap: () {
                        final data = database.pendingOrdersList;
                        showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadiusDirectional.only(
                                topEnd: Radius.circular(25),
                                topStart: Radius.circular(25),
                              ),
                            ),
                            builder: (context) {
                              return DefaultTabController(
                                length: 2,
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.8, // Set your desired height here
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    children: [
                                      const TabBar(tabs: [
                                        Tab(
                                          child: Text("O R D E R"),
                                        ),
                                        Tab(
                                          child: Text("P R E - O R D E R"),
                                        )
                                      ]),
                                      Expanded(
                                        child: TabBarView(children: [
                                          Consumer<Database>(builder:
                                              (context, instence, child) {
                                            return FutureBuilder(
                                                future: instence
                                                    .fetchpendingOrder(),
                                                builder: (context, snapshot) {
                                                  return Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                        width: 40,
                                                        height: 3,
                                                        color:
                                                            HexColor("C1C8D2"),
                                                      ),
                                                      const SizedBox(
                                                          height: 19),
                                                      // Add your content here
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "${instence.pendingOrdersList.length} Pending Orders",
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 20,
                                                                right: 20),
                                                        child: SizedBox(
                                                          // color: Colors.red,
                                                          height: 655,
                                                          child: data.isEmpty
                                                              ? const Center(
                                                                  child: Text(
                                                                      "No Pending Orders"),
                                                                )
                                                              : snapshot.connectionState ==
                                                                      ConnectionState
                                                                          .waiting
                                                                  ? indicator
                                                                  : ListView
                                                                      .builder(
                                                                      itemCount:
                                                                          data.length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            SizedBox(
                                                                              // color: Colors.red,
                                                                              // height: 200,
                                                                              height: higth * data[index].cartItemModel.length * .13,
                                                                              width: width * .7,
                                                                              child: ListView.builder(
                                                                                  physics: const NeverScrollableScrollPhysics(),
                                                                                  itemCount: data[index].cartItemModel.length,
                                                                                  itemBuilder: (context, cartItemIndex) {
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
                                                                                                borderRadius: BorderRadius.circular(10),
                                                                                                image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(instence.pendingOrdersList[index].cartItemModel[cartItemIndex].itemImage)),
                                                                                              ),
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: const EdgeInsets.only(left: 5.0),
                                                                                              child: Column(
                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                children: [
                                                                                                  Text(instence.pendingOrdersList[index].cartItemModel[cartItemIndex].itemName, style: const TextStyle(fontWeight: FontWeight.bold)),
                                                                                                  const SizedBox(height: 5),
                                                                                                  Text("Token No. ${instence.pendingOrdersList[index].tokenNo}", style: TextStyle(color: HexColor("9C9BA6"))),
                                                                                                  const SizedBox(height: 5),
                                                                                                  Row(
                                                                                                    children: [
                                                                                                      Column(
                                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                        children: [
                                                                                                          Text("Quantity ${instence.pendingOrdersList[index].cartItemModel[cartItemIndex].quantity}", style: TextStyle(color: HexColor("9C9BA6"))),
                                                                                                          const SizedBox(height: 5),
                                                                                                          Text("₹ ${instence.pendingOrdersList[index].cartItemModel[cartItemIndex].itemPrice}", style: const TextStyle(fontWeight: FontWeight.bold)),
                                                                                                          const SizedBox(height: 5),
                                                                                                        ],
                                                                                                      ),
                                                                                                      const SizedBox(width: 5),
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
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                InkWell(
                                                                                  onTap: () {
                                                                                    if (instence.pendingOrdersList[index].status == "PENDING") {
                                                                                      instence.updatebroughtProductStatus(data[index].purchaseId, "DONE");
                                                                                      // instence.fetchpendingOrder(true);
                                                                                    }
                                                                                  },
                                                                                  child: Container(
                                                                                    alignment: Alignment.center,
                                                                                    height: 44,
                                                                                    width: 65,
                                                                                    decoration: BoxDecoration(
                                                                                      color: HexColor("54E70F"),
                                                                                      borderRadius: BorderRadius.circular(6),
                                                                                    ),
                                                                                    child: const Text("Done", style: TextStyle(color: Colors.white)),
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(width: 5),
                                                                                InkWell(
                                                                                  onTap: () {
                                                                                    if (instence.pendingOrdersList[index].status == "PENDING") {
                                                                                      instence.updatebroughtProductStatus(data[index].purchaseId, "CANCELED");
                                                                                      // instence.fetchpendingOrder(true);
                                                                                    }
                                                                                  },
                                                                                  child: Container(
                                                                                    alignment: Alignment.center,
                                                                                    height: 44,
                                                                                    width: 66,
                                                                                    decoration: BoxDecoration(
                                                                                      border: Border.all(color: HexColor("FF3326")),
                                                                                      borderRadius: BorderRadius.circular(6),
                                                                                    ),
                                                                                    child: Text("Cancel", style: TextStyle(color: HexColor("FF3326"))),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )
                                                                          ],
                                                                        );
                                                                      },
                                                                    ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                });
                                          }),
                                          //----------------------------------------pre order
                                          SingleChildScrollView(
                                            padding: const EdgeInsetsDirectional
                                                .only(
                                              start: 20,
                                              end: 20,
                                              bottom: 30,
                                              top: 8,
                                            ),
                                            // Add your content here

                                            child: Consumer<Database>(builder:
                                                (context, instence, child) {
                                              return FutureBuilder(
                                                  future: instence
                                                      .fetchPEndingPreOrder(),
                                                  builder: (context, snapshot) {
                                                    return Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Container(
                                                          width: 40,
                                                          height: 3,
                                                          color: HexColor(
                                                              "C1C8D2"),
                                                        ),
                                                        const SizedBox(
                                                            height: 19),
                                                        // Add your content here
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "${instence.prependingOrderList.length} Pending Orders",
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        SizedBox(
                                                            height: 655,
                                                            child: instence
                                                                    .prependingOrderList
                                                                    .isEmpty
                                                                ? const Center(
                                                                    child: Text(
                                                                        "No Pending Orders"),
                                                                  )
                                                                : snapshot.connectionState ==
                                                                        ConnectionState
                                                                            .waiting
                                                                    ? indicator
                                                                    : SizedBox(
                                                                        height:
                                                                            200,
                                                                        width: double
                                                                            .infinity,
                                                                        child: ListView.builder(
                                                                            itemCount: instence.prependingOrderList.length,
                                                                            itemBuilder: (context, index) {
                                                                              return Align(
                                                                                alignment: Alignment.centerLeft,
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.only(top: 11.0),
                                                                                  child: Row(
                                                                                    children: [
                                                                                      FutureBuilder(
                                                                                          future: instence.fetchSelectedProductImage(instence.prependingOrderList[index].itemId),
                                                                                          builder: (context, snap) {
                                                                                            if (snap.connectionState == ConnectionState.waiting) {
                                                                                              return const SizedBox(
                                                                                                height: 95,
                                                                                                width: 100,
                                                                                              );
                                                                                            }
                                                                                            return Container(
                                                                                              height: 95,
                                                                                              width: 100,
                                                                                              decoration: BoxDecoration(
                                                                                                borderRadius: BorderRadius.circular(10),
                                                                                                image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(snap.data!.itemImage)),
                                                                                              ),
                                                                                            );
                                                                                          }),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.only(left: 5.0),
                                                                                        child: Column(
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            Text(instence.prependingOrderList[index].itemName, style: const TextStyle(fontWeight: FontWeight.bold)),
                                                                                            const SizedBox(height: 5),
                                                                                            Text("Token No. ${instence.prependingOrderList[index].tokenNo}", style: TextStyle(color: HexColor("9C9BA6"))),
                                                                                            const SizedBox(height: 5),
                                                                                            Row(
                                                                                              children: [
                                                                                                Column(
                                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                  children: [
                                                                                                    Text("Quantity ${instence.prependingOrderList[index].quantity}", style: TextStyle(color: HexColor("9C9BA6"))),
                                                                                                    const SizedBox(height: 5),
                                                                                                    Text("₹ ${instence.prependingOrderList[index].price}", style: const TextStyle(fontWeight: FontWeight.bold)),
                                                                                                    const SizedBox(height: 5),
                                                                                                  ],
                                                                                                ),
                                                                                                const SizedBox(width: 5),
                                                                                                InkWell(
                                                                                                  onTap: () {
                                                                                                    if (instence.prependingOrderList[index].status == "PENDING") {
                                                                                                      instence.updatepreOrderStatus(instence.prependingOrderList[index].prebookId, "DONE");
                                                                                                      // instence.fetchpendingOrder(true);
                                                                                                    }
                                                                                                  },
                                                                                                  child: Container(
                                                                                                    alignment: Alignment.center,
                                                                                                    height: 44,
                                                                                                    width: 65,
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: HexColor("54E70F"),
                                                                                                      borderRadius: BorderRadius.circular(6),
                                                                                                    ),
                                                                                                    child: const Text("Done", style: TextStyle(color: Colors.white)),
                                                                                                  ),
                                                                                                ),
                                                                                                const SizedBox(width: 5),
                                                                                                InkWell(
                                                                                                  onTap: () {
                                                                                                    if (instence.prependingOrderList[index].status == "PENDING") {
                                                                                                      instence.updatepreOrderStatus(instence.prependingOrderList[index].prebookId, "CANCELED");
                                                                                                      // instence.fetchpendingOrder(true);
                                                                                                    }
                                                                                                  },
                                                                                                  child: Container(
                                                                                                    alignment: Alignment.center,
                                                                                                    height: 44,
                                                                                                    width: 66,
                                                                                                    decoration: BoxDecoration(
                                                                                                      border: Border.all(color: HexColor("FF3326")),
                                                                                                      borderRadius: BorderRadius.circular(6),
                                                                                                    ),
                                                                                                    child: Text("Cancel", style: TextStyle(color: HexColor("FF3326"))),
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
                                                                            }),
                                                                      )),
                                                      ],
                                                    );
                                                  });
                                            }),
                                          ),
                                        ]),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: Container(
                        height: 105,
                        width: 310,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: HexColor("E1FED3"),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            snapshot.connectionState == ConnectionState.waiting
                                ? indicator
                                : Text(
                                    database.allPendingOrderLength == null
                                        ? "0"
                                        : "${database.allPendingOrderLength}",
                                    style: TextStyle(
                                      color: HexColor("32343E"),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40,
                                    ),
                                  ),
                            Text(
                              "PENDING ORDERS",
                              style: TextStyle(color: HexColor("838799")),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }),
            const SizedBox(height: 9),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text("Total Revenue",
                        style: TextStyle(color: HexColor("32343E"))),
                    Consumer<Database>(builder: (context, instence, child) {
                      return Text(
                          "₹${instence.totalRevenue.toStringAsFixed(2)}",
                          style: TextStyle(
                              color: HexColor("000000"),
                              fontWeight: FontWeight.bold));
                    }),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: HexColor("C4C4C4"))),
                  child: Row(
                    children: [
                      const SizedBox(width: 5),
                      Text("Daily",
                          style: TextStyle(color: HexColor("9C9BA6"))),
                      const Icon(Icons.arrow_drop_down),
                      const SizedBox(width: 5),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text("See Details",
                        style: TextStyle(color: HexColor("54E70F"))),
                    Container(
                        height: 1.5, width: 75, color: HexColor("54E70F")),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Line Chart
            //Expanded(
            //   child: Padding(
            //     padding: const EdgeInsets.all(16.0),
            //     child: LineChart(
            //       LineChartData(
            //         gridData: FlGridData(show: false),
            //         titlesData: FlTitlesData(
            //           bottomTitles: SideTitles(
            //             showTitles: true,
            //             getTitles: (value) {
            //               switch (value.toInt()) {
            //                 case 0:
            //                   return '10AM';
            //                 case 1:
            //                   return '11AM';
            //                 case 2:
            //                   return '12PM';
            //                 case 3:
            //                   return '01PM';
            //                 case 4:
            //                   return '02PM';
            //                 case 5:
            //                   return '03PM';
            //                 case 6:
            //                   return '04PM';
            //                 default:
            //                   return '';
            //               }
            //             },
            //           ),
            //           leftTitles: SideTitles(showTitles: false),
            //           topTitles: null,
            //           rightTitles: null,
            //         ),
            //         borderData: FlBorderData(show: false),
            //         minX: 0,
            //         maxX: 6,
            //         minY: 0,
            //         maxY: 700,
            //         lineBarsData: [
            //           LineChartBarData(
            //             spots: [
            //               FlSpot(0, 500),
            //               FlSpot(1, 400),
            //               FlSpot(2, 300),
            //               FlSpot(3, 450),
            //               FlSpot(4, 600),
            //               FlSpot(5, 700),
            //             ],
            //             isCurved: true,
            //             colors: [HexColor("54E70F")],
            //             dotData: FlDotData(show: false),
            //             belowBarData: BarAreaData(show: false),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 165,
                child: Consumer<Database>(builder: (context, instence, child) {
                  return LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show:
                            false, // Set to false to hide both horizontal and vertical lines
                        drawHorizontalLine: true,
                        drawVerticalLine: true,
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: SideTitles(
                            // showTitles: true,
                            // getTitles: (value) {
                            //   switch (value.toInt()) {
                            //     case 0:
                            //       return '10AM';
                            //     case 1:
                            //       return '11AM';
                            //     case 2:
                            //       return '12PM';
                            //     case 3:
                            //       return '01PM';
                            //     case 4:
                            //       return '02PM';
                            //     case 5:
                            //       return '03PM';
                            //     case 6:
                            //       return '04PM';
                            //     default:
                            //       return '';
                            //   }
                            // },
                            ),
                        leftTitles: SideTitles(
                          showTitles: false,
                          checkToShowTitle: (minValue, maxValue, sideTitles,
                              appliedInterval, value) {
                            // Add your condition to determine whether to show the title
                            // For example, show title if the value is greater than a threshold
                            return value > 0;
                          },
                        ),
                        rightTitles: SideTitles(
                          showTitles: false,
                          checkToShowTitle: (minValue, maxValue, sideTitles,
                              appliedInterval, value) {
                            // Add your condition to determine whether to show the title
                            // For example, show title if the value is greater than a threshold
                            return value > 0;
                          },
                        ),
                        topTitles: SideTitles(showTitles: false),
                      ),
                      borderData: FlBorderData(
                        show:
                            false, // Set to false to hide both bottom and top lines
                        border: const Border(
                          bottom: BorderSide(
                            color: Colors.grey, // Adjust the color as needed
                          ),
                        ),
                      ),
                      extraLinesData: ExtraLinesData(
                        horizontalLines: [
                          HorizontalLine(
                            y: 0,
                            color: Colors
                                .transparent, // Adjust the color as needed
                          ),
                        ],
                        verticalLines: [
                          VerticalLine(
                            x: 6,
                            color: Colors
                                .transparent, // Adjust the color as needed
                          ),
                        ],
                      ),
                      minX: 0,
                      maxX: 6,
                      minY: 0,
                      maxY: 700,
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            FlSpot(0, 500),
                            FlSpot(1, 400),
                            FlSpot(2, 300),
                            FlSpot(3, 450),
                            FlSpot(4, 600),
                            FlSpot(5, 700),
                          ],
                          // spots: instence.incomeLine.map((e) {
                          //   print(e["income"]);
                          //   return FlSpot(e["date"], e["income"]);
                          // }).toList(),
                          isCurved: true,
                          colors: [HexColor("54E70F")],
                          barWidth: 4, // Adjust the width as needed
                          isStrokeCapRound: true,
                          dotData: FlDotData(show: false),
                          belowBarData: BarAreaData(
                            show: true,
                            colors: [
                              HexColor("54E70F").withOpacity(0.3),
                              HexColor("#FFFFFF")
                            ], // Set the shadow color here
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Text("Reviews"),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 25.0),
                  child: Column(
                    children: [
                      Text("See All Reviews",
                          style: TextStyle(color: HexColor("54E70F"))),
                      Container(
                          height: 1.5, width: 99, color: HexColor("54E70F")),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: HexColor("FFE120"),
                  ),
                  Text(
                    "4.9",
                    style: TextStyle(
                      color: HexColor("FFE120"),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text("Total 20 Reviews")
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    " Popular",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MyfoodList()));
                    },
                    child: Text(
                      " Show All",
                      style: TextStyle(color: HexColor("A8A7A7")),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 165,
              child: Consumer<Database>(builder: (context, databasepro, child) {
                return FutureBuilder(
                    future: databasepro.fetchPopularItems(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: HexColor("54E70F"),
                          ),
                        );
                      }
                      final data = databasepro.popularItemsList;
                      return ListView.builder(
                        padding: const EdgeInsets.all(5),
                        scrollDirection: Axis.horizontal,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: SizedBox(
                              height: 135,
                              width: 185,
                              child: Column(
                                children: [
                                  Container(
                                    height:
                                        110, // Set a specific height for the image container
                                    width: 185,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                data[index].itemImage)),
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data[index].itemName,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          ratingBar(
                                              data[index].rating.toDouble())
                                        ],
                                      ),
                                      Text(
                                        data[index].itemPrice,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    });
              }),
            )
          ]),
        ),
      ),
    );
  }
}
