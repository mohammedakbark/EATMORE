import 'package:eatmore/model/user_model.dart';
import 'package:eatmore/utils/instence.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class UserSignUp extends StatefulWidget {
  const UserSignUp({Key? key}) : super(key: key);

  @override
  State<UserSignUp> createState() => _UserSignUpState();
}

class _UserSignUpState extends State<UserSignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final userNameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // Handle back button press
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(
        width: width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * .2,
                ),
                const Text(
                  "Create an account",
                  style: TextStyle(
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 36,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Ready to get started with our canteen",
                  style: TextStyle(
                      letterSpacing: 1,
                      color: HexColor(
                        "605E5E",
                      ),
                      fontSize: 18),
                ),
                Text(
                  "management system? Simply click the",
                  style: TextStyle(
                      color: HexColor("605E5E"),
                      letterSpacing: 1,
                      fontSize: 18),
                ),
                Text(
                  "Get Started button.",
                  style: TextStyle(
                      color: HexColor("605E5E"),
                      letterSpacing: 1,
                      fontSize: 18),
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    controller: userNameController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person_outline),
                      filled: true,
                      fillColor: HexColor('EDEDED'),
                      hintText: "Enter your username",
                      focusedBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      enabledBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      errorBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      focusedErrorBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email_outlined),
                      filled: true,
                      fillColor: HexColor('EDEDED'),
                      hintText: "Type your e-mail",
                      focusedBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      enabledBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      errorBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      focusedErrorBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline),
                      filled: true,
                      fillColor: HexColor('EDEDED'),
                      hintText: "Type your password",
                      focusedBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      enabledBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      errorBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      focusedErrorBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline),
                      filled: true,
                      fillColor: HexColor('EDEDED'),
                      hintText: "Repeat your password",
                      focusedBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      enabledBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      errorBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      focusedErrorBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please repeat your password';
                      } else if (value != passwordController.text) {
                        return "password is not matching";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      await auth.sign(
                          emailController.text,
                          passwordController.text,
                          context,
                          UserModel(
                            bio: "add your bio",
                            email: emailController.text,
                            name: userNameController.text,
                            number: 91,
                          ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Please fill in all the required fields.'),
                        ),
                      );
                    }
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
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      "OR",
                      style: TextStyle(color: HexColor("A8A7A7")),
                    )),
                Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "img/googleicon.png",
                      width: 55,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
