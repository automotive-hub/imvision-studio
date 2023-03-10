import 'package:flutter/material.dart';

import '../constants/global_constants.dart';

class TitleWidget extends StatelessWidget {
  String title;
  String subTitle;
  bool isShowVin;
  TitleWidget(
      {super.key,
      required this.title,
      this.subTitle = '',
      this.isShowVin = true});
  final titleTextStyle = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 35);
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
        if (isShowVin)
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
