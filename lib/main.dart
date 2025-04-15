import 'dart:html';

import 'package:flutter/material.dart';
import 'package:sturlite/petty_cash_entry/petty_cash_entry.dart';

import 'home_screen.dart';
import 'login_screen.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sturlite',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: window.sessionStorage["login"] == "success" ? const HomeScreen(plantValue: '', userName: '',) :const LoginScreen(),
    );
  }
}
