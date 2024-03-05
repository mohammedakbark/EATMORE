import 'package:eatmore/model/user_model.dart';
import 'package:eatmore/view%20model/database.dart';
import 'package:eatmore/view/modules/user/navigation_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Database>(context);
    final name = TextEditingController(text: provider.usermodel!.name);
    final email = TextEditingController(text: provider.usermodel!.email);
    final number =
        TextEditingController(text: provider.usermodel!.number.toString());
    final bio = TextEditingController(text: provider.usermodel!.bio);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        title: const Text("Edit Profile",
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Stack(
                //   children: [
                //     CircleAvatar(
                //       backgroundColor: HexColor("E1FED3"),
                //       radius: 50,
                //     ),
                //     Positioned(
                //       bottom: 0,
                //       right: 0,
                //       child: CircleAvatar(
                //         backgroundColor: HexColor("54E70F"),
                //         child: IconButton(
                //           onPressed: () {},
                //           icon: const Icon(
                //             Icons.edit,
                //             color: Colors.white,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                const SizedBox(
                  height: 30,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Full Name",
                      style: TextStyle(fontSize: 15, color: HexColor("32343E")),
                    )),
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person_outline),
                      filled: true,
                      fillColor: HexColor('EDEDED'),
                      hintText: "Enter your username",
                      focusedBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      enabledBorder:
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
                  height: 12,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Email",
                      style: TextStyle(fontSize: 15, color: HexColor("32343E")),
                    )),
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    enabled: false,
                    controller: email,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email_outlined),
                      filled: true,
                      fillColor: HexColor('EDEDED'),
                      hintText: "Enter your email",
                      focusedBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      enabledBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      disabledBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Phone Number",
                      style: TextStyle(fontSize: 15, color: HexColor("32343E")),
                    )),
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    controller: number,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.mobile_friendly),
                      filled: true,
                      fillColor: HexColor('EDEDED'),
                      hintText: "Enter your number",
                      focusedBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      enabledBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your number';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Bio",
                      style: TextStyle(fontSize: 15, color: HexColor("32343E")),
                    )),
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    controller: bio,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(CupertinoIcons.pencil_circle),
                      filled: true,
                      fillColor: HexColor('EDEDED'),
                      hintText: "Enter your bio",
                      focusedBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      enabledBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your bio';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      int conNumber = int.parse(number.text);
                      await provider
                          .updateUserData(
                              FirebaseAuth.instance.currentUser!.uid,
                              UserModel(
                                  bio: bio.text,
                                  email: email.text,
                                  name: name.text,
                                  number: conNumber),
                              context)
                          .then((value) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => UserBottomNavigation(),
                            ),
                            (route) => false);
                      });
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
                      "SAVE",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
