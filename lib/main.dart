import 'package:flutter/material.dart';
import 'package:flutter_challenge/presentation/screens/home.dart';
import 'package:flutter_challenge/presentation/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'presentation/router/app_router.dart';
import 'presentation/screens/walkthrough.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(
    MyApp(
      hasOnboarded: prefs.getBool("hasOnboarded") ?? false,
      isLoggedIn: prefs.getBool("isLoggedIn") ?? false,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    this.hasOnboarded,
    this.isLoggedIn,
  }) : super(key: key);

  final bool? hasOnboarded;
  final bool? isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yoyo challenge',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: hasOnboarded!
          ? isLoggedIn!
              ? const HomeScreen()
              : const LoginScreen()
          : const WalkThroughScreen(),
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
