import 'dart:io';
import 'package:b_tech_project/utilites/doctor_parameter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum AppState {
  initial,
  authenticated,
  authenticating,
  unauthenticated,
  unauthorised,
}

class UserRepository with ChangeNotifier {
  final FirebaseAuth _auth;
  // ignore: prefer_typing_uninitialized_variables
  var _user;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // final GoogleSignIn _googleSignIn;
  AppState _appState = AppState.initial;

  AppState get appState => _appState;
  bool isUserCounsellor = false;
  bool get isCounsellor => isUserCounsellor;
  get user => _user;

  UserRepository() : _auth = FirebaseAuth.instance {
    print('*' * 100);
    print('user repository initialised');
    print('*' * 100);
    // _appState = AppState.unauthenticated;

    _auth.authStateChanges().listen((firebaseUser) async {
      if (firebaseUser == null) {
        _appState = AppState.unauthenticated;
        notifyListeners();
      } else {
        print('logged In');
        _user = firebaseUser;

        _appState = AppState.authenticated;

        _firestore
            .collection('users')
            .doc(firebaseUser.uid)
            .get()
            .then((value) {
          isUserCounsellor = value.data()?['isCounselor'] ?? false;
          notifyListeners();
          print('*' * 30);
          print(isUserCounsellor);
        });
        notifyListeners();

        // print('*' * 200);
        // print(data);
        // print('*' * 200);
      }
    });
  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  // Function to get the user and userId
  // Future<String> getUser() async {
  //   return (await _firebaseAuth.currentUser).uid;
  // }

  Future<bool> isFirstTime(String userId) async {
    bool exist = false;
    await _firestore.collection('users').doc(userId).get().then((var user) {
      exist = user.exists;
    }).catchError((error) {
      exist = true;
    });

    return exist;
  }

  Future<dynamic> login(String email, String password) async {
    // try {
    // _appState = AppState.authenticating; //set current state to loading state.
    // notifyListeners();

    var user = await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((error) {
      print(error.code);
      _appState = AppState.unauthenticated;
      notifyListeners();

      throw error;
    });

    _appState = AppState.authenticated;
    notifyListeners();
    return user;
    // }
    //  catch (e) {
    //   print(e.toString() + '*******');
    //   _appState = AppState.unauthenticated;
    //   notifyListeners();
    //   throw e;
    // }
  }

  Future<dynamic> signup({
    required String email,
    required String password,
    required String phoneNumber,
    required String name,
    required File image,
  }) async {
    _appState = AppState.authenticating;
    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    _appState = AppState.unauthorised;

    // upload photo to firebase storage

    Reference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('profilePics')
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask uploadTask = firebaseStorageRef.putFile(image);

    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String imageUrl = await taskSnapshot.ref.getDownloadURL();

    await _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'name': name,
      'email': email,
      //'address': address,
      //'state': state,
      //'country': country,
      'photoUrl': imageUrl,
      'phoneNumber': phoneNumber,
      'uuid': FirebaseAuth.instance.currentUser!.uid,
      'joinDate': Timestamp.now(),
      'isRequestAccepted': 'pending', // pending, accepted, rejected
      'isCounselor': false,
    }).then((value) {
      _appState = AppState.authenticated;
      notifyListeners();
    }).catchError((error) {
      _appState = AppState.unauthenticated;
      notifyListeners();

      throw error;
    });
  }

  Future logout() async {
    await _auth.signOut();

    _appState = AppState.unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<dynamic> getCurrentUserDetails() async {
    var _user = _firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .get();
    return _user;
  }

  Future<void> updateUserProfile({
    required String name,
    required String phoneNumber,
    required String address,
    // required String state,
    // required String country,
    required File image,
  }) async {
    Reference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('profilePics')
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask uploadTask = firebaseStorageRef.putFile(image);

    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String imageUrl = await taskSnapshot.ref.getDownloadURL();

    await _firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .update({
      'name': name,
      'address': address,
      // 'state': state,
      // 'country': country,
      'phoneNumber': phoneNumber,
      'photoUrl': imageUrl,
    });
  }

  Future<void> addCounselorDetails({
    required String location,
    required String speciality,
    required String yearOfExperience,
    required String counselorDescription,
  }) async {
    await _firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .update({
      'location': location,
      'speciality': speciality,
      'yearOfExperience': yearOfExperience,
      'counselorDescription': counselorDescription,
    });
  }

  Future<void> uploadCounselorCertificate({
    required File image,
  }) async {
    Reference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('users')
        .child('certificates')
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask uploadTask = firebaseStorageRef.putFile(image);

    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String certificateUrl = await taskSnapshot.ref.getDownloadURL();
    await _firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .collection('attatchments')
        .doc('certificates')
        .set({
      'certificateUrl': certificateUrl,
    }).catchError((error) {
      throw error;
    });
  }

  Future<List<Doctor>> getCounselorUsers() async {
    var getConselor = await _firestore
        .collection("users")
        .where("isCounselor", isEqualTo: true)
        .get();
    var docs = getConselor.docs;

    List<Doctor> doctors = [];

    for (var doc in docs) {
      var data = doc.data();
      Doctor value = Doctor(
          name: data['name'],
          image: Image(image: NetworkImage((data['photoUrl']))),
          // type: 'none',
          rating: 5,
        counselorDescription: data['counselorDescription'],

        location: data['address'],

        speciality: data['speciality'],
        uid: doc.id,
        yearOfExperience: data['yearOfExperience'],

      );
      doctors.add(value);
    }
    debugPrint(doctors.toString());
    return doctors;
  }

  Future<QuerySnapshot> getUsers({String? name}) {
    // final _auth = FirebaseAuth.instance.currentUser;
    final FirebaseFirestore usersget = FirebaseFirestore.instance;

    /// search user
    Query _query = usersget
        .collection('users')
        .where("isAdmin", isEqualTo: true)
        .where("name", isNotEqualTo: _auth.currentUser);

    if (name != null) {
      _query = _query
          .where("name", isGreaterThanOrEqualTo: name)
          .where("name", isLessThanOrEqualTo: name + "z");
    }
    return _query.get();
  }
}
