// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:b_tech_project/functions/mbti_calculations.dart';
import 'package:b_tech_project/pages/user_profile.dart';
import 'package:flutter/material.dart';
import 'question_page.dart';

class PersonalityPage extends StatefulWidget {
  PersonalityPage(this.personalityType);

  final String personalityType;

  @override
  State<PersonalityPage> createState() => _PersonalityPageState();
}

class _PersonalityPageState extends State<PersonalityPage>
    with TickerProviderStateMixin {
  TabController? _controller;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TabController _tabController = TabController(length: 4, vsync: this);
    final TextStyle _tabTextStyle = TextStyle(
      fontWeight: FontWeight.w400,
      color: Colors.black54,
      fontSize: 18,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Personality overview'),
      ),
      body: SingleChildScrollView(
        child: Container(
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
                            '$personalityType Personality',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'The Teacher',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            personalityType + "P",
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ],
                      ),
                      Container(
                        height: 100,
                        width: 200,
                        color: Colors.red,
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
                            controller: _tabController,
                            tabs: [
                              Tab(
                                child: Text(
                                  'overview',
                                  style: _tabTextStyle,
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Strength',
                                  style: _tabTextStyle,
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Weakness',
                                  style: _tabTextStyle,
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Career',
                                  style: _tabTextStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                        TabBarView(controller: _tabController, children: [
                          Container(
                            height: 60,
                            width: 60,
                            color: Colors.red,
                          ),
                          Container(
                            height: 60,
                            width: 60,
                            color: Colors.red,
                          ),
                          Container(
                            height: 60,
                            width: 60,
                            color: Colors.red,
                          ),
                          Container(
                            height: 60,
                            width: 60,
                            color: Colors.red,
                          )
                        ]),
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
