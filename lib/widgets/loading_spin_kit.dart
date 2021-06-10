import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingSpinRipple extends StatelessWidget {
  const LoadingSpinRipple({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitRipple(
        size: 50.0,
        itemBuilder: (_, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.amber,
            ),
          );
        },
      ),
    );
  }
}
