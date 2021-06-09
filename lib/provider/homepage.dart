import 'package:awesomeapp/widgets/home_gridview.dart';
import 'package:awesomeapp/widgets/home_listview.dart';
import 'package:flutter/material.dart';

class HomepageProvider with ChangeNotifier {
  // 0 untuk tampilan GridView, 1 untuk tampilan ListView
  int _currentIndex = 0;
  get currentIndex => _currentIndex;
  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
