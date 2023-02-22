import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:imvision_studio/services/firestore_database.dart';
import 'package:provider/provider.dart';

import '../../constants/global_constants.dart';
import '../../models/status_model.dart';

class MenuButton extends StatefulWidget {
  final AppMenu menuType;
  final String title;
  const MenuButton({super.key, required this.menuType, required this.title});

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  TextStyle styleTitle = const TextStyle(
      fontWeight: FontWeight.bold, color: Colors.white, fontSize: 17);

  var isLoading = false;
  var isIdle = true;
  var isDone = false;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Status>(
        stream: context.read<FireStoreDatabase>().generationStatusStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            handleMenuState(snapshot.data!);
          }
          return Container(
            width: double.infinity,
            color: isIdle ? null : Colors.white38,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      print('Dash board');
                    },
                    child: Text(
                      widget.title,
                      style: isIdle
                          ? styleTitle.copyWith(color: Colors.grey)
                          : styleTitle.copyWith(color: Colors.white),
                    )),
                iconBuilder()
              ],
            ),
          );
        });
  }

  Widget iconBuilder() {
    // isLoading
    if (isLoading && isDone == false) {
      return Container(
        // color: Colors.amberAccent,
        width: 30,
        height: 30,
        padding: const EdgeInsets.all(8),
        child: const CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    }
    // isDone
    if (isDone) {
      return Container(
          color: Colors.green,
          width: 30,
          height: 30,
          // padding: const EdgeInsets.all(8),
          child: Center(child: Icon(Icons.done)));
    }
    return SizedBox.shrink();
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
