import 'package:eatmore/model/add_new_item.dart';
import 'package:eatmore/view%20model/database.dart';
import 'package:eatmore/view/modules/user/menudetails.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class UserMenue extends StatefulWidget {
  const UserMenue({Key? key}) : super(key: key);

  @override
  State<UserMenue> createState() => _UserMenueState();
}

class _UserMenueState extends State<UserMenue> {
  List<AddNewItemModel> data = [];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    // selected = Provider.of<Database>(context, listen: true).itemList;
    data = Provider.of<Database>(context).selectedCategoryItem;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text(
          "Menu",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.only(left: 15.0, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Find Your Best Food",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const Text(
              "Order & Eat. ",
              style: TextStyle(fontSize: 19),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Search ",
                hintStyle: TextStyle(color: HexColor("ADAAAA")),
                prefixIcon: Icon(
                  Icons.search,
                  color: HexColor("ADAAAA"),
                ),
                fillColor: HexColor("E1FED3"),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(25),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(25),
                ),
                contentPadding: const EdgeInsets.only(
                  left: 10,
                  top: 10,
                  bottom: 10,
                ),
              ),
            ),
            SizedBox(
              height: height * .02,
            ),
            SizedBox(
              height: height * .14,
              child: ClickableList(),
            ),
            SizedBox(
              height: height * .04,
            ),
            const Divider(),
            SizedBox(
              height: height * .02,
            ),
            Expanded(
              child: data.isEmpty
                  ? const Center(child: Text("No item found"))
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                            elevation: 3,
                            color: Colors.white, // Set the color to white
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MenuDetails(
                                          itemId: data[index].itemId!,
                                          name: data[index].itemName,
                                          rating: data[index].rating,
                                          details: data[index].moreDetail,
                                          img: data[index].itemImage,
                                          price: data[index].itemPrice),
                                    ));
                              },
                              child: Container(
                                height: 150,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin: const EdgeInsets.all(8),
                                child: Center(
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 55,
                                        backgroundImage:
                                            NetworkImage(data[index].itemImage),
                                      ),
                                      Text(
                                        data[index].itemName.toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(.6),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "₹${data[index].itemPrice}",
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(.6),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class ClickableList extends StatelessWidget {
  ClickableList({
    super.key,
  });

  Map<String, dynamic> head = {
    "Items": ["Snacks", "Non-Veg", "Veg", "Drinks"],
    "image": [
      "img/category/snacks.jpg",
      "img/category/non veg.jpg",
      "img/category/veg.jpg",
      "img/category/drinks.jpg",
    ]
  };
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 4,
      itemBuilder: (context, index) {
        return Row(
          children: [
            GestureDetector(
              onTap: () {
                Provider.of<Database>(context, listen: false)
                    .fetchselectedCategoryItem(head["Items"][index]);
              },
              child: Container(
                height: 115,
                width: 60,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 249, 213, 255),
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 5),
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(head["image"][index]),
                    ),
                    const SizedBox(height: 5),
                    RotatedBox(
                      quarterTurns: 3,
                      child: Text(head['Items'][index] ?? ''),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 15),
          ],
        );
      },
    );
  }
}
