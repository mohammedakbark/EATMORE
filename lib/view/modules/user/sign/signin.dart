import 'package:eatmore/utils/instence.dart';
import 'package:eatmore/view%20model/database.dart';
import 'package:eatmore/view/modules/user/Maintenance%20screen.dart';
import 'package:eatmore/view/modules/user/navigation_user.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class UserSigninPage extends StatefulWidget {
  const UserSigninPage({Key? key}) : super(key: key);

  @override
  State<UserSigninPage> createState() => _UserSigninPageState();
}

class _UserSigninPageState extends State<UserSigninPage> {
  var pass = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
                      width: width,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "img/eating-healthy-food-concept-illustration_114360-2235-removebg-preview.png"))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Hungry?",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 36)),
                    Text("Ready to get started with our canteen ",
                        style:
                            TextStyle(color: HexColor("605E5E"), fontSize: 18)),
                    Text("management system? Simply click the ",
                        style:
                            TextStyle(color: HexColor("605E5E"), fontSize: 18)),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        height: 50,
                        width: 315,
                        child: TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Login with email or username",
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
                        width: 315,
                        child: TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: HexColor("A8A7A7")),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                        onTap: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            Provider.of<Database>(context)
                                .fetchMaintanancevalue()
                                .then((value) async {
                              if (value == true) {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Maintenance()),
                                    (route) => false);
                              } else {
                                await auth.login(
                                    emailController.text,
                                    passwordController.text,
                                    context,
                                    const UserBottomNavigation());
                              }
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Please fill in all the required fields.'),
                              ),
                            );
                          }
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
                        )),
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
            )),
      ),
    );
  }
}
