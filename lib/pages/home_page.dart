import 'package:b_tech_project/pages/booking_system/booking_page2.dart';
import 'package:b_tech_project/pages/counselor_details_page.dart';
import 'package:b_tech_project/pages/counselor_list_page.dart';
import 'package:b_tech_project/pages/setting_page.dart';
import 'package:b_tech_project/repository/user_repository.dart';
import 'package:b_tech_project/services/agora/src/pages/chat_page.dart';
import 'package:b_tech_project/utilites/doctor_parameter.dart';
import 'package:b_tech_project/widgets/drawer.dart';
import 'package:b_tech_project/widgets/home_page_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  //int _selectedIndex = 0;
  late TabController _tabController;

  @override
  initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _tabController.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final UserRepository _userRepository = Provider.of<UserRepository>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          backgroundColor: Colors.amber,
        ),
        drawer: const MyDrawer(),
        body: TabBarView(
          controller: _tabController,
          children: [
            SingleChildScrollView(
              //padding: EdgeInsets.only(left: size.width * .04),
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(height: size.height * .025),
                    // CircleAvatar(
                    //   radius: size.width * .15,
                    //   backgroundImage: AssetImage('images/profile.jpeg'),
                    // ),
                    // Text("P_TYPE"),
                    // Text("Discover Your True Self"),
                    HomePageCard(
                        cardDescriptionText: "Need Help with a Rough Day?",
                        image: Image.asset('images/rough.jpg'),
                        cardString: "TAKE UP A RESCUE",
                        onButtonPressed: () {}),
                    SizedBox(
                      height: size.height * .025,
                    ),
                    HomePageCard(
                        cardDescriptionText: "Want To Enhance Poductivity",
                        image: Image.asset('images/productive.jpg'),
                        cardString: "START YOUR JOURNEY",
                        onButtonPressed: () {}),
                    SizedBox(
                      height: size.height * .025,
                    ),
                    !_userRepository.isCounsellor
                        ? HomePageCard(
                            cardDescriptionText:
                                "Need a Counselor To Help You Out",
                            image: Image.asset('images/counselor.jpg'),
                            cardString: "CONSULT A COUNSELOR",
                            onButtonPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CounselorListPage(
                                      // doctor: Doctor(
                                      //     firstName: "Peter",
                                      //     lastName: "Pane",
                                      //     image: const Image(
                                      //       image: AssetImage('mathew.png'),
                                      //     ),
                                      //     type: "type",
                                      //     rating: 4.5),
                                      ),
                                ),
                              );
                            })
                        : HomePageCard(
                            cardDescriptionText:
                                "Hi Counselor Tell Us When Are You Available",
                            image: Image.asset('images/counselor.jpg'),
                            cardString: "Provide Your Availability",
                            onButtonPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const BookingPage2(
                                      // doctor: Doctor(
                                      //     firstName: "Peter",
                                      //     lastName: "Pane",
                                      //     image: const Image(
                                      //       image: AssetImage('mathew.png'),
                                      //     ),
                                      //     type: "type",
                                      //     rating: 4.5),
                                      ),
                                ),
                              );
                            }),
                    SizedBox(height: size.height * .025),
                  ],
                ),
              ),
            ),
            const ChatPage(),
            const Text(
              'Index 2: My Bookings',
              style: optionStyle,
            ),
            SettingPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chats',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.calendarCheck),
              label: 'Bookings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: _tabController.index,
          selectedItemColor: Colors.amber[800],
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
