import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum state {
  initial,
  loading,
  done,
}

// for doctor
class SlotRepository extends ChangeNotifier {
  state _state = state.initial;
  state get appState => _state;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User _currentUser = FirebaseAuth.instance.currentUser!;

  Future<List<dynamic>> getSlots(String date) async {
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
    var data = {
      'slot': [],
    };
    for (String slot in timeSlots) {
      data['slot']!.add({'time': slot, 'bookedTo': null});
    }
    await _firestore
        .collection('users')
        .doc(_currentUser.uid)
        .collection('slots')
        .doc(date)
        .set(data);
  }
}




//  users (C) > userId (D) > slots (C) > date (D) > {time: 10am, bookedTo: userId}