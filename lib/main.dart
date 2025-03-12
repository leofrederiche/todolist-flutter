import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/views/home/home_view.dart';
import 'package:todolist/views/home/home_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => HomeController(), 
        child: HomeView()
      )
    );
  }
}