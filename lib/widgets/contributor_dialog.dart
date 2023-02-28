import 'package:flutter/material.dart';

import '../constants/global_constants.dart';

class ContributorDialog extends StatefulWidget {
  ContributorDialog({Key? key}) : super(key: key);

  @override
  State<ContributorDialog> createState() => _ContributorDialogState();
}

class _ContributorDialogState extends State<ContributorDialog> {
  final TextStyle title = const TextStyle(
      fontSize: 100,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      overflow: TextOverflow.ellipsis,
      decoration: TextDecoration.none);
  final TextStyle subTitle = const TextStyle(
      fontSize: 50,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      overflow: TextOverflow.ellipsis,
      decoration: TextDecoration.none);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.69,
      height: MediaQuery.of(context).size.height * 0.39,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
            Colors.deepPurple,
            Colors.black,
          ])),
      child: Column(
        children: [
          Text('HALL OF FAME', style: title),
          const SizedBox(
            height: 100,
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: ContactInformation.teamsEmail.length,
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: Text(
                    ContactInformation.teamsEmail[index],
                    style: subTitle,
                  ),
                );
              }),
        ],
      ),
    );
  }
}
