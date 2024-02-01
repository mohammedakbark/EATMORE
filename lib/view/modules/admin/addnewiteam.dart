import 'package:eatmore/model/add_new_item.dart';
import 'package:eatmore/utils/instence.dart';
import 'package:eatmore/view%20model/controller.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddNewItem extends StatefulWidget {
  AddNewItem({Key? key}) : super(key: key);

  @override
  State<AddNewItem> createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  List<String> category = [
    "Shake",
    "Juice",
    "Fast Food",
    "Biriyani",
    "Veg",
    "Non-Veg",
    "Non"
  ];

  String? myImage;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Controller>(
      context,
    );
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text(
          "Add New Item",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: height * .05,
                ),
                Consumer<Controller>(builder: (context, controller, child) {
                  return Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 125,
                      width: 220,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: controller.itemImage != null
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(controller.itemImage!),
                              )
                            : const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("img/mainuploadimage2.jpg"),
                              ),
                      ),
                      // image:controller.itemImage!=null?FileImage(controller.itemImage!): AssetImage("img/mainuploadimage2.jpg"))),
                      child: IconButton(
                          onPressed: () {
                            controller.addItemImage().then((value) {
                              myImage = value;
                            });
                          },
                          icon: const Icon(
                            Icons.add_box,
                            color: Colors.white70,
                            size: 55,
                          )),
                    ),
                  );
                }),
                SizedBox(
                  height: height * .02,
                ),
                const Text(
                  "Upload Image",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  height: height * .02,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("ITEM NAME")),
                ),
                SizedBox(
                  height: height * .01,
                ),
                SizedBox(
                    height: height * .06,
                    width: width * .8,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "fill this required field";
                        } else {
                          return null;
                        }
                      },
                      controller: provider.itemName,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: HexColor("FDFDFD"),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12)),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black26)),
                          errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12)),
                          focusedErrorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black26))),
                    )),
                SizedBox(
                  height: height * .02,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("CHOOSE CATEGORY")),
                ),
                SizedBox(
                  height: height * .01,
                ),
                SizedBox(
                  height: height * .06,
                  width: width * .8,
                  child: Consumer<Controller>(
                      builder: (context, controller, child) {
                    return DropdownButtonFormField(
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: HexColor("FDFDFD"),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12)),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black26))),
                        value: controller.selectedItem,
                        items: category.map((e) {
                          return DropdownMenuItem(
                              value: e.toString(), child: Text(e));
                        }).toList(),
                        onChanged: (value) {
                          controller.selectItem(value);
                        });
                  }),
                ),
                SizedBox(
                  height: height * .02,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Align(
                      alignment: Alignment.centerLeft, child: Text("PRICE")),
                ),
                SizedBox(
                  height: height * .01,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                        height: height * .06,
                        width: width * .3,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "fill this required field";
                            } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return "field is not correct value";
                            } else {
                              return null;
                            }
                          },
                          controller: provider.itemPrice,
                          decoration: InputDecoration(
                              prefixText: "₹",
                              filled: true,
                              fillColor: HexColor("FDFDFD"),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black12)),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black26)),
                              errorBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black12)),
                              focusedErrorBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black26))),
                        )),
                  ),
                ),
                SizedBox(
                  height: height * .02,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Align(
                      alignment: Alignment.centerLeft, child: Text("DETAILS")),
                ),
                SizedBox(
                  height: height * .01,
                ),
                SizedBox(
                    height: height * .15,
                    width: width * .8,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "fill this required field";
                        } else {
                          return null;
                        }
                      },
                      controller: provider.itemDetail,
                      maxLines: 4,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: HexColor("FDFDFD"),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12)),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black26)),
                          errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12)),
                          focusedErrorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black26))),
                    )),
                SizedBox(
                  height: height * .02,
                ),
                InkWell(
                    onTap: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        if (provider.selectedItem != "Non") {
                          if (provider.itemImage != null) {
                            database
                                .addNewProduct(AddNewItemModel(
                                    itemCategory: provider.selectedItem,
                                    itemImage: myImage!,
                                    itemName: provider.itemName.text,
                                    itemPrice: provider.itemPrice.text,
                                    moreDetail: provider.itemDetail.text))
                                .then((value) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                backgroundColor: HexColor("54E70F"),
                                content: const Text('Item added successful'),
                              ));

                              provider.clearData();
                              Navigator.of(context).pop();
                            });
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('pick image'),
                            ));
                          }
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Select category'),
                          ));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Please fill in all the required fields.'),
                          ),
                        );
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 295,
                      decoration: BoxDecoration(
                          color: HexColor("54E70F"),
                          borderRadius: BorderRadius.circular(25)),
                      child: const Text(
                        "Submit",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
