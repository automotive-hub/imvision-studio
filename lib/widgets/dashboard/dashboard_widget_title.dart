import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/status_model.dart';
import '../../services/firestore_database.dart';

class DashBoardTitleWidget extends StatefulWidget {
  final String title;
  final AppMenu menuType;

  const DashBoardTitleWidget({
    Key? key,
    required this.title,
    required this.menuType,
  }) : super(key: key);

  @override
  State<DashBoardTitleWidget> createState() => _DashBoardTitleWidgetState();
}

class _DashBoardTitleWidgetState extends State<DashBoardTitleWidget> {
  var isLoading = false;
  var isIdle = true;
  var isDone = false;
  bool isStreamDone = false;
  Stream<Status>? streamStatus;
  @override
  Widget build(BuildContext context) {
    streamStatus =
        context.read<FireStoreDatabase>().generationStatusStream;
    final Color colorsForceBackgroundTitle =
        Colors.deepPurpleAccent.withOpacity(0.7);
    return Container(
      height: 210,
      width: 330,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.deepPurple.shade400,
          )),
      child: Column(
        children: [
          Container(
            width: 260,
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: colorsForceBackgroundTitle.withOpacity(0.5),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(widget.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white)),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox.square(
              dimension: 100,
              child: StreamBuilder<Status>(
                  stream: streamStatus,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      handleMenuState(snapshot.data!);
                    }
                    return isDone
                        ? const Icon(
                            Icons.done_sharp,
                            size: 120,
                            color: Colors.deepPurple,
                          )
                        : isLoading
                            ? const CircularProgressIndicator(
                                strokeWidth: 7,
                                color: Colors.deepPurple,
                              )
                            : const SizedBox();
                  })),
        ],
      ),
    );
  }

  handleMenuState(Status status) {
    final AppStatus menuStatus = AppStatus.values
        .byName(status.toJson()[widget.menuType.name] as String);
    switch (menuStatus) {
      case AppStatus.idle:
        isIdle = true;
        isLoading = false;
        isDone = false;
        break;
      case AppStatus.processing:
        isIdle = false;
        isLoading = true;
        isDone = false;
        break;
      case AppStatus.done:
        isIdle = false;
        isDone = true;
        isLoading = false;
        break;
      default:
    }
  }
}
