import 'package:flutter/material.dart';

class ListViewHome extends StatelessWidget {
  const ListViewHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Card(
            margin: EdgeInsets.all(15),
            child: Container(
              color: Colors.yellow[100 * (index % 9 + 1)],
              height: 80,
              alignment: Alignment.center,
              child: Text(
                "Item $index",
                style: TextStyle(fontSize: 30),
              ),
            ),
          );
        },
        childCount: 1000, // 1000 list items
      ),
    );
  }
}
