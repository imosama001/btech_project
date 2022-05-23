import 'dart:ui';

import 'package:b_tech_project/repository/slotBookingRepository.dart';
import 'package:b_tech_project/utilites/doctor_parameter.dart';
import 'package:b_tech_project/widgets/counselor_hd_cell.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DoctorBookingPage extends StatefulWidget {
  final Doctor doctor;
  const DoctorBookingPage({Key? key, required this.doctor}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _DoctorDetailState();
}

List<dynamic> slotDetailList = [];
Set<String> availableDates = {};
String selectedDate = "";

List<String> time = [];
String selectedTime = "";

bool isDataLoaded = false;

class _DoctorDetailState extends State<DoctorBookingPage> {
  Future<void> makeApointment() async {
    // store appointment data in user's data store
    // update doctor side with token and tokenExpiry
    String strTimeSlot = (int.parse(selectedTime.split(' ')[0]) +
            (selectedTime.split(' ')[1] == 'pm' ? 12 : 0))
        .toString();
    if (strTimeSlot.length == 1) {
      strTimeSlot = '0' + strTimeSlot;
    }
    DateTime time = DateTime.parse(selectedDate + "T" + strTimeSlot + ':' + '00' + ':' + '00');
    print(time);
    await SlotRepository().makeAppointment(
      counselorUid: widget.doctor.uid,
      timestamp: time.millisecondsSinceEpoch,
      selectedTimeString: selectedTime,
      counselorName: widget.doctor.name,
    );

    setTimeSlotList(selectedDate);
  }

  Future<void> setSlotDetailList() async {
    print('#' * 30);
    isDataLoaded = false;
    slotDetailList = [];

    FirebaseFirestore.instance
        .collection("users")
        .doc(widget.doctor.uid)
        .collection("slots")
        .limit(7)
        .where(
          "timestamp",
          isGreaterThan: DateTime.now()
              .add(const Duration(days: -1))
              .millisecondsSinceEpoch,
        )
        .get()
        .then((value) {
      print('*' * 30);
      print(value.docs);
      for (var doc in value.docs) {
        if (!availableDates.contains(doc.id)) {
          availableDates.add(doc.id);
        }
        List<dynamic> data = doc.data()['slot'];

        Map slotMap = {};

        for (int i = 0; i < data.length; i++) {
          var slot = data[i];

          if (slot['timestamp'] != null &&
              slot['bookedTo'] == null &&
              slot['timestamp'] > DateTime.now().millisecondsSinceEpoch) {
            data.add({'date': doc.id});
            var d = {
              "bookedTo": slot['bookedTo'],
              "time": slot['time'],
              "timestamp": slot['timestamp'],
            };

            slotMap[doc.id] = d;

            /// {date: {time: details, time: details}}

            slotDetailList.add(slotMap);
          }
        }
      }
      if (mounted) {
        setState(() {
          isDataLoaded = true;
        });
      }
    });
  }

  Future<void> setTimeSlotList(String date) async {
    if (mounted) {
      setState(() {
        time = [];
      });
    }
    FirebaseFirestore.instance
        .collection("users")
        .doc(widget.doctor.uid)
        .collection("slots")
        .doc(date)
        .get()
        .then((value) {
      var slots = value.data()!['slot'];
      for (var s in slots) {
        if (s['bookedTo'] == null) {
          if (mounted) {
            setState(() {
              time.add(s['time']);
            });
          }
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setSlotDetailList();
    // get data: users (type counsellor) > date (show dates)
  }

  List<String> monthList = [
    "Jan",
    "Feb",
    'Mar',
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sept",
    "Oct",
    "Nov",
    "Dec",
  ];

  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    print(availableDates);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xff00C6AD),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              margin: const EdgeInsets.only(right: 15),
              child: const Icon(
                Icons.notifications_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: !isDataLoaded
          ? const CircularProgressIndicator()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(
                  //   margin: const EdgeInsets.only(left: 20, top: 30),
                  //   child: const Text(
                  //     'DEC 2021',
                  //     style: TextStyle(
                  //       color: Color(0xff363636),
                  //       fontSize: 25,
                  //       fontFamily: 'Roboto',
                  //       fontWeight: FontWeight.w700,
                  //     ),
                  //   ),
                  // ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
                    height: 90,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (String date in availableDates)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedDate = date;
                                setTimeSlotList(selectedDate);
                              });
                            },
                            child: demoDates(
                                monthList[DateTime.parse(date).month - 1],
                                date.split('-')[2],
                                selectedDate == date),
                          ),
                        // demoDates("", "22", false),
                        // demoDates("", "23", false),
                        // demoDates("", "24", false),
                        // demoDates("", "25", false),
                        // demoDates("", "26", false),
                        // demoDates("", "27", false),
                        // demoDates("", "28", false),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, top: 30),
                    child: const Text(
                      'Time',
                      style: TextStyle(
                        color: Color(0xff363636),
                        fontSize: 25,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  false
                      ? CircularProgressIndicator()
                      : Container(
                          margin: const EdgeInsets.only(right: 20),
                          child: GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 3,
                            physics: const NeverScrollableScrollPhysics(),
                            childAspectRatio: 2.7,
                            children: [
                              for (String t in time)
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedTime = t;
                                      });
                                    },
                                    child: doctorTimingsData(
                                        t, selectedTime == t)),
                            ],
                          ),
                        ),

                  GestureDetector(
                    onTap: () async {
                      await makeApointment();
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: 54,
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xff107163),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x17000000),
                            offset: Offset(0, 15),
                            blurRadius: 15,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: const Text(
                        'Make An Appointment',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget demoDates(String day, String date, bool isSelected) {
    return isSelected
        ? Container(
            width: 70,
            margin: const EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              color: const Color(0xff107163),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  day,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(7),
                  child: Text(
                    date,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          )
        : Container(
            width: 70,
            margin: const EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              color: const Color(0xffEEEEEE),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    day,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(7),
                  child: Text(
                    date,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
  }

  Widget doctorTimingsData(String time, bool isSelected) {
    return isSelected
        ? Container(
            margin: const EdgeInsets.only(left: 18, top: 10),
            decoration: BoxDecoration(
              color: const Color(0xff107163),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 2),
                  child: const Icon(
                    Icons.access_time,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 2),
                  child: Text(
                    time,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container(
            margin: const EdgeInsets.only(left: 18, top: 10),
            decoration: BoxDecoration(
              color: const Color(0xffEEEEEE),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 2),
                  child: const Icon(
                    Icons.access_time,
                    color: Colors.black,
                    size: 15,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 2),
                  child: Text(
                    time,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
