import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<QuerySnapshot> getUsers({String? name}) {
  final _auth = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore usersget = FirebaseFirestore.instance;

  print('900' * 100);
  Query _query = usersget
      .collection('users')
      .where("isAdmin", isEqualTo: true)
      .where("name", isNotEqualTo: _auth!.displayName);
  if (name != null) {
    _query = _query
        .where("name", isGreaterThanOrEqualTo: name)
        .where("name", isLessThanOrEqualTo: name + "z");
  }
  return _query.get();
}
