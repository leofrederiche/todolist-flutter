import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/components/card_task.dart';
import 'package:todolist/components/input_new_task.dart';
import 'package:todolist/views/home/home_controller.dart';
import 'package:todolist/styles/text_style.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(context);

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(padding: EdgeInsets.all(16)),
            Text(
              'Todo-List',
              style: AppTextStyle().textTitleStyle,
              textAlign: TextAlign.left,
            ),
            ElevatedButton(onPressed: controller.fetchTaskList, child: Text("Refresh")),
            InputNewTask(onAdd: controller.insertTask),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: controller.taskList.length,
                itemBuilder: (context, index) {
                  final task = controller.taskList[index];
                  return CardTask(
                    key: ValueKey(task.id),
                    index: index,
                    task: task,
                    onChange: controller.updateTask,
                    onDelete: controller.deleteTask,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
