import 'package:eatmore/view/modules/user/sign/signin.dart';
import 'package:eatmore/view/modules/user/sign/usersignup.dart';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SignupOrSignin extends StatelessWidget {
  const SignupOrSignin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                height: height * .2,
              ),
              Container(
                height: height * .2,
                width: width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                            "img/WhatsApp Image 2023-11-03 at 11.40 1.png"))),
              ),
              SizedBox(
                height: height * .1,
              ),
              const Text(
                "Create an account",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 40),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Ready to get started with our canteen",
                style: TextStyle(color: HexColor("605E5E"), fontSize: 17),
              ),
              Text(
                "management system? Simply click the",
                style: TextStyle(color: HexColor("605E5E"), fontSize: 17),
              ),
              Text(
                "Get Started button.",
                style: TextStyle(color: HexColor("605E5E"), fontSize: 17),
              ),
              const SizedBox(
                height: 125,
              ),
              Expanded(child: SizedBox()),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center the Row horizontally
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserSignUp(),
                          ));
                    },
                    child: Container(
                      height: height * .07,
                      width: width * .4,
                      decoration: BoxDecoration(
                        color: HexColor("54E70F"),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: const Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  //

                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserSigninPage(),
                          ));
                    },
                    child: Container(
                      height: height * .07,
                      width: width * .4,
                      decoration: BoxDecoration(
                        color: HexColor("232622"),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: const Center(
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: height * .1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
