import 'package:eatmore/view/modules/user/navigation_user.dart';
import 'package:eatmore/view/modules/user/tabs/userhome.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Maintenance extends StatefulWidget {
  const Maintenance({super.key});

  @override
  State<Maintenance> createState() => _MaintenanceState();
}

class _MaintenanceState extends State<Maintenance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "img/Maintenance screen.png",
                  width: 265,
                ),
                const Text(
                  "We’re under maintenance",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 19),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Please check back soon just putting little touch",
                  style: TextStyle(color: HexColor("6B6E82")),
                ),
                Text(
                  "up on some pretty updates.",
                  style: TextStyle(color: HexColor("6B6E82")),
                ),
                // const Expanded(
                //     child: SizedBox(
                //   height: 15,
                // )),
                // InkWell(
                //   onTap: () {

                //   },
                //   child: Container(
                //     alignment: Alignment.center,
                //     height: 50,
                //     width: 105,
                //     decoration: BoxDecoration(
                //       color: HexColor("54E70F"),
                //       borderRadius: BorderRadius.circular(20),
                //     ),
                //     child: const Text(
                //       "Close",
                //       style: TextStyle(
                //         color: Colors.white,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 50,
                // )
              ]),
        ),
      ),
    );
  }
}
