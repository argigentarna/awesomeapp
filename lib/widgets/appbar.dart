import 'package:awesomeapp/helper/const.dart';
import 'package:awesomeapp/provider/homepage.dart';
import 'package:awesomeapp/styles/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget appBarHomePage(context, title) {
  return AppBar(
    elevation: 0,
    title: Text(
      title,
      style: appBarStyle(),
    ),
  );
}

SliverAppBar sliverAppBarHome(context, title) {
  var prov = Provider.of<HomepageProvider>(context);
  return SliverAppBar(
      title: Text(
        title,
        style: appBarStyle(),
      ),
      expandedHeight: 257,
      flexibleSpace: FlexibleSpaceBar(
        background: new Image.asset(
          assCoverHonme,
          fit: BoxFit.cover,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            // Rubah homefeeds menjadi tampilan GridView
            prov.currentIndex = 0;
          },
          child: Icon(
            Icons.grid_view,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: GestureDetector(
            onTap: () {
              // Rubah homefeeds menjadi tampilan ListView
              prov.currentIndex = 1;
            },
            child: Icon(
              Icons.view_list,
            ),
          ),
        ),
      ]);
}
