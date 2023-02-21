import 'package:flutter/material.dart';
import 'package:imvision_studio/widgets/shimmer.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerDefaultCustom extends StatelessWidget {
  const ShimmerDefaultCustom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(milliseconds: 2000),
      baseColor: ColorsCustom.primary.shade50,
      highlightColor: ColorsCustom.primary.shade100.withOpacity(0.3),
      child: Container(
        height: 200,
        width: 200,
        color: Colors.white,
      ),
    );
  }
}
