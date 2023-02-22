import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
              onPressed: () {
                print('Dash board');
              },
              child: Text(
                widget.title,
                style: styleTitle.copyWith(color: Colors.grey),
              )),
          Container(
            width: 20,
            height: 20,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
