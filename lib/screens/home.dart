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
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  _fetchTaskList() async {
    final response = await apiService.get('/');
    final tasks = (response['tasks'] as List);

    setState(() {
      taskList = tasks.map((task) => TaskModel.fromJson(task)).toList();
    });
  }

  _updateTask(TaskModel taskUpdated) {
    setState(() {
      taskList = taskList.map((task) => task.id == taskUpdated.id ? taskUpdated : task).toList();
    });
    
    _postTaskList();
  }

  _deleteTask(TaskModel taskToDelete) {
    setState(() {
      taskList = taskList.where((task) => task.id != taskToDelete.id).toList();
    });
    _postTaskList();
  }

  _postTaskList() async {
    try {
      final Object taskResponse = {
        "tasks": taskList.map((task) => task.toJson()).toList()
      };

      await apiService.post('/', taskResponse);
    } catch (error) {
      print("Error on Update Tasks: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(padding: EdgeInsets.all(16)),
            Text('Todo-List',
              style: AppTextStyle().textTitleStyle,
              textAlign: TextAlign.left,
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: taskList.length,
                itemBuilder: (context, index) {
                  final task = taskList[index];
                  return CardTask(
                    index: index,
                    task: task,
                    onChange: _updateTask,
                    onDelete: _deleteTask,
                  );
                },
              ),
            ),
            Expanded(
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TaskNewPage()),
                    ).whenComplete(() => setState(() {}));
                  },
                  child: Text('Add Task'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
