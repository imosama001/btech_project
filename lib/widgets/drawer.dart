import 'package:b_tech_project/widgets/home_page_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            DrawerHeader(
              padding: EdgeInsets.only(
                  right: size.width * .25, top: size.height * .02),
              child: GestureDetector(
                //TODO: add functionality to go to profile page which include personality tests
                onTap: () {},

                child: Column(
                  children: [
                    CircleAvatar(
                      radius: size.width * .12,
                      backgroundImage: const AssetImage('images/profile.jpeg'),
                    ),
                    const Text(
                      'Full Name',
                      style: kDrawerTextStyle,
                    ),
                    const Text(
                      "P_TYPE",
                      style: kDrawerTextStyle,
                    ),
                    //const Text("Discover Your True Self"),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                const Padding(padding: EdgeInsets.all(10)),
                const Icon(Icons.account_box_outlined),
                SizedBox(width: size.width * .03),
                const Text(
                  "My Account",
                  style: kDrawerTextStyle,
                ),
              ],
            ),
            const Divider(
              thickness: 2,
            ),
            Row(
              children: [
                const Padding(padding: EdgeInsets.all(10)),
                const Icon(FontAwesomeIcons.questionCircle),
                SizedBox(width: size.width * .03),
                const Text(
                  "Help & Support",
                  style: kDrawerTextStyle,
                ),
              ],
            ),
            const Divider(
              thickness: 2,
            ),
            Row(
              children: [
                const Padding(padding: EdgeInsets.all(10)),
                const Icon(Icons.privacy_tip_outlined),
                SizedBox(width: size.width * .03),
                const Text(
                  "Privacy Policy",
                  style: kDrawerTextStyle,
                ),
              ],
            ),
            const Divider(
              thickness: 2,
            ),
            Row(
              children: [
                const Padding(padding: EdgeInsets.all(10)),
                const Icon(Icons.account_box_outlined),
                SizedBox(width: size.width * .03),
                const Text(
                  "About Us",
                  style: kDrawerTextStyle,
                ),
              ],
            ),
            const Divider(
              thickness: 2,
            ),
          ],
        ),
      ),
    );
  }
}

const kDrawerTextStyle =
    TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18);
