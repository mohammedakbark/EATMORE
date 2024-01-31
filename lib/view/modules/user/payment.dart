import 'package:eatmore/view/modules/user/paymentsuccses.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';



class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  var Payments;

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
            const SizedBox(
              height: 75,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8.0,right: 8),
              child: ListTile(
                  leading: Text("Subtotal",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14)),
                  trailing: Text("₹120.00",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14))),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8),
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
const SizedBox(height: 30,),
            const Padding(
              padding: EdgeInsets.only(left: 8.0,right: 8),
              child: ListTile(
                  leading: Text("Total",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14)),
                  trailing: Text("₹120.00",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14))),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentSuccesful(),));
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
