import 'package:awesomeapp/provider/homepage.dart';
import 'package:awesomeapp/widgets/appbar.dart';
import 'package:awesomeapp/widgets/home_gridview.dart';
import 'package:awesomeapp/widgets/home_listview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isInit = true;

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_isInit) {
      await Provider.of<HomepageProvider>(context, listen: false)
          .fetchHomeFeeds();
      setState(() {
        _isInit = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var _currentHome = [
      GridViewHome(),
      ListViewHome(),
    ];

    return Scaffold(
      body: Consumer<HomepageProvider>(
        builder: (_, prov, ch) => CustomScrollView(
          slivers: <Widget>[
            sliverAppBarHome(context, "Awesome App"),
            _currentHome[prov.currentIndex],
          ],
        ),
      ),
    );
  }
}
