import 'package:evently/models/user.dart';
import 'package:flutter/foundation.dart';

class MyUserProvider extends ChangeNotifier {
  MyUsers? currentUser;

  void updateUser(MyUsers user) {
    currentUser = user;
    notifyListeners();
  }
}
