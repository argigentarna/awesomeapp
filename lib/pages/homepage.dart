import 'package:awesomeapp/helper/const.dart';
import 'package:awesomeapp/provider/homepage.dart';
import 'package:awesomeapp/widgets/appbar.dart';
import 'package:awesomeapp/widgets/home_gridview.dart';
import 'package:awesomeapp/widgets/home_listview.dart';
import 'package:awesomeapp/widgets/loading_spin_kit.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isInit = true;
  bool _isLoading = false;
  var _res;

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_isInit) {
      setState(() {
        _res = Provider.of<HomepageProvider>(context, listen: false)
            .fetchHomeFeeds();
      });

      setState(() {
        _isInit = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 100)).then((val) {
      Provider.of<HomepageProvider>(context, listen: false).controllerScroll =
          new ScrollController()
            ..addListener(
              _scrollListener,
            );
    });
  }

  Future<void> _refresh() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<HomepageProvider>(context, listen: false).clearFeeds();
    await Provider.of<HomepageProvider>(context, listen: false)
        .fetchHomeFeeds();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _scrollListener() async {
    // print("start scroll");
    if (await Provider.of<HomepageProvider>(context, listen: false)
        .isLoadMore()) {
      setState(() {
        _isLoading = true;
      });
      print(
          "-------------------------LOAD MORE DATA!!! -----------------------");
      await Provider.of<HomepageProvider>(context, listen: false)
          .fetchHomeFeeds();
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var _currentHome = [
      GridViewHome(),
      ListViewHome(),
    ];

    return ModalProgressHUD(
      opacity: 0.5,
      inAsyncCall: _isLoading,
      progressIndicator: LoadingSpinRipple(),
      child: Scaffold(
        floatingActionButton: new FloatingActionButton(
            child: new Icon(Icons.arrow_drop_up),
            mini: true,
            onPressed: () async {
              await Provider.of<HomepageProvider>(context, listen: false)
                  .controllerScroll
                  .animateTo(
                    0.0,
                    curve: Curves.easeOut,
                    duration: const Duration(milliseconds: 300),
                  );
            }),
        body: RefreshIndicator(
          backgroundColor: Colors.amber,
          color: Colors.white,
          onRefresh: _refresh,
          child: FutureBuilder(
            future: _res,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return LoadingSpinRipple();
              }
              if (snapshot.hasData) {
                if (snapshot.data.containsKey('rc')) {
                  if (snapshot.data['rc'] != 200) {
                    return Center(
                      child: Text(snapshot.data['message']),
                    );
                  }
                  if (snapshot.data['rc'].toString() == "200") {
                    if (snapshot.data['photos'].toString() == "[]") {
                      return Center(
                        child: Text(DATA_EMPTY),
                      );
                    }
                  }
                }
              }
              return Consumer<HomepageProvider>(
                builder: (_, prov, ch) => CustomScrollView(
                  controller:
                      Provider.of<HomepageProvider>(context, listen: false)
                          .controllerScroll,
                  slivers: <Widget>[
                    sliverAppBarHome(context, "Awesome App"),
                    _currentHome[prov.currentIndex],
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
