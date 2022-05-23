import 'package:b_tech_project/pages/Personality_Page.dart';
import 'package:b_tech_project/pages/question_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:cloud_firestore/cloud_firestore.dart";

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

String name = "--------" * 2;
String photoUrl = '';
String personalityType = '';

class _UserProfileState extends State<UserProfile> {
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
          personalityType = data['personalityType'];
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

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
        // backgroundColor: Colors.cyan[400],
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.amber,
      ),
        body: SingleChildScrollView(
          physics:BouncingScrollPhysics(),
      child: Column(
        children: [
         const SizedBox(height: 20),
          // Container(
          //   padding: EdgeInsets.only(top: 40, right: _size.width - 0, left: 0),
          //   child: IconButton(
          //       onPressed: _backButtonPressed,
          //       icon: const Icon(
          //         Icons.arrow_back,
          //         size: 30,
          //         color: Colors.black,
          //       )),
          // ),
          Center(
            child: CircleAvatar(
              radius: _size.width * .2,
              backgroundImage:
              //Add network image
              photoUrl == '' ? null :  NetworkImage(photoUrl),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const SizedBox(
                  height: 25,
                ),
                Text(
                  name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                (personalityType != "")
                    ? Text(
                        personalityType,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 19),
                      )
                    : const Text(
                        "Personality Not calculated...",
                        style: TextStyle(fontSize: 19),
                      ),
                const SizedBox(height: 20,),
                const Text(
                  "Discover Your True Potential",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuestionPage(),
                ),
              );
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(blurRadius: 2, offset: Offset(1, 2))
                  ]),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "Take the Personality Test",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              ),
            ),
          )
          // GestureDetector(
          //   child: Container(
          //     width: _size.width - 40,
          //     height: 200,
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(20),
          //         color: Colors.teal[300],
          //         boxShadow: const [
          //           BoxShadow(
          //               color: Colors.black,
          //               blurRadius: 2.0,
          //               offset: Offset(0, 2)),
          //         ]),
          //   ),
          //   onTap: () {
          //     print("Video card tapped");
          //   },
          // ),
          ,
          const SizedBox(
            height: 20,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     _squareCard("f", "SHORT TEST", "10 min", () {
          //       Navigator.of(context).push(MaterialPageRoute(
          //         builder: (context) => PersonalityPage('INTJ'),
          //       ));
          //     }, _size.width / 2.5),
          //     GestureDetector(
          //       onTap: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => QuestionPage(),
          //           ),
          //         );
          //       },
          //       child: _squareCard(
          //           "f", "LONG TEST", "30 min", () {}, _size.width / 2.5),
          //     )
          //   ],
          // ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "16 Personality Types",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                width: 100,
              ),
              GestureDetector(
                child: const Text(
                  "View all",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                onTap: () {
                  print("view all clicked");
                },
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PersonalityPage("INTJ"),
                        ),
                      );

                },
                    child: Container(
                      height: _size.width*.2,
                      width: _size.width*.2,
                      child: Image(image:AssetImage('images/intj.png')),
                    ),
                  ),
                  Text("INTJ"),
                ],
              ),
              SizedBox(width: _size.width*.06,),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PersonalityPage("INTP"),
                        ),
                      );

                    },
                    child: Container(
                      height: _size.width*.2,
                      width: _size.width*.2,
                      child: Image(image:AssetImage('images/intp.png')),
                    ),
                  ),
                  Text("INTP"),
                ],
              ),
              SizedBox(width: _size.width*.06,),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PersonalityPage("ENTJ"),
                        ),
                      );

                    },
                    child: Container(
                      height: _size.width*.2,
                      width: _size.width*.2,
                      child: Image(image:AssetImage('images/entj.png')),
                    ),
                  ),
                  Text("ENTJ"),
                ],
              ),
              SizedBox(width: _size.width*.06,),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PersonalityPage("ENTP"),
                        ),
                      );

                    },
                    child: Container(
                      height: _size.width*.2,
                      width: _size.width*.2,
                      child: Image(image:AssetImage('images/entp.png')),
                    ),
                  ),
                  Text("ENTP"),
                ],
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PersonalityPage("INFJ"),
                        ),
                      );

                    },
                    child: Container(
                      height: _size.width*.2,
                      width: _size.width*.2,
                      child: Image(image:AssetImage('images/infj.jpeg')),
                    ),
                  ),
                  Text("INFJ"),
                ],
              ),
              SizedBox(width: _size.width*.06,),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PersonalityPage("INFP"),
                        ),
                      );

                    },
                    child: Container(
                      height: _size.width*.2,
                      width: _size.width*.2,
                      child: Image(image:AssetImage('images/infp.jpeg')),
                    ),
                  ),
                  Text("INFP"),
                ],
              ),
              SizedBox(width: _size.width*.06,),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PersonalityPage("ENFJ"),
                        ),
                      );

                    },
                    child: Container(
                      height: _size.width*.2,
                      width: _size.width*.2,
                      child: Image(image:AssetImage('images/enfj.jpeg')),
                    ),
                  ),
                  Text("ENFJ"),
                ],
              ),
              SizedBox(width: _size.width*.06,),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PersonalityPage("ENFP"),
                        ),
                      );

                    },
                    child: Container(
                      height: _size.width*.2,
                      width: _size.width*.2,
                      child: Image(image:AssetImage('images/enfp.jpeg')),
                    ),
                  ),
                  Text("ENFP"),
                ],
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PersonalityPage("ISTJ"),
                        ),
                      );

                    },
                    child: Container(
                      height: _size.width*.2,
                      width: _size.width*.2,
                      child: Image(image:AssetImage('images/istj.jpeg')),
                    ),
                  ),
                  Text("ISTJ"),
                ],
              ),
              SizedBox(width: _size.width*.06,),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PersonalityPage("ISFJ"),
                        ),
                      );

                    },
                    child: Container(
                      height: _size.width*.2,
                      width: _size.width*.2,
                      child: Image(image:AssetImage('images/isfj.png')),
                    ),
                  ),
                  Text("ISFJ"),
                ],
              ),
              SizedBox(width: _size.width*.06,),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PersonalityPage("ESTJ"),
                        ),
                      );

                    },
                    child: Container(
                      height: _size.width*.2,
                      width: _size.width*.2,
                      child: Image(image:AssetImage('images/estj.png')),
                    ),
                  ),
                  Text("ESTJ"),
                ],
              ),
              SizedBox(width: _size.width*.06,),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PersonalityPage("ESFJ"),
                        ),
                      );

                    },
                    child: Container(
                      height: _size.width*.2,
                      width: _size.width*.2,
                      child: Image(image:AssetImage('images/esfj.jpeg')),
                    ),
                  ),
                  Text("ESFJ"),
                ],
              ),
            ],
          ),
          SizedBox(height: 10,),

          Row(
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PersonalityPage("ISTP"),
                        ),
                      );

                    },
                    child: Container(
                      height: _size.width*.2,
                      width: _size.width*.2,
                      child: Image(image:AssetImage('images/istp.jpeg')),
                    ),
                  ),
                  Text("ISTP"),
                ],
              ),
              SizedBox(width: _size.width*.06,),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PersonalityPage("ISFP"),
                        ),
                      );

                    },
                    child: Container(
                      height: _size.width*.2,
                      width: _size.width*.2,
                      child: Image(image:AssetImage('images/isfp.jpeg')),
                    ),
                  ),
                  Text("ISFP"),
                ],
              ),
              SizedBox(width: _size.width*.06,),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PersonalityPage("ESTP"),
                        ),
                      );

                    },
                    child: Container(
                      height: _size.width*.2,
                      width: _size.width*.2,
                      child: Image(image:AssetImage('images/estp.jpeg')),
                    ),
                  ),
                  Text("ESTP"),
                ],
              ),
              SizedBox(width: _size.width*.06,),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PersonalityPage("ESFP"),
                        ),
                      );

                    },
                    child: Container(
                      height: _size.width*.2,
                      width: _size.width*.2,
                      child: Image(image:AssetImage('images/esfp.png')),
                    ),
                  ),
                  Text("ESFP"),
                ],
              ),
            ],
          ),
          SizedBox(height: 30,)
        ],
      ),
    ));
  }

  // _backButtonPressed() {
  //   print("back");
  //   Navigator.pop(context);
  // }

  // _editButtonPressed() {
  //   print('Edit');
  // }

  Widget _squareCard(String imageLocation, String name, String time,
      Function onTap, double side) {
    return Container(
      height: side,
      width: side,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.teal[300],
          boxShadow: const [
            BoxShadow(
                color: Colors.black, blurRadius: 3.0, offset: Offset(0, 2)),
          ]),
      child: Stack(
        children: [
          //image
          Positioned(
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.cyan[400]),
              height: 50,
              width: side,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(time),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _personalityWidget(
      String image, String name, double width, Function onTap) {
    return GestureDetector(
        child: SizedBox(
          height: width,
          width: width,
          child: Column(
            children: [
              CircleAvatar(
                radius: width / 2 - 10,
                child: const Icon(Icons.image),
              ),
              Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        onTap: () {
          onTap();
        });
  }
}
