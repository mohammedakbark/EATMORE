import 'package:eatmore/view/modules/admin/adminsignup.dart';
import 'package:eatmore/view/modules/user/sign/signup%20or%20signin.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';


class UserorAdmin extends StatelessWidget {
  const UserorAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: HexColor("54E70F"),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                HexColor("54E70F"),
                HexColor("7EEF36"),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                "img/Eatmore Logo.png",
                width: 135,
              ),

              // SizedBox(
              //   height: height * .2,
              // ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupOrSignin(),
                          ));
                    },
                    child: Container(
                      height: 40,
                      width: 110,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Center(
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                      height: 30), // Add some space between the containers
                  const Text(
                    "or",
                    style: TextStyle(fontWeight: FontWeight.w200, fontSize: 15),
                  ),
                  const SizedBox(
                      height: 5), // Add some space between the containers
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupPage(),
                          ));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 110,
                      decoration: BoxDecoration(
                        // color: HexColor("232622"),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        "Admin ?",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
