import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TitleStepperCustom extends StatelessWidget {
  String title;
  bool isInprogress;
  bool isDone;
  TitleStepperCustom(
      {super.key,
      required this.title,
      this.isInprogress = false,
      this.isDone = false});
  final textStyleTitle = const TextStyle(
      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: textStyleTitle,
        ),
        if (isDone)
          const SizedBox(
            width: 20,
          ),
        if (isDone)
          const Icon(
            Icons.check_circle_outline_outlined,
            color: Colors.white,
          ),
        if (isInprogress)
          const SizedBox(
            width: 100,
          ),
      ],
    );
  }
}
