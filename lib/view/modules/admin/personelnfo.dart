import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class PersonelInfo extends StatelessWidget {
  const PersonelInfo({Key? key}) : super(key: key);

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
            onPressed: () {}, icon: const Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
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
                const Text(
                  "MUHAMMED V",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(
                  width: 25,
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
                height: 50,
                width: 315,
                child: TextField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("E1FED3"),
                      hintText: "Full Name",
                      hintStyle: const TextStyle(fontSize: 13),
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: HexColor("FB6F3D"),
                      ),
                      enabledBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none)),
                )),
            Container(
                height: 50,
                width: 315,
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("E1FED3"),
                      hintText: "Email",
                      hintStyle: const TextStyle(fontSize: 13),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: HexColor("413DFB"),
                      ),
                      enabledBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none)),
                )),
            Container(
                height: 50,
                width: 315,
                child: TextField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("E1FED3"),
                      hintText: "Phone Number",
                      hintStyle: const TextStyle(fontSize: 13),
                      prefixIcon: Icon(
                        Icons.call,
                        color: HexColor("369BFF"),
                      ),
                      enabledBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none)),
                )),
          ],
        ),
      ),
    );
  }
}
