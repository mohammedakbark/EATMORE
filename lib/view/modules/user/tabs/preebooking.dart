import 'package:eatmore/view%20model/controller.dart';
import 'package:eatmore/view%20model/database.dart';
import 'package:eatmore/view/modules/user/Maintenance%20screen.dart';
import 'package:eatmore/view/modules/user/navigation_user.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class PreeBooking extends StatefulWidget {
  PreeBooking({Key? key}) : super(key: key);

  @override
  State<PreeBooking> createState() => _PreeBookingState();
}

class _PreeBookingState extends State<PreeBooking> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final quantityController = TextEditingController();

  String mavalue = "Select item";
  String? selectedvalue;
  List<String> categories = ["Select item"];
  @override
  Widget build(BuildContext context) {
    final list = Provider.of<Database>(context, listen: false).itemList;
    for (var i in list) {
      categories.add(i.itemName);
    }
    print(categories.length);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prebook",
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Item",
                    style: TextStyle(fontSize: 15, color: HexColor("32343E")),
                  )),
              DropdownButtonFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: HexColor('EDEDED'),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("54E70F"))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("54E70F"))),
                  ),
                  value: mavalue,
                  items: categories.map((e) {
                    print(e);
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedvalue = value;
                    mavalue = value!;
                  }),
              const SizedBox(
                height: 12,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Date",
                    style: TextStyle(fontSize: 15, color: HexColor("32343E")),
                  )),
              Consumer<Controller>(builder: (context, controller, child) {
                return SizedBox(
                  height: 50,
                  child: TextFormField(
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () async {
                            controller.selectedate(context);
                          },
                          icon: const Icon(Icons.calendar_month)),
                      filled: true,
                      fillColor: HexColor('EDEDED'),
                      hintText: controller.pickedate,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: HexColor("54E70F"))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: HexColor("54E70F"))),
                    ),
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Please enter your username';
                    //   }
                    //   return null;
                    // },
                  ),
                );
              }),
              const SizedBox(
                height: 12,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Quantity",
                    style: TextStyle(fontSize: 15, color: HexColor("32343E")),
                  )),
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: quantityController,
                  decoration: InputDecoration(
                    // suffix: Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Column(
                    //       children: [
                    //         const SizedBox(height: 5),
                    //         Text(
                    //           '₹${(quantity * 10).toStringAsFixed(2)}', // Dynamic rate calculation
                    //           style:
                    //               const TextStyle(fontWeight: FontWeight.bold),
                    //         ),
                    //         const SizedBox(height: 5),
                    //       ],
                    //     ),
                    //     const SizedBox(width: 65),
                    //     Row(
                    //       children: [
                    //         IconButton(
                    //             style: ButtonStyle(
                    //                 shape: MaterialStatePropertyAll(
                    //                     RoundedRectangleBorder(
                    //                         borderRadius:
                    //                             BorderRadius.circular(8))),
                    //                 backgroundColor: MaterialStatePropertyAll(
                    //                     HexColor("F3EFEF"))),
                    //             onPressed: () {
                    //               setState(() {
                    //                 quantity++;
                    //               });
                    //             },
                    //             icon: const Icon(Icons.add)),
                    //         const SizedBox(width: 5),
                    //         Text(
                    //           quantity.toString(),
                    //           style:
                    //               const TextStyle(fontWeight: FontWeight.bold),
                    //         ),
                    //         const SizedBox(width: 5),
                    //         IconButton(
                    //             style: ButtonStyle(
                    //                 shape: MaterialStatePropertyAll(
                    //                     RoundedRectangleBorder(
                    //                         borderRadius:
                    //                             BorderRadius.circular(8))),
                    //                 backgroundColor: MaterialStatePropertyAll(
                    //                     HexColor("F3EFEF"))),
                    //             onPressed: () {
                    //               if (quantity > 0) {
                    //                 setState(() {
                    //                   quantity--;
                    //                 });
                    //               }
                    //             },
                    //             icon: const Icon(Icons.remove))
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    filled: true,
                    fillColor: HexColor('EDEDED'),
                    hintText: "Select Quantity",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("54E70F"))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("54E70F"))),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
              ),
              const Expanded(
                child: SizedBox(
                  height: 165,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const Maintenance()),
                        (route) => false);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => const Maintenance(),
                    //     ));
                    // if (_formKey.currentState!.validate()) {
                    //   if (selectedvalue != null) {
                    //     if (Provider.of<Controller>(context).pickedate !=
                    //         null) {
                    //       print("ok");
                    //     } else {}
                    //   } else {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(
                    //         content:
                    //             Text('Please fill in all the required fields.'),
                    //       ),
                    //     );
                    //   }

                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => const UserBottomNavigation(),
                    //     ));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 325,
                    decoration: BoxDecoration(
                      color: HexColor("54E70F"),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "SAVE",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
