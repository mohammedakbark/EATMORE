import 'package:eatmore/utils/const.dart';
import 'package:eatmore/view%20model/controller.dart';
import 'package:eatmore/view%20model/database.dart';
import 'package:eatmore/view/modules/admin/addnewiteam.dart';
import 'package:eatmore/view/modules/admin/homepagefoodlist.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class MyfoodList extends StatelessWidget {
  const MyfoodList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final databasepro = Provider.of<Database>(context);
    final controlPro = Provider.of<Controller>(context, listen: false);
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text(
          "My Food List",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: databasepro.fetchAddedItems(false),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return indicator;
            }
            final data = databasepro.itemList;
            return data.isEmpty
                ? const Center(
                    child: Text("No Items Found"),
                  )
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: databasepro.itemList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 15.0,
                          right: 15,
                          top: 15,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Container(
                                    height: 95,
                                    width: width / 2.4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              data[index].itemImage)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: width / 2,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                data[index]
                                                    .itemName
                                                    .toUpperCase(),
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Container(
                                                width: 80,
                                                // Set the desired width
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0), // Adjust the radius as needed
                                                ),
                                                child: PopupMenuButton(
                                                  onSelected: (value) {
                                                    if (value == "delete") {
                                                      databasepro.deleteItem(
                                                          data[index].itemId);
                                                    } else if (value ==
                                                        "edit") {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            AlertDialog(
                                                          title: Form(
                                                            key: _formKey,
                                                            child: Column(
                                                              children: [
                                                                const Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                        "DETAILS")),
                                                                SizedBox(
                                                                  height:
                                                                      height *
                                                                          .01,
                                                                ),
                                                                SizedBox(
                                                                    height:
                                                                        height *
                                                                            .10,
                                                                    width:
                                                                        width *
                                                                            .8,
                                                                    child:
                                                                        TextFormField(
                                                                      validator:
                                                                          (value) {
                                                                        if (value!
                                                                            .isEmpty) {
                                                                          return "fill this required field";
                                                                        } else {
                                                                          return null;
                                                                        }
                                                                      },
                                                                      controller:
                                                                          controlPro
                                                                              .itemDetail,
                                                                      maxLines:
                                                                          4,
                                                                      decoration: InputDecoration(
                                                                          filled:
                                                                              true,
                                                                          fillColor: HexColor(
                                                                              "FDFDFD"),
                                                                          focusedBorder:
                                                                              const OutlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
                                                                          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
                                                                          errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
                                                                          focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black26))),
                                                                    )),
                                                                const Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                        "PRICE")),
                                                                SizedBox(
                                                                  height:
                                                                      height *
                                                                          .01,
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: SizedBox(
                                                                      height: height * .06,
                                                                      width: width * .3,
                                                                      child: TextFormField(
                                                                        validator:
                                                                            (value) {
                                                                          if (value!
                                                                              .isEmpty) {
                                                                            return "fill this required field";
                                                                          } else if (!RegExp(r'^[0-9]+$')
                                                                              .hasMatch(value)) {
                                                                            return "field is not correct value";
                                                                          } else {
                                                                            return null;
                                                                          }
                                                                        },
                                                                        controller:
                                                                            controlPro.itemPrice,
                                                                        decoration: InputDecoration(
                                                                            prefixText:
                                                                                "₹",
                                                                            filled:
                                                                                true,
                                                                            fillColor:
                                                                                HexColor("FDFDFD"),
                                                                            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
                                                                            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
                                                                            errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
                                                                            focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black26))),
                                                                      )),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          actionsAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          actions: [
                                                            ElevatedButton(
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    HexColor(
                                                                        "54E70F"),
                                                              ),
                                                              onPressed: () {
                                                                if (_formKey
                                                                    .currentState!
                                                                    .validate()) {
                                                                  databasepro.updatitemData(
                                                                      data[index]
                                                                          .itemId,
                                                                      controlPro
                                                                          .itemDetail
                                                                          .text,
                                                                      controlPro
                                                                          .itemPrice
                                                                          .text);
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                }
                                                              },
                                                              child: const Text(
                                                                "Update",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 15,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  color: Colors.black,
                                                  // Set to transparent to see the container's background
                                                  icon: const Icon(
                                                    Icons.more_horiz,
                                                    color: Colors.black,
                                                  ),
                                                  itemBuilder:
                                                      (BuildContext context) {
                                                    return [
                                                      const PopupMenuItem(
                                                        height: 20,
                                                        value: 'edit',
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons.edit,
                                                                color: Colors
                                                                    .white),
                                                            SizedBox(width: 8),
                                                            Text('Edit item',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white)),
                                                          ],
                                                        ),
                                                      ),
                                                      const PopupMenuItem(
                                                        height: 10,
                                                        child: Divider(
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      const PopupMenuItem(
                                                        height: 20,
                                                        value: 'delete',
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                                Icons
                                                                    .delete_forever_outlined,
                                                                color: Colors
                                                                    .white),
                                                            SizedBox(width: 8),
                                                            Text('Delete item',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white)),
                                                          ],
                                                        ),
                                                      ),
                                                    ];
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        // const SizedBox(
                                        //   height: 10,
                                        // ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: HexColor("FB6D3A"),
                                            ),
                                            Text(
                                              "${data[index].rating.toDouble()}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: HexColor("FB6D3A"),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              '(10Review)',
                                              style: TextStyle(
                                                color: HexColor("AFAFAF"),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          data[index].itemPrice,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
          }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddNewItem(),
                  ));
            },
            child: Container(
              height: 50,
              width: 299,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: HexColor("54E70F"),
              ),
              alignment: Alignment.center,
              child: const Text(
                "Add New Item",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
