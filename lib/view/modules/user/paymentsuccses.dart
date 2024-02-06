import 'package:eatmore/view/modules/user/navigation_user.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class PaymentSuccesful extends StatefulWidget {
  const PaymentSuccesful({Key? key}) : super(key: key);

  @override
  State<PaymentSuccesful> createState() => _PaymentSuccesfulState();
}

class _PaymentSuccesfulState extends State<PaymentSuccesful> {
  var groupvalue;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: Column(
          children: [
            SizedBox(
              height: height * .4,
            ),
            Image.asset(
              'img/allisokey.png',
              width: 105,
            ),
            const Text(
              "Thank You!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            ),
            const SizedBox(
              height: 10,
            ),
            Text("Your order is placed to our List",
                style: TextStyle(color: HexColor("525C67"))),
            Text("We will notify ,when will deliver",
                style: TextStyle(color: HexColor("525C67"))),
            // const SizedBox(
            //   height: 10,
            // ),
            // // const Text(
            // //   "Select an Amount ",
            // //   style: TextStyle(fontWeight: FontWeight.bold),
            // // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     ElevatedButton(
            //         style: ButtonStyle(
            //             backgroundColor:
            //                 MaterialStatePropertyAll(HexColor("E1FED3"))),
            //         onPressed: () {},
            //         child: const Text(
            //           "₹50",
            //           style: TextStyle(
            //               color: Colors.black, fontWeight: FontWeight.bold),
            //         )),
            //     ElevatedButton(
            //         style: ButtonStyle(
            //             backgroundColor:
            //                 MaterialStatePropertyAll(HexColor("E1FED3"))),
            //         onPressed: () {},
            //         child: const Text(
            //           "₹100",
            //           style: TextStyle(
            //               color: Colors.black, fontWeight: FontWeight.bold),
            //         )),
            //     ElevatedButton(
            //         style: ButtonStyle(
            //             backgroundColor:
            //                 MaterialStatePropertyAll(HexColor("E1FED3"))),
            //         onPressed: () {},
            //         child: const Text(
            //           "₹200",
            //           style: TextStyle(
            //               color: Colors.black, fontWeight: FontWeight.bold),
            //         )),
            //     ElevatedButton(
            //         style: ButtonStyle(
            //             backgroundColor:
            //                 MaterialStatePropertyAll(HexColor("E1FED3"))),
            //         onPressed: () {},
            //         child: const Text(
            //           "Other",
            //           style: TextStyle(
            //               color: Colors.black, fontWeight: FontWeight.bold),
            //         ))
            //   ],
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(right: 8.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Radio(
            //         value: 'donate',
            //         groupValue: groupvalue,
            //         onChanged: (value) {
            //           setState(() {
            //             groupvalue = value!;
            //           });
            //         },
            //       ),
            //       const Text(
            //         "Make my donation recurring",
            //         style: TextStyle(fontWeight: FontWeight.w600),
            //       )
            //     ],
            //   ),
            // // ),
            // const SizedBox(
            //   height: 5,
            // ),
            // InkWell(onTap: () {
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => const DonationPayment(),));
            // },
            // child: Container(
            //   alignment: Alignment.center,
            //   height: 35,
            //   width: 89,
            //   decoration: BoxDecoration(
            //       color: HexColor("54E70F"),
            //       borderRadius: BorderRadius.circular(8)),
            //   child: const Text(
            //     "Donate",
            //     style:
            //         TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            //   ),
            // ),
            // ),
            const Expanded(
              child: SizedBox(
                height: 29,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (conetxt) => const UserBottomNavigation()),
                      (route) => false);
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
            SizedBox(
              height: height * .1,
            )
          ],
        ),
      ),
    );
  }
}
