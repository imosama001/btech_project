import 'dart:convert';

import 'package:b_tech_project/repository/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

enum state {
  initial,
  loading,
  done,
}

// for doctor
class SlotRepository extends ChangeNotifier {
  state _state = state.initial;
  state get appState => _state;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User _currentUser = FirebaseAuth.instance.currentUser!;
  final uuid = const Uuid();

  Future<List<dynamic>> getSlotsCounselorSide(String date) async {
    _state = state.loading;
    notifyListeners();
    List<dynamic> slots = [];
    var snap = await _firestore
        .collection('users')
        .doc(_currentUser.uid)
        .collection('slots')
        .doc(date)
        .get();

    if (!snap.exists) {
      return [];
    }

    var timeSlots = snap.data()!['slot'];
    for (var slot in timeSlots) {
      slots.add({
        'time': slot['time'],
        'bookedTo': slot['bookedTo'],
      });
    }
    _state = state.done;
    return slots;
  }

  Future<void> storeSlots(String date, List<String> timeSlots) async {
    Map<String, dynamic> data = {
      'slot': [],
      'timestamp': DateTime.parse(date).millisecondsSinceEpoch,
    };
    for (String slot in timeSlots) {
      String strTimeSlot = (int.parse(slot.split(' ')[0]) +
              (slot.split(' ')[1] == 'pm' ? 12 : 0))
          .toString();
      if (strTimeSlot.length == 1) {
        strTimeSlot = '0' + strTimeSlot;
      }
      print('(((((((\n' + strTimeSlot);
      DateTime time = DateTime.parse(date + "T" + strTimeSlot + ':' + '00' + ':' +'00');
      print(time);
      print('****************');

      data['slot']!.add({
        'time': slot,
        'bookedTo': null,
        'timestamp': time.millisecondsSinceEpoch
      });
    }
    var df = await _firestore
        .collection('users')
        .doc(_currentUser.uid)
        .collection('slots')
        .doc(date).get();
    if (!df.exists) {
      await _firestore
        .collection('users')
        .doc(_currentUser.uid)
        .collection('slots')
        .doc(date)
        .set(data);
    }
    else {
      await _firestore
          .collection('users')
          .doc(_currentUser.uid)
          .collection('slots')
          .doc(date)
          .update(data);
    }
  }

  /// make appointment > user side
      Future<void> makeAppointment({
    required String counselorUid,
    required int timestamp,
    required String selectedTimeString,
    required String counselorName,
  }) async {

    var currentuser = await UserRepository().getCurrentUserDetails();
    String date =
        DateTime.fromMillisecondsSinceEpoch(timestamp).toString().split(" ")[0];

    String bookingUid = uuid.v1();

    String channelName = uuid.v4().split('-')[0];

    Uri url = Uri.parse(
        "https://videocall-token-generator.herokuapp.com/access_token?channelName=$channelName&expireTime=${3600 * 24 * 8}");

    http.Response data = await http.get(url);

    String token = json.decode(data.body)['token'];

    String strTimeSlot = (int.parse(selectedTimeString.split(' ')[0]) +
        (selectedTimeString.split(' ')[1] == 'pm' ? 12 : 0))
        .toString();
    if (strTimeSlot.length == 1) {
      strTimeSlot = '0' + strTimeSlot;
    }

    await _firestore
        .collection("users")
        .doc(_currentUser.uid)
        .collection("bookings")
        .doc(bookingUid)
        .set({
      "counselorUid": counselorUid,
      "timestamp": timestamp,
      "bookingUid": bookingUid,
      "channel": channelName,
      "token": token,
      "counselorName": counselorName,
    });

    print('*****' * 5 + "\n" + date);



    // update counselor data with token and booking uid
    Map<String, dynamic> updatedData = {
      "bookingUid": bookingUid,
      "bookedTo": _currentUser.uid,
      "bookedToUsername": currentuser['name'],
      "channelName": channelName,
      "token": token,
      "time": selectedTimeString,
      "timestamp": DateTime.parse(date + 'T' + strTimeSlot + ':' + '00' + ':' + '00').millisecondsSinceEpoch,
    };
    var docRef = _firestore
        .collection("users")
        .doc(counselorUid)
        .collection("slots")
        .doc(date);

    docRef.get().then((value) {
      List<dynamic> slots = value.data()!['slot'];

      for (int i = 0; i < slots.length; i++) {
        if (slots[i]['time'] == selectedTimeString) {
          slots[i] = updatedData;
        }
      }

      docRef.update({"slot": slots, "timestamp": DateTime.parse(date).millisecondsSinceEpoch});
    });
  }
}

//  users (C) > userId (D) > slots (C) > date (D) > {time: 10am, bookedTo: userId, timestamp: milliseconds since epoch of booking time}
