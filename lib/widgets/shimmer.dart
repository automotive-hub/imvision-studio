import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/color_constants.dart';

class ShimmerCustom extends StatelessWidget {
  const ShimmerCustom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Shimmer.fromColors(
        period: const Duration(milliseconds: 2000),
        baseColor: ColorsCustom.primary.shade50,
        highlightColor: ColorsCustom.primary.shade100.withOpacity(0.3),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 100,
              width: 100,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 100,
              width: 100,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 100,
              width: 100,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 100,
              width: 100,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 100,
              width: 100,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 100,
              width: 100,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 100,
              width: 100,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 100,
              width: 100,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 100,
              width: 100,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 100,
              width: 100,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 100,
              width: 100,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}


