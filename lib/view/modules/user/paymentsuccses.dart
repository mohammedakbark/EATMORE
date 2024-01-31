
import 'package:eatmore/view/modules/user/navigation_user.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'Donation Payment.dart';

class PaymentSuccesful extends StatefulWidget {
  const PaymentSuccesful({Key? key}) : super(key: key);

  @override
  State<PaymentSuccesful> createState() => _PaymentSuccesfulState();
}

class _PaymentSuccesfulState extends State<PaymentSuccesful> {
  var groupvalue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const SizedBox(
              height: 210,
            ),
            Image.asset(
              'img/allisokey.png',
              width: 85,
            ),
            const Text(
              "Thank You!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            ),
            const SizedBox(
              height: 10,
            ),
            Text("We are planning to give donation",
                style: TextStyle(color: HexColor("525C67"))),
            Text("for charity.if you intrested join with us!",
                style: TextStyle(color: HexColor("525C67"))),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Select an Amount ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(HexColor("E1FED3"))),
                    onPressed: () {},
                    child: const Text(
                      "₹50",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(HexColor("E1FED3"))),
                    onPressed: () {},
                    child: const Text(
                      "₹100",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(HexColor("E1FED3"))),
                    onPressed: () {},
                    child: const Text(
                      "₹200",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(HexColor("E1FED3"))),
                    onPressed: () {},
                    child: const Text(
                      "Other",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(
                    value: 'donate',
                    groupValue: groupvalue,
                    onChanged: (value) {
                      setState(() {
                        groupvalue = value!;
                      });
                    },
                  ),
                  const Text(
                    "Make my donation recurring",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            const SizedBox(height: 5,),
            InkWell(onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const DonationPayment(),));
            },
              child: Container(
                alignment: Alignment.center,
                height: 35,
                width: 89,
                decoration: BoxDecoration(
                    color: HexColor("54E70F"),
                    borderRadius: BorderRadius.circular(8)),
                child: const Text(
                  "Donate",
                  style:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 29,),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserBottomNavigation(),
                      ));
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 315,
                  decoration: BoxDecoration(
                      color: HexColor("54E70F"),
                      borderRadius: BorderRadius.circular(25)),
                  child: const Text("Go Home",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
