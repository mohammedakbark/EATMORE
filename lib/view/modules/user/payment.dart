import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatmore/model/buy_product_model.dart';
import 'package:eatmore/model/cart_item_model.dart';
import 'package:eatmore/view%20model/database.dart';
import 'package:eatmore/view/modules/user/paymentsuccses.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Payment extends StatefulWidget {
  double subToalAmount;
  List<CartItemModel> cartItemModelList;
  Payment(
      {super.key,
      required this.subToalAmount,
      required this.cartItemModelList});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  var Payments;
  String time = DateFormat('h:mm a').format(DateTime.now());

  String date = DateFormat("dd MMMM yyyy").format(DateTime.now());
  String day = DateFormat("d").format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          title: const Text(
            "Payment",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  elevation: 3,
                  color: HexColor("E1FED3"),
                  child: ListTile(
                    title: const Text(
                      "Cash Payment",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    leading: Image.asset('img/payment.png'),
                    trailing: Radio(
                      activeColor: HexColor("54E70F"),
                      value: 'cashPayment',
                      groupValue: Payments,
                      onChanged: (value) {
                        setState(() {
                          Payments = value!;
                        });
                      },
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  elevation: 3,
                  color: HexColor("E1FED3"),
                  child: ListTile(
                    title: const Text(
                      "GooglePay",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    leading: Image.asset('img/googleicons.png'),
                    trailing: Radio(
                      activeColor: HexColor("54E70F"),
                      value: 'Google Pay',
                      groupValue: Payments,
                      onChanged: (value) {
                        setState(() {
                          Payments = value!;
                        });
                      },
                    ),
                  )),
            ),
            Container(
              alignment: Alignment.center,
              height: 55,
              width: 329,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: HexColor("E1FED3")),
              child: Text("Add New",
                  style: TextStyle(
                      color: HexColor("54E70F"), fontWeight: FontWeight.w600)),
            ),
            const Expanded(
              child: SizedBox(
                height: 75,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: ListTile(
                  leading: const Text("Subtotal",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14)),
                  trailing: Text("₹${widget.subToalAmount}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14))),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: ListTile(
                  leading: const Text("Discount",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14)),
                  trailing: Text("₹00.00",
                      style: TextStyle(
                          color: HexColor("76EE3D"),
                          fontWeight: FontWeight.w600,
                          fontSize: 14))),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: ListTile(
                  leading: const Text("Total",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14)),
                  trailing: Text("₹${widget.subToalAmount}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14))),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () {
                    if (Payments == "cashPayment") {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                backgroundColor: Colors.white,
                                title: Text("Confirm Buying this Product",
                                    style:
                                        TextStyle(color: HexColor("525C67"))),
                                actionsAlignment: MainAxisAlignment.center,
                                actions: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: HexColor("54E70F")),
                                      onPressed: () {
                                        String times = "${time} ${date}";
                                        double dd = double.parse(day);
                                        for (final model
                                            in widget.cartItemModelList) {
                                          final now = DateTime.now();

                                          final stamp = Timestamp(
                                              now.second, now.millisecond);
                                          Provider.of<Database>(
                                                  context,
                                                  listen: false)
                                              .buyaProductbyUser(
                                                  BuyProductModel(
                                                      day: dd,
                                                      orderdateAndTime: times,
                                                      paymentMode: "Cash",
                                                      uid: FirebaseAuth.instance
                                                          .currentUser!.uid,
                                                      userModel:
                                                          Provider.of<Database>(
                                                                  context,
                                                                  listen: false)
                                                              .usermodel!,
                                                      cartItemModel: model,
                                                      status: "PENDING",
                                                      tokenNo: stamp.seconds
                                                              .toString() +
                                                          stamp.nanoseconds
                                                              .toString()),
                                                  model.cartId);
                                        }

                                        Navigator.of(context).pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (conetxt) =>
                                                    const PaymentSuccesful()),
                                            (route) => false);
                                      },
                                      child: const Text(
                                        "Confirm",
                                        style: TextStyle(color: Colors.white),
                                      ))
                                ],
                              ));
                    } else if (Payments == "Google Pay") {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text(
                                    """Unfortunatly the online payment server is down...!\nPlaese select other payment mode""",
                                    style:
                                        TextStyle(color: HexColor("525C67"))),
                              ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "Please select the payment mode then continue")));
                    }
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
          ]),
        ));
  }
}
