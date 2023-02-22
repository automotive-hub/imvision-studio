import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/color_constants.dart';

class ShimmerDefaultCustom extends StatelessWidget {
  const ShimmerDefaultCustom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(milliseconds: 2000),
      baseColor: ColorsCustom.primary.shade50,
      highlightColor: Colors.deepPurple.shade100.withOpacity(0.3),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 200,
          width: 200,
          color: Colors.white,
        ),
      ),
    );
  }
}
