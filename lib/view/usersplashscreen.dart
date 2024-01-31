import 'package:eatmore/utils/const.dart';
import 'package:eatmore/utils/instence.dart';
import 'package:eatmore/view/modules/admin/bottomnavbar.dart';
import 'package:eatmore/view/modules/user/navigation_user.dart';
import 'package:eatmore/view/user0radmin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class UserSplash extends StatelessWidget {
  const UserSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      if (context != null && context.mounted) {
        if (FirebaseAuth.instance.currentUser == null) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const UserorAdmin()),
              (route) => false);
        } else {
          if (FirebaseAuth.instance.currentUser!.uid == adminUid) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const BottomNavigationAdmin()),
                (route) => false);
          } else {
            if (FirebaseAuth.instance.currentUser!.emailVerified) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const UserBottomNavigation()),
                  (route) => false);
            } else {
              FirebaseAuth.instance.currentUser!.delete();
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("close and open")));
            }
          }
        }
      }
    });

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              HexColor("54E70F"),
              HexColor("7EEF36"), // A slightly lighter shade than "54E70F"
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Image.asset('img/Eatmore Logo.png'),
        ),
      ),
    );
  }
}
