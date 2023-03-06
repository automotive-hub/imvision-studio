import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';

class BoxContentDownloadWidget extends StatefulWidget {
  final String firstTitle;
  final num firstValue;
  final num secondValue;
  const BoxContentDownloadWidget(
      {Key? key,
      required this.firstTitle,
      required this.firstValue,
      required this.secondValue})
      : super(key: key);

  @override
  State<BoxContentDownloadWidget> createState() =>
      _BoxContentDownloadWidgetState();
}

class _BoxContentDownloadWidgetState extends State<BoxContentDownloadWidget> {
  final TextStyle titleTextStyle = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17);
  final double sizeNumberValue = 100;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 369,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.deepPurple.shade400,
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 10, left: 5),
                  color: Colors.deepPurple,
                  child: Text(
                    widget.firstTitle,
                    style: titleTextStyle,
                  ))
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedFlipCounter(
                value: widget.firstValue,
                textStyle: const TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              Text(
                " / ",
                style: TextStyle(fontSize: sizeNumberValue),
              ),
              Text(widget.secondValue.toString(),
                  style: TextStyle(fontSize: sizeNumberValue)),
            ],
          ),
        ],
      ),
    );
  }
}
