import 'package:eatmore/utils/const.dart';
import 'package:eatmore/utils/instence.dart';
import 'package:eatmore/view/modules/admin/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var pass = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: height * .2,
                    ),
                    Container(
                      height: 190,
                      width: 290,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage(
                            "img/eating-healthy-food-concept-illustration_114360-2235-removebg-preview.png"),
                      )),
                    ),
                    const SizedBox(
                      height: 65,
                    ),
                    SizedBox(
                        height: 50,
                        width: width * .75,
                        child: TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            } else if (adminEmial != value) {
                              return "email does not match";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Login with email",
                            hintStyle: TextStyle(color: HexColor("A8A7A7")),
                            prefixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.person,
                                  color: Colors.black,
                                )),
                            fillColor: HexColor("EDEDED"),
                            filled: true,
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide.none),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide.none),
                            errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide.none),
                            focusedErrorBorder: const OutlineInputBorder(
                                borderSide: BorderSide.none),
                          ),
                        )),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                        height: 50,
                        width: width * .75,
                        child: TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            } else if (adminpass != value) {
                              return "password does not match";
                            }
                            return null;
                          },
                          obscureText: !pass,
                          decoration: InputDecoration(
                            hintText: "Enter your password",
                            hintStyle: TextStyle(color: HexColor("A8A7A7")),
                            prefixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.lock,
                                  color: Colors.black,
                                )),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    pass = !pass;
                                  });
                                },
                                icon: Icon(pass
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                            fillColor: HexColor("EDEDED"),
                            filled: true,
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide.none),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide.none),
                            errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide.none),
                            focusedErrorBorder: const OutlineInputBorder(
                                borderSide: BorderSide.none),
                          ),
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: width * .12),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(color: HexColor("A8A7A7")),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                        onTap: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            await auth.login(
                                emailController.text,
                                passwordController.text,
                                context,
                                const BottomNavigationAdmin());
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Please fill in all the required fields.'),
                              ),
                            );
                          }

                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) =>
                          //           const BottomNavigationAdmin(),
                          //     ));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 295,
                          decoration: BoxDecoration(
                              color: HexColor("54E70F"),
                              borderRadius: BorderRadius.circular(25)),
                          child: const Text(
                            "Sign In",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ))
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
