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

  _updateTaskList(TaskModel taskUpdated) async {
    try {
      taskList.map((task) => task.id == taskUpdated.id ? taskUpdated : task).toList();
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
          children: [
            Expanded(
              flex: 0,
              child: Text(
                'Todo-List Flutter APP',
                style: AppTextStyle().textTitleStyle,
              ),
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
                      task: task,
                      onChange: _updateTaskList,
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
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
