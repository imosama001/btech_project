import 'package:b_tech_project/pages/add_counselor_details.dart';
import 'package:b_tech_project/pages/upload_counselor_certificates.dart';
import 'package:b_tech_project/pages/user_profile.dart';
import 'package:b_tech_project/widgets/home_page_card.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:b_tech_project/pages/upload_counselor_certificates.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

String name = "--------" * 2;
String photoUrl = '';
String personalityType = '';

class _MyDrawerState extends State<MyDrawer> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  var currentser = FirebaseAuth.instance.currentUser;

  void getData() async {
    await _firebaseFirestore
        .collection('users')
        .doc(currentser!.uid)
        .get()
        .then((value) {
      if (mounted) {
        setState(() {
          var data = value.data();
          name = data!['name'];
          photoUrl = data['photoUrl'];
          print(value.data());
          print("%%%%%%%%%%%%");
        });
      }
    });
  }

  @override
  void initState() {
    if (photoUrl == "") getData();
    super.initState();
  }

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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserProfile(),
                          ),
                        );
                      },
                      // onTap: () {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => AddCounsellorDetails(),
                      //     ),
                      //   );
                      // },
                      child: CircleAvatar(
                        radius: size.width * .12,
                        backgroundImage:
                            //Add network image
                            NetworkImage(photoUrl),
                      ),
                    ),
                    Text(
                      name,
                      style: kDrawerTextStyle,
                    ),
                    Text(
                      personalityType,
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
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UploadCounselorCertificate(),
                  ),
                );
              },
              child: Row(
                children: [
                  const Padding(padding: EdgeInsets.all(10)),
                  const Icon(FontAwesomeIcons.bookMedical),
                  SizedBox(width: size.width * .03),
                  const Text(
                    "Are You a Counselor?",
                    style: kDrawerTextStyle,
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            Row(
              children: [
                const Padding(padding: EdgeInsets.all(10)),
                const Icon(Icons.calendar_today),
                SizedBox(width: size.width * .03),
                const Text(
                  "Previous Booking",
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
