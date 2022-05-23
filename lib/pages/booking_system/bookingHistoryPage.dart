import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BookingHistoryPage extends StatefulWidget {
  const BookingHistoryPage({Key? key}) : super(key: key);

  @override
  State<BookingHistoryPage> createState() => _BookingHistoryPageState();
}

bool isDataLoaded = false;
List<dynamic> bookingHistories = [];

Future<void> getBookingHistories(setState) async {
  setState(() {
    isDataLoaded = false;
  });
  String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  FirebaseFirestore.instance
      .collection("users")
      .doc(currentUserId)
      .collection("bookings")
      .where("timestamp", isLessThan: DateTime.now().millisecondsSinceEpoch)
      .get()
      .then((value) {
    bookingHistories = [];

    var docs = value.docs;
    for (var doc in docs) {
      var data = doc.data();
      bookingHistories.add({
        "counselorName": data['counselorName'],
        "timestamp": data['timestamp'],
      });
    }

    setState(() {
      isDataLoaded = true;
    });
  });

}

class _BookingHistoryPageState extends State<BookingHistoryPage> {
  @override
  void initState() {

    super.initState();
    setState(() {

      getBookingHistories(setState);
    });

    print(bookingHistories);
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
                    SizedBox(height: 20,),
                    Text("PREVIOUS BOOINGS",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),),
                    SizedBox(height: 20,),
                    for (var history in bookingHistories)
                      SizedBox(
                        width: size.width * 0.9,
                        child: Card(
                          color: Colors.white70,
                          elevation: 4,
                          margin: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Dr. ' + history['counselorName'],
                                    style: const TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(DateTime.fromMillisecondsSinceEpoch(history['timestamp']).toString()),
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
