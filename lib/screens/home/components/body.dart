import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);
    var defaultSize = deviceData.orientation == Orientation.landscape
        ? deviceData.size.height * 0.024
        : deviceData.size.width * 0.024;

    return SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding:
              EdgeInsets.symmetric(horizontal: defaultSize * 2),
            ),
          ),
        ],
      ),
    );
  }
}