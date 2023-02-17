import 'package:flutter/material.dart';

class DividerCustom extends StatelessWidget {
  const DividerCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 2,
      height: 10,
      color: Colors.white70,
    );
  }
}
