import 'package:eatmore/utils/instence.dart';
import 'package:eatmore/view%20model/database.dart';
import 'package:eatmore/view/modules/user/favorite.dart';
import 'package:eatmore/view/modules/user/notifications.dart';
import 'package:eatmore/view/modules/user/tabs/preebooking.dart';
import 'package:eatmore/view/modules/user/tabs/token.dart';
import 'package:eatmore/view/modules/user/userpersonelinfo.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import 'feedback.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: HexColor("E1FED3"),
                    child: const Icon(
                      Icons.person_outline,
                      size: 35,
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Consumer<Database>(builder: (context, instence, child) {
                    return Column(
                      children: [
                        Text(
                          "${instence.usermodel?.name.toUpperCase()}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          instence.usermodel?.bio == "add your bio"
                              ? ""
                              : "${instence.usermodel?.bio.toUpperCase()}",
                          style: TextStyle(color: HexColor("A0A5BA")),
                        ),
                      ],
                    );
                  }),
                  const SizedBox(
                    width: 25,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserPersonelInfo(),
                      ));
                },
                child: Container(
                  height: 65,
                  width: 295,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: HexColor("E1FED3")),
                  child: ListTile(
                    leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person_outline,
                          color: HexColor("FB6F3D"),
                        )),
                    title: const Text("Personal Info"),
                    trailing: const Icon(Icons.arrow_right),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Tokens(),
                      ));
                },
                child: Container(
                  height: 65,
                  width: 295,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: HexColor("E1FED3")),
                  child: ListTile(
                    leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.token,
                          color: HexColor("413DFB"),
                        )),
                    title: const Text("Tokens"),
                    trailing: const Icon(Icons.arrow_right),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 65,
                width: 295,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: HexColor("E1FED3")),
                child: ListTile(
                  leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.card_travel,
                        color: HexColor('FF7622'),
                      )),
                  title: const Text("Cart"),
                  trailing: const Icon(Icons.arrow_right),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Favorite(),
                      ));
                },
                child: Container(
                  height: 65,
                  width: 295,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: HexColor("E1FED3")),
                  child: ListTile(
                    leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.favorite_border,
                          color: HexColor('18CFE8'),
                        )),
                    title: const Text("Favourite"),
                    trailing: const Icon(Icons.arrow_right),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PreeBooking(),
                      ));
                },
                child: Container(
                  height: 65,
                  width: 295,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: HexColor("E1FED3")),
                  child: ListTile(
                    leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.bookmark_added,
                          color: HexColor('FB6F3D'),
                        )),
                    title: const Text("Pre Booking"),
                    trailing: const Icon(Icons.arrow_right),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 65,
                width: 295,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: HexColor("E1FED3")),
                child: ListTile(
                  leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.question_mark,
                        color: HexColor('FB6D3A'),
                      )),
                  title: const Text("FAQs"),
                  trailing: const Icon(Icons.arrow_right),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FeedBack(),
                      ));
                },
                child: Container(
                  height: 65,
                  width: 295,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: HexColor("E1FED3")),
                  child: ListTile(
                    leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.feedback_outlined,
                          color: HexColor('2AE1E1'),
                        )),
                    title: const Text("Rating & Feedback"),
                    trailing: const Icon(Icons.arrow_right),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotiFication(),
                      ));
                },
                child: Container(
                  height: 65,
                  width: 295,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: HexColor("E1FED3")),
                  child: ListTile(
                    leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.notifications_none,
                          color: HexColor('FFAA2A'),
                        )),
                    title: const Text("Notifications"),
                    trailing: const Icon(Icons.arrow_right),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          title: const Text(
                            "Log Out?",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: Text(
                            "Are you sure you want to log out?",
                            textAlign: TextAlign.left,
                            style: TextStyle(color: HexColor("6B6E82")),
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white10),
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6)))),
                              child: const Text(
                                "Cancel",
                                style: TextStyle(color: Colors.black38),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                auth.signOutFromMAil(context);
                                // // Perform log out action
                                // // For example, you can call a function here to log out the user
                                // Navigator.of(context).pop(); // Close the dialog
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          HexColor("FF3326")),
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6)))),
                              child: const Text(
                                "Log Out",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            )
                          ]);
                    },
                  );
                },
                child: Container(
                  height: 65,
                  width: 295,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: HexColor("E1FED3")),
                  child: ListTile(
                    leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.logout,
                          color: HexColor('FB4A59'),
                        )),
                    title: const Text("Log Out"),
                    trailing: const Icon(Icons.arrow_right),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
