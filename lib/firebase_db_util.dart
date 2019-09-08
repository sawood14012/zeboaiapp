import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:zebo/productsdata.dart';

class FirebaseDatabaseUtil {
  //DatabaseReference _counterRef;
  DatabaseReference _userRef;
  DatabaseReference _userRef1;
  //StreamSubscription<Event> _counterSubscription;
  //StreamSubscription<Event> _messagesSubscription;
  FirebaseDatabase database = new FirebaseDatabase();
  //int _counter;
  DatabaseError error;

  static final FirebaseDatabaseUtil _instance =
      new FirebaseDatabaseUtil.internal();

  FirebaseDatabaseUtil.internal();

  factory FirebaseDatabaseUtil() {
    return _instance;
  }

  void initState() {
    // Demonstrates configuring to the database using a file
    // _counterRef = FirebaseDatabase.instance.reference().child('counter');
    // Demonstrates configuring the database directly

    _userRef = database.reference().child('medicalhistory');
    _userRef1 = database.reference().child("products");

    // database.reference().child('counter').once().then((DataSnapshot snapshot) {
    // print('Connected to second database and read ${snapshot.value}');
    //});
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    //_counterRef.keepSynced(true);
    _userRef.keepSynced(true);
  }

  DatabaseError getError() {
    return error;
  }

  DatabaseReference getUser() {
    return _userRef1;
  }

  DatabaseReference getUser1(uid) {
    var dat = {"uid": uid};

    return _userRef;
  }

  DatabaseReference getsearch(String s) {
    DatabaseReference _Ref;
    _Ref = database.reference().child('blog').startAt(s).endAt(s);
    return _Ref;
  }
}
