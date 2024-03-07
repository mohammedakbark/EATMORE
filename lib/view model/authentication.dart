// ignore_for_file: avoid_print

import 'dart:async';

import 'package:eatmore/model/user_model.dart';
import 'package:eatmore/utils/instence.dart';
import 'package:eatmore/view/modules/user/sign/signin.dart';
import 'package:eatmore/view/user0radmin.dart';
import 'package:eatmore/view/usersplashscreen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authentication with ChangeNotifier {
  dynamic newUID;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isVerified = false;
  bool isEmailVerified = false;
  Timer? timer;

  Future<String> sign(email, password, context, UserModel usermodel) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      newUID = userCredential.user!.uid;
      await emailVarification(context, usermodel);
      print("*********************$newUID**********************");
      return userCredential.user!.uid;
    } catch (e) {
      return customeShowDiolog("$e", context);
    }
  }

  checkEmailVerified(context, UserModel userModel) async {
    print("now in function");

    timer = Timer.periodic(const Duration(seconds: 3), (_) async {
      print("checking started");
      await FirebaseAuth.instance.currentUser?.reload();
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
      print(isEmailVerified);
      if (isEmailVerified == true) {
        print("email verified");
        timer?.cancel();
        await database.addUser(
            FirebaseAuth.instance.currentUser!.uid, userModel);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const UserSigninPage()),
            (route) => false);
      } else if (isEmailVerified == false) {}
    });
  }

  emailVarification(context, UserModel userModel) async {
    try {
      if (FirebaseAuth.instance.currentUser != null &&
          !FirebaseAuth.instance.currentUser!.emailVerified) {
        await FirebaseAuth.instance.currentUser!
            .sendEmailVerification()
            .then((value) async {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    content: Row(
                      children: [
                        const CircularProgressIndicator(),
                        Expanded(
                          child: Text(
                            "Verification Email send to ${FirebaseAuth.instance.currentUser!.email}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ));

          await checkEmailVerified(context, userModel);
        });
      }
    } catch (e) {
      customeShowDiolog("$e", context);
    }
  }

  signOutFromMAil(context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const UserSplash()),
        (route) => false);
  }

  Future<String> login(email, password, context, toPage) async {
    try {
      final credential = await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => toPage),
              (route) => false));

      return credential.user!.uid;
    } catch (e) {
      return customeShowDiolog("$e", context);
    }
  }

  customeShowDiolog(String title, BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        content: Text(
          title,
        ),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"))
        ],
      ),
    );
  }
}
