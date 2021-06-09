import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageFeedsShimmer extends StatelessWidget {
  const ImageFeedsShimmer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.amber[200],
      highlightColor: Colors.white10,
      child: Container(
        color: Colors.amber[200],
        height: 212,
        alignment: Alignment.center,
        child: SizedBox(
          width: 0,
        ),
      ),
    );
  }
}
