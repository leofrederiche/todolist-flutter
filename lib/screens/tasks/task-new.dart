import 'package:flutter/material.dart';

class TaskNewPage extends StatefulWidget {
  final String? description;
  final bool? completed;

  const TaskNewPage({
    super.key, 
    this.description, 
    this.completed
  });

  @override
  State<TaskNewPage> createState() => _TaskNewPageState();
}

class _TaskNewPageState extends State<TaskNewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Task'),
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel")
            )
          ],
        ),
      )
    );
  }
}