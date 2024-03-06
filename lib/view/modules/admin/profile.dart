import 'package:eatmore/utils/const.dart';
import 'package:eatmore/utils/instence.dart';
import 'package:eatmore/view%20model/database.dart';
import 'package:eatmore/view/modules/admin/donationhistory.dart';
import 'package:eatmore/view/modules/admin/personelnfo.dart';
import 'package:eatmore/view/modules/admin/reviews.dart';
import 'package:eatmore/view/modules/admin/tabs/orders.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * .05,
              ),
              const Text(
                "ADMIN",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 39),
              ),
              SizedBox(
                height: height * .05,
              )
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     // CircleAvatar(
              //     //   radius: 40,
              //     //   backgroundColor: HexColor("E1FED3"),
              //     //   child: const Icon(
              //     //     Icons.person_outline,
              //     //     size: 35,
              //     //   ),
              //     // ),
              //     // const SizedBox(
              //     //   width: 25,
              //     // ),
              //     const Text(
              //       "Admin",
              //       style: const TextStyle(
              //           fontWeight: FontWeight.bold, fontSize: 16),
              //     ),
              //     const SizedBox(
              //       width: 25,
              //     ),
              //   ],
              // ),
              ,
              const SizedBox(
                height: 10,
              ),
              // InkWell(
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => const PersonelInfo(),
              //         ));
              //   },
              //   child: Container(
              //     height: 65,
              //     width: 295,
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(10),
              //         color: HexColor("E1FED3")),
              //     child: ListTile(
              //       leading: CircleAvatar(
              //           backgroundColor: Colors.white,
              //           child: Icon(
              //             Icons.person_outline,
              //             color: HexColor("FB6F3D"),
              //           )),
              //       title: const Text("Personal Info"),
              //       trailing: const Icon(Icons.arrow_right),
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 10,
              ),
              Consumer<Database>(builder: (context, datab, child) {
                return Container(
                  height: 65,
                  width: 295,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: HexColor("E1FED3")),
                  child: FutureBuilder(
                      future: datab.fetchMaintanancevalue(),
                      builder: (context, snap) {
                        return ListTile(
                          leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.settings_outlined,
                                color: HexColor("413DFB"),
                              )),
                          title: const Text("Maintanance"),
                          trailing: Transform.scale(
                            scale: 0.7, // Adjust the scale factor as needed
                            child: Switch(
                              value: datab.maintanancevalue ?? false,
                              onChanged: (value) {
                                datab.updatemaintanence(value);
                              },
                            ),
                          ),
                        );
                      }),
                );
              }),
              // const SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   height: 65,
              //   width: 295,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10),
              //       color: HexColor("E1FED3")),
              //   child: ListTile(
              //     leading: CircleAvatar(
              //         backgroundColor: Colors.white,
              //         child: Icon(
              //           Icons.local_atm,
              //           color: HexColor('FF7622'),
              //         )),
              //     title: const Text("Withdrawal History"),
              //     trailing: const Icon(Icons.arrow_right),
              //   ),
              // ),
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
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Orders(),
                    ));
                  },
                  leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.event_note_outlined,
                        color: HexColor('18CFE8'),
                      )),
                  title: const Text("Manage Orders"),
                  trailing: const Icon(Icons.arrow_right),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Donation(),
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
                          Icons.history,
                          color: HexColor('FB6F3D'),
                        )),
                    title: const Text("Donation History"),
                    trailing: const Icon(Icons.arrow_right),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Reviews(),
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
                          color: HexColor('18CFE8'),
                        )),
                    title: const Text("Rating & Feedback"),
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
