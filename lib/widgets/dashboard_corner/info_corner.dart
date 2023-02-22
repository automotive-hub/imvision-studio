import 'package:flutter/material.dart';

import '../../constants/global_constants.dart';

class InfoCorner extends StatelessWidget {
  InfoCorner({
    Key? key,
  }) : super(key: key);

  TextStyle styleNameUser = const TextStyle(
      fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20);
  TextStyle styleEmailUser = const TextStyle(color: Colors.grey, fontSize: 12);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50,
          width: 50,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset('assets/images/avatar.jpeg')),
        ),
        const SizedBox(height: 10),
        Container(
          color: Colors.deepPurple,
          child: Text(
            ContactInformation.productName,
            style: styleNameUser.copyWith(fontWeight: FontWeight.w900),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
        Text(
          ContactInformation.organizationHub,
          style: styleEmailUser,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
