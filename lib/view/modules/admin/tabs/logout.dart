// import 'package:eatmore/utils/instence.dart';
// import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';

// class LogOut extends StatefulWidget {
//   const LogOut({Key? key}) : super(key: key);

//   @override
//   State<LogOut> createState() => _LogOutState();
// }

// class _LogOutState extends State<LogOut> {
//   @override
//   void initState() {
//     super.initState();
//     // Use Future.delayed to call _showLogOutConfirmationDialog after initState completes
//     Future.delayed(Duration.zero, () {
//       _showLogOutConfirmationDialog();
//     });
//   }

//   void _showLogOutConfirmationDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text(
//             "Log Out?",
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           content: Text(
//             "Are you sure you want to log out?",
//             style: TextStyle(color: HexColor("6B6E82")),
//           ),
//           actions: <Widget>[
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               style: ElevatedButton.styleFrom(
//                 primary: Colors.white10,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//               ),
//               child: const Text(
//                 "Cancel",
//                 style: TextStyle(color: Colors.black38),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 auth.signOutFromMAil(context);
//               },
//               style: ElevatedButton.styleFrom(
//                 primary: HexColor("FF3326"),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//               ),
//               child: const Text(
//                 "Log Out",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "LogOut",
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         leading: IconButton(
//           onPressed: () {},
//           icon: const Icon(Icons.arrow_back_ios_new_rounded),
//         ),
//         centerTitle: true,
//       ),
//       body: const Center(
//         child: Text("LOGOUT"),
//       ),
//     );
//   }
// }
