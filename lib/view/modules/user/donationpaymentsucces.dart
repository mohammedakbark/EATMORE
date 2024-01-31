
import 'package:eatmore/view/modules/user/navigation_user.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';


class DonationSuccesful extends StatefulWidget {
  const DonationSuccesful({Key? key}) : super(key: key);

  @override
  State<DonationSuccesful> createState() => _DonationSuccesfulState();
}

class _DonationSuccesfulState extends State<DonationSuccesful> {
  var groupvalue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
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
            Text("Thank you for join with us to help ",
                style: TextStyle(color: HexColor("525C67"))),
            Text("poor peoples!",
                style: TextStyle(color: HexColor("525C67"))),
const SizedBox(height: 205,),
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
