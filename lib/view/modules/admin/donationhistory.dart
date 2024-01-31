import 'package:eatmore/view/modules/admin/donationhistorylist.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hexcolor/hexcolor.dart';

class Donation extends StatefulWidget {
  const Donation({Key? key}) : super(key: key);

  @override
  State<Donation> createState() => _DonationState();
}

class _DonationState extends State<Donation> {
  @override
  Widget build(BuildContext context) {
    // Set the locale to en_IN for Indian time
    var indianDateFormat = DateFormat('dd MMMM yyyy', 'en_IN');
    var indianTimeFormat = DateFormat('hh:mm a', 'en_IN');

    // Format today's date as "dd MMMM yyyy"
    String formattedDate = indianDateFormat.format(DateTime.now());
    // Format the current time as "hh:mm a"
    String formattedTime = indianTimeFormat.format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text(
          "Donation History",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 8),
              Container(
                height: 25,
                width: double.infinity,
                color: HexColor("E8EAED"),
                child: Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    formattedDate, // Display the formatted date here
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 655,
                child: ListView.builder(
                  itemCount: History.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const CircleAvatar(
                          backgroundImage: AssetImage("img/download.jpeg")),
                      title: Text(
                        History[index]['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '$formattedTime, $formattedDate', // Display time, date, month, and year in subtitle
                        style: const TextStyle(color: Colors.black45),
                      ),
                      trailing: Text(History[index]['rate'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
