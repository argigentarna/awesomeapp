import 'package:flutter/material.dart';

class GridViewHome extends StatefulWidget {
  const GridViewHome({Key key}) : super(key: key);

  @override
  _GridViewHomeState createState() => _GridViewHomeState();
}

class _GridViewHomeState extends State<GridViewHome> {
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 333.0,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 1.0,
        childAspectRatio: 0.8,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                margin: EdgeInsets.only(
                  left: 15,
                  right: 15,
                  bottom: 5,
                ),
                child: Container(
                  color: Colors.blue[100 * (index % 9 + 1)],
                  height: 212,
                  alignment: Alignment.center,
                  child: Text(
                    "Item $index",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8.0,
                    left: 15,
                    right: 9,
                  ),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectur adipiscing elit.",
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ],
          );
        },
        childCount: 50, // 1000 list items
      ),
    );
  }
}
