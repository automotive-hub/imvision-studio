import 'package:flutter/material.dart';

import '../constants/global_constants.dart';

class TitleWidget extends StatelessWidget {
  String title;
  String subTitle;
  TitleWidget({super.key, required this.title, this.subTitle = ''});
  final titleTextStyle = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20);
  final subTitleTextStyle = const TextStyle(
      color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 17);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.deepPurple,
          child: Text(
            title,
            style: titleTextStyle,
          ),
        ),
        Text(
          GlobalText.vinId.replaceAll('#', subTitle),
          style: subTitleTextStyle,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
