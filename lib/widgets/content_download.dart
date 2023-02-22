import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ContentDownloadWidget extends StatelessWidget {
  const ContentDownloadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 200,
          child: CircularPercentIndicator(
            radius: 70.0,
            lineWidth: 13.0,
            animation: true,
            percent: 0.2,
            center: const Text(
              "1/2",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            footer: const Text(
              "Image Fetching",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
            ),
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: Colors.purple,
          ),
        ),
      ],
    );
  }
}
