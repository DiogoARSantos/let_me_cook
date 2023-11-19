import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var name = appState.name;

    return Center(
      child: Text("Bem vindo $name"),
    );
  }
}