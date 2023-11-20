import 'package:flutter/material.dart';
import 'package:let_me_cook/app.dart';
import 'package:let_me_cook/screens/login/login_screen.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Recipe App',
        theme: ThemeData(
          appBarTheme: AppBarTheme(color: Colors.white, elevation: 3),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: Colors.white,
        ),
        initialRoute: '/login', // Set the initial route
        routes: {
          '/login': (context) => LoginScreen(),
          '/main': (context) => App(),
        },
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var name = "";
  var password = "";

  void changeName(String newName) {
      name = newName;
      notifyListeners();
  }
}