import 'package:b_tech_project/functions/mbti_calculations.dart';
import 'package:b_tech_project/pages/user_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'question_page.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PersonalityPage extends StatefulWidget {
  PersonalityPage(this.personalityType);

  final String personalityType;

  @override
  State<PersonalityPage> createState() => _PersonalityPageState();
}

CollectionReference personalityType =
    FirebaseFirestore.instance.collection('personalityType');

class _PersonalityPageState extends State<PersonalityPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    if (imageUrl == "") {
      getData();
    }
    super.initState();
  }

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  TabController? _controller;
  String overview = "";
  String nickname = "";
  String strength = "";
  String weakness = "";
  String career = "";
  String imageUrl = "";

  void getData() async {
    await _firebaseFirestore
        .collection('personalityTypes')
        .doc(widget.personalityType)
        .get()
        .then((value) {
      if (mounted) {
        setState(() {
          var data = value.data();
          nickname = data!['nickname'].toString().replaceFirst('\n', "\n");
          imageUrl = data['personalityImage'];
          overview = data['overview'];
          strength = data['strength'];
          weakness = data['weakness'];
          career = data['career'];

          print(value.data());
          print("%%%%%%%%%%%%");
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TabController _tabController = TabController(length: 4, vsync: this);
    const TextStyle _tabTextStyle = TextStyle(
      fontWeight: FontWeight.w700,
      color: Colors.black54,
      fontSize: 20,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: const Text('Personality overview'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          // color: Colors.amber,
          width: size.width * 2,
          height: size.height * 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            '${widget.personalityType} Personality',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            nickname,
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      Container(
                        height: 125,
                        width: 125,
                        decoration: imageUrl == "" ? null :  BoxDecoration(
                            image: DecorationImage(image: NetworkImage(
                                imageUrl
                                //TODO: Add specific pictures from firebase

                                // 'https://static.neris-assets.com/images/personality-types/avatars/intp-logician.png'
                              ))),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   height: 500,
                //   color: Colors.red,
                // )
                DefaultTabController(
                  length: 4,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                          child: TabBar(
                            isScrollable: true,
                            controller: _tabController,
                            tabs: [
                              Tab(
                                child: Text(
                                  'Overview',
                                  style: TextStyle(
                                      color: Colors.amber.withOpacity(.8),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Strength',
                                  style: TextStyle(
                                      color: Colors.green.withOpacity(.7),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Tab(
                                child: Text('Weakness',
                                    style: TextStyle(
                                        color: Colors.orange.withOpacity(.7),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700)),
                              ),
                              Tab(
                                child: Text('Career',
                                    style: TextStyle(
                                        color: Colors.blue.withOpacity(.7),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 1,
                          child:
                              TabBarView(controller: _tabController, children: [
                            Container(
                              //height: double.infinity,

                              // width: 60,
                              //color: Colors.green,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  child: Text(
                                    // "An Architect (INTJ) is a person with the Introverted, Intuitive, Thinking, and Judging personality traits.\n\nThese thoughtful tacticians love perfecting the details of life, applying creativity and rationality to everything they do. Their inner world is often a private, complex one.Architects, independent to the core, want to shake off other people’s expectations and pursue their own ideas.Architects don’t just learn new things for show – they genuinely enjoy expanding the limits of their knowledge.At times, Architects may wonder whether dealing with other people is even worth the frustration."
                                    // "An Architect (INTJ) is a person with the Introverted, Intuitive, Thinking, and Judging personality traits.\n\nThese thoughtful tacticians love perfecting the details of life, applying creativity and rationality to everything they do. Their inner world is often a private, complex one.Architects, independent to the core, want to shake off other people’s expectations and pursue their own ideas.Architects don’t just learn new things for show – they genuinely enjoy expanding the limits of their knowledge.At times, Architects may wonder whether dealing with other people is even worth the frustration."
                                    overview.replaceAll(r'\n', '\n'),
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black.withOpacity(1)),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ),

                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.amber.withOpacity(.1)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 60,
                                width: 60,
                                child: Text(
                                  // "Rational – Architects pride themselves on the power of their minds. Informed – Few personality types are as devoted as Architects to developing rational, correct, and evidence-based opinions.Creative and self-motivated, Architects strive to do things their own way. They are determind and curious."
                                  strength.replaceAll(r'\n', '\n'),
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black.withOpacity(1)),
                                  textAlign: TextAlign.justify,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.green.withOpacity(.1)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 60,
                                width: 60,
                                child: Text(
                                  // "Arrogant – Architects might be knowledgeable, but they’re not infallible.Dismissive of Emotions – For Architects, rationality is king. But emotional context often matters more than people with this personality type care to admit. Overly Critical – These personalities tend to have a great deal of self-control, particularly when it comes to thoughts and feelings. Socially Clueless – Architects’ relentless rationality can lead to frustration in their social lives. "
                                  weakness.replaceAll(r'\n', '\n'),
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black.withOpacity(1)),
                                  textAlign: TextAlign.justify,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.orange.withOpacity(.1)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 60,
                                width: 60,
                                child: Text(
                                  // "The Early-Career Blues:  In the workplace, Architect personalities are often known for competence and effectiveness.People with this personality type value resourcefulness, grit, insight, and commitment – in themselves and in others."
                                  career.replaceAll(r'\n', '\n'),
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black.withOpacity(1)),
                                  textAlign: TextAlign.justify,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.blue.withOpacity(.1)),
                              ),
                            )
                          ]),
                        ),
                        // TabBarView(controller: _tabController, children: [
                        //   SingleChildScrollView(
                        //     child: Container(
                        //       color: Colors.red,
                        //       height: 50,
                        //       width: 50,
                        //     ),
                        //     // child: Column(
                        //     //   children: [
                        //     //     SizedBox(
                        //     //       height: size.height * .02,
                        //     //     ),
                        //     //     Container(
                        //     //       height: 50,
                        //     //       width: 50,
                        //     //     ),
                        //     //     SizedBox(
                        //     //       height: 30,
                        //     //     ),
                        //     //   ],
                        //     // ),
                        //   ),
                        //   SingleChildScrollView(
                        //     child: Column(
                        //       children: [
                        //         SizedBox(
                        //           height: size.height * .02,
                        //         ),
                        //         Container(
                        //           height: 50,
                        //           width: 50,
                        //         ),
                        //         SizedBox(
                        //           height: 30,
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        //   SingleChildScrollView(
                        //     child: Column(
                        //       children: [
                        //         SizedBox(
                        //           height: size.height * .02,
                        //         ),
                        //         Container(
                        //           height: 50,
                        //           width: 50,
                        //         ),
                        //         SizedBox(
                        //           height: 30,
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        //   SingleChildScrollView(
                        //     child: Column(
                        //       children: [
                        //         SizedBox(
                        //           height: size.height * .02,
                        //         ),
                        //         Container(
                        //           height: 50,
                        //           width: 50,
                        //         ),
                        //         SizedBox(
                        //           height: 30,
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ]),
                        // Container(
                        //   //height: size.height * 0.47,
                        //   color: Colors.white,
                        //   child:
                        //       TabBarView(controller: _tabController, children: [
                        //     SingleChildScrollView(
                        //       child: Column(
                        //         children: [
                        //           SizedBox(
                        //             height: size.height * .02,
                        //           ),
                        //           Container(
                        //             height: 50,
                        //             width: 50,
                        //           ),
                        //           SizedBox(
                        //             height: 30,
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ]),
                        // ),
                        // Container(
                        //   //height: size.height * 0.47,
                        //   color: Colors.white,
                        //   child:
                        //       TabBarView(controller: _tabController, children: [
                        //     SingleChildScrollView(
                        //       child: Column(
                        //         children: [
                        //           SizedBox(
                        //             height: size.height * .03,
                        //           ),
                        //           Container(
                        //             height: 50,
                        //             width: 50,
                        //           ),
                        //           SizedBox(
                        //             height: 30,
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ]),
                        // ),
                        // Container(
                        //   //height: size.height * 0.47,
                        //   color: Colors.white,
                        //   child:
                        //       TabBarView(controller: _tabController, children: [
                        //     SingleChildScrollView(
                        //       child: Column(
                        //         children: [
                        //           SizedBox(
                        //             height: size.height * .03,
                        //           ),
                        //           // Container(
                        //           //   height: 50,
                        //           //   width: 50,
                        //           // ),
                        //         ],
                        //       ),
                        //     ),
                        //   ]),
                        // )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
