import 'package:demo/models/profileItems.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';



class database extends ChangeNotifier {

  List<profileItem> _user = [];
  List<profileItem> get user => _user;


  // List<dynamic> get kullanicibilgileriList => _kullanicibilgileriList;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  database() {
    getUserInformations();
  }


  void getUserInformations () {
    _isLoading = true;
    notifyListeners();

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {

    }
    else {
      String _currentUserEmail;
        _currentUserEmail = user.email.toString();
        readUserFromDatabase(_currentUserEmail);
    }
  }


  void readUserFromDatabase(String currentUserEmail) async {

    DatabaseReference dbrefo = FirebaseDatabase.instance.ref("users");
    final event = await dbrefo
        .orderByChild("email")
        .equalTo(currentUserEmail)
        .once(DatabaseEventType.value);

    final List<profileItem> userList = [];
    final Map<dynamic, dynamic>? usersMap = event.snapshot.value as Map<dynamic, dynamic>?;

    if(event.snapshot.exists) {
      usersMap!.forEach((key, value) {
        final user = profileItem.fromMap(Map<String, dynamic>.from(value), key);
        userList.add(user);
      });
    }
    else {
      _user = [];
    }

    _isLoading = false;
    _user = userList;
    notifyListeners();
  }
}