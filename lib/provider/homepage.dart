import 'package:awesomeapp/helper/const.dart';
import 'package:awesomeapp/helper/helper.dart';
import 'package:awesomeapp/models/homefeeds.dart';
import 'package:flutter/material.dart';

class HomepageProvider with ChangeNotifier {
  List<Photos> _listHomeFeeds = [];
  // 0 untuk tampilan GridView, 1 untuk tampilan ListView
  int _currentIndex = 0;
  int _pageHomeFeeds = 1;

  get currentIndex => _currentIndex;
  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  get listHomeFeeds => _listHomeFeeds;
  get pageHomeFeeds => _pageHomeFeeds;

  int get countListHomeFeeds {
    return _listHomeFeeds != null ? _listHomeFeeds.length : 0;
  }

  Future<void> fetchHomeFeeds() async {
    var response;
    await doGet(
      API_URL,
      apiCurated(1, 33),
      (res) {
        response = res;
        notifyListeners();
        print("CHECK RESPONSE");
        print(res);
        if (res['rc'] == 200) {
          final List<Photos> _listTemp = [];
          print("pit stop 1");
          print(res['data']);
          print("CHECK PHOTO!!!");
          print(res['data']['photos'].toString());
          if (res['data']['photos'].toString() != "[]") {
            print("pit stop 2");
            _pageHomeFeeds++;
            notifyListeners();
            if (countListHomeFeeds > 0) {
              print("pit stop 3");
              for (var i = 0; i < res['data']['photos'].length; i++) {
                var home = Photos.fromJson(res['photos'][i]);
                _listTemp.add(home);
                notifyListeners();
              }
              _listHomeFeeds = _listHomeFeeds + _listTemp;
              notifyListeners();
            } else {
              print("pit stop 4");
              for (var i = 0; i < res['data']['photos'].length; i++) {
                var home = Photos.fromJson(res['data']['photos'][i]);
                _listTemp.add(home);
                notifyListeners();
              }
              _listHomeFeeds = _listTemp;
              notifyListeners();
            }
          }
        }
      },
    );
    return response;
  }
}
