import 'package:awesomeapp/helper/const.dart';
import 'package:awesomeapp/helper/helper.dart';
import 'package:awesomeapp/models/homefeeds.dart';
import 'package:flutter/material.dart';

class HomepageProvider with ChangeNotifier {
  List<Photos> _listHomeFeeds = [];
  // 0 untuk tampilan GridView, 1 untuk tampilan ListView
  int _currentIndex = 0;
  int _pageHomeFeeds = 1;

  int get countListHomeFeeds {
    return _listHomeFeeds != null ? _listHomeFeeds.length : 0;
  }

  get listHomeFeeds => _listHomeFeeds;
  get pageHomeFeeds => _pageHomeFeeds;

  get currentIndex => _currentIndex;
  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  ScrollController _controllerScroll;
  get controllerScroll => _controllerScroll;
  set controllerScroll(val) {
    _controllerScroll = val;
    notifyListeners();
  }

  Future<void> clearFeeds() async {
    _pageHomeFeeds = 1;
    _listHomeFeeds = [];
    notifyListeners();
  }

  Future<bool> isLoadMore() async {
    Future<bool> status;
    if (_controllerScroll.position.pixels ==
        _controllerScroll.position.maxScrollExtent) {
      status = Future<bool>.value(true);
    } else {
      status = Future<bool>.value(false);
    }
    return await status;
  }

  Future<void> fetchHomeFeeds() async {
    var response;
    await doGet(
      API_URL,
      apiCurated(_pageHomeFeeds, 30),
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
              print(res['data'].toString());
              for (var i = 0; i < res['data']['photos'].length; i++) {
                var home = Photos.fromJson(res['data']['photos'][i]);
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
