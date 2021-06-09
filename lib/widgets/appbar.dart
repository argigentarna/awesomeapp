import 'package:awesomeapp/styles/appbar.dart';
import 'package:flutter/material.dart';

Widget appBarHomePage(context, title) {
  return AppBar(
    elevation: 0,
    title: Text(
      title,
      style: appBarStyle(),
    ),
    actions: [
      Icon(
        Icons.grid_view,
      ),
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Icon(
          Icons.list_alt_rounded,
        ),
      ),
    ],
  );
}
