import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:b_tech_project/repository/user_repository.dart';
import 'package:b_tech_project/services/agora/call.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpcomingBookingPage extends StatefulWidget {
  const UpcomingBookingPage({Key? key}) : super(key: key);

  @override
  State<UpcomingBookingPage> createState() => _UpcomingBookingPageState();
}

bool isDataLoaded = false;
List<dynamic> upcomingBooking = [];

var currentUser = {};
bool isCounselor = false;

Future<void> getUpcomingBooking(setState) async {
  setState(() {
    isDataLoaded = false;
  });
  String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  UserRepository().getCurrentUserDetails().then((user) {
    if (!user['isCounselor']) {
      setState(() => {
        isCounselor = !user['isCounselor'],
      });
      FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserId)
          .collection("bookings")
          .where("timestamp",
              isGreaterThan: DateTime.now()
                  .add(const Duration(hours: -1))
                  .millisecondsSinceEpoch)
          .get()
          .then((value) {
        upcomingBooking = [];

        var docs = value.docs;
        for (var doc in docs) {
          var data = doc.data();
          upcomingBooking.add({
            "name": data['counselorName'],
            "timestamp": data['timestamp'],
            "channelName": data['channel'],
            "token": data['token'],
          });
        }

        setState(() {
          isDataLoaded = true;
        });
      });
    } else {
      print('counselor');
      FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserId)
          .collection("slots")
          .where("timestamp",
              isGreaterThanOrEqualTo: DateTime.now()
                  .add(const Duration(hours: -24))
                  .millisecondsSinceEpoch)
          .get()
          .then((value) {
        upcomingBooking = [];
        setState(() {
          isDataLoaded = false;
        });
        var docs = value.docs;
        for (var doc in docs) {
          print(doc.data().toString() + '\n');

          var data = doc.data();
          for (var s in data['slot']) {
            if (s['bookedTo'] != null) {
              print("()");
              print(s['timestamp'] ?? 'null cn');
              print("()");
              upcomingBooking.add({
                "name": s['bookedToUsername'],
                "timestamp": s['timestamp'],
                "channelName": s['channelName'].trim(),
                "token": s['token'].trim(),
              });
            }
          }
        }

        setState(() {
          isDataLoaded = true;
        });

      });
    }
  });
}

class _UpcomingBookingPageState extends State<UpcomingBookingPage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      getUpcomingBooking(setState);
    });

    print(upcomingBooking);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: !isDataLoaded
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                   const SizedBox(height: 10,),
                   const SizedBox(height: 20,),
                   Container(
                     height: size.height*.14,
                     width: size.width*.9,
                     decoration: const BoxDecoration(
                       color: Colors.white60,

                     ),
                     child: Column(
                       children: [
                         SizedBox(height: 10,),
                         const Text("CURRENT BOOING",style: TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 16,
                         ),),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children:[
                           Text(!isCounselor ? "Malik" : "Dr. Osama",style: TextStyle(fontSize: 18),),
                           ElevatedButton(onPressed: (){
                             Navigator.of(context).push(MaterialPageRoute(builder: (context) => CallPage(channelName: '3b1cfa4f', role: ClientRole.Broadcaster, token: '00640698abcaa7b4e899459d97d697b214aIAAqjo1oTCI9338CSo+1r4eNFiiQJsLlCuh3F99PZZYvEfwxXisAAAAAEABfMmJfRiyFYgEAAQDGZo5i'),));
                           }, child: Text("JOIN NOW",),),

                         ],),
                       ],
                     ),
                   ),
                   Divider(thickness: 3,),

                   const Text("UPCOMING BOOKINGS",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),),
                    const  SizedBox(height: 10,),
                    for (var upcoming in upcomingBooking)
                      SizedBox(
                        width: size.width * 0.9,
                        child: Card(
                          elevation: 4,
                          color: Colors.white70,
                          margin: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(upcoming['name'],
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            upcoming['timestamp'],
                                        )
                                        .toString()),
                                  ),
                                ],
                              ),
                              if (upcoming['timestamp'] <
                                  DateTime.now()
                                      // .add(const Duration(hours: -1))
                                      .millisecondsSinceEpoch
                                  // && upcoming['timestamp'] <
                                  // DateTime.now()
                                  // .add(const Duration(hours: 1))
                                  //     .millisecondsSinceEpoch
                              )
                                GestureDetector(
                                  onTap: () {
                                    // start call page
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => CallPage(
                                          channelName: upcoming['channelName'],
                                          role: ClientRole.Broadcaster,
                                          token: upcoming['token']),
                                    ));
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.video_call,
                                        color: Colors.green),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
      ),
    );
  }
}
