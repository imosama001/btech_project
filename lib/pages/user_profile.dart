import 'package:b_tech_project/pages/question_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.cyan[400],
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding:
                    EdgeInsets.only(top: 40, right: _size.width - 80, left: 20),
                child: IconButton(
                    onPressed: _backButtonPressed,
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.black,
                    )),
              ),
              SizedBox(
                  height: _size.height / 5.5,
                  width: _size.width,
                  child: Center(
                    child: Stack(
                      children: [
                        const CircleAvatar(
                          child: Icon(Icons.face),
                          radius: 70,
                          backgroundColor: Colors.white,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                            icon: const Icon(Icons.edit_road_rounded),
                            onPressed: _editButtonPressed,
                          ),
                        )
                      ],
                    ),
                  )),
              Container(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text(
                      "INTJ ABCD",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Discover Your True Potential",
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                child: Container(
                  width: _size.width - 40,
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.teal[300],
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 2.0,
                            offset: Offset(0, 2)),
                      ]),
                ),
                onTap: () {
                  print("Video card tapped");
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _squareCard(
                      "f", "SHORT TEST", "10 min", () {}, _size.width / 2.5),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuestionPage(),
                        ),
                      );
                    },
                    child: _squareCard(
                        "f", "LONG TEST", "30 min", () {}, _size.width / 2.5),
                  )
                ],
              ),
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
              SizedBox(
                height: _size.width / 5 + 40,
                width: _size.width,
                child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, i) =>
                      _personalityWidget("image", "ENFJ", _size.width / 4, () {
                    print("$i is tapped");
                  }),
                ),
              ),
            ],
          ),
        ));
  }

  _backButtonPressed() {
    print("back");
    Navigator.pop(context);
  }

  _editButtonPressed() {
    print('Edit');
  }

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
