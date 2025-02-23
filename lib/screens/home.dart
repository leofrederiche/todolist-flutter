import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todolist/components/card-task.dart';
import 'package:todolist/models/task-model.dart';
import 'package:todolist/screens/tasks/task-new.dart';
import 'package:todolist/services/api.dart';
import 'package:todolist/styles/text-style.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  APIService apiService = APIService();
  List<TaskModel> taskList = [];

  @override
  void initState() {
    super.initState();

    _fetchTaskList();
    print("RUN initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('OnInit!!!!!');
  }

  _fetchTaskList() async {
    print("fetch list");
    final response = await apiService.get('/');
    final tasks = (response['tasks'] as List);

    setState((){
      taskList = tasks.map((task) => TaskModel.fromJson(task)).toList();
    });
  }

  _updateTaskList() async {
    print("!!! Update Task List");

    
    final response = await apiService.post('/',  taskList.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: [
            Expanded(
              flex: 0,
              child: Text('My Todo-List Flutter', style: AppTextStyle().textTitleStyle)
            ),
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: taskList.length,
                itemBuilder: (context, index) {
                  final task = taskList[index];

                  return Center(
                    child: CardTask(
                      index: index,
                      task: task
                    )
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => TaskNewPage(),
                    ))
                    .whenComplete(
                      () => setState(() {}),
                    );
                  },
                  child: Text('Add Task'),
                ),
              ),
            ),          
          ],
        ),
      )
    );
  }
}