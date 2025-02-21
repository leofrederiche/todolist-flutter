import 'package:flutter/material.dart';
import 'package:todolist/screens/tasks/task-new.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => TaskNewPage())
            );
          },
          child: Text('Add Task'),
        ),
      )
    );
  }
}