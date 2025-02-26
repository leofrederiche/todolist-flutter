import 'package:flutter/material.dart';
import 'package:todolist/models/task-model.dart';
import 'package:todolist/services/api.dart';

class CardTask extends StatefulWidget {
  final int index;
  final TaskModel task;

  final Function(TaskModel) onChange;

  CardTask({
    super.key,
    required this.index,
    required this.task,
    required this.onChange,
  });

  @override
  State<CardTask> createState() => _CardTaskState();
}

class _CardTaskState extends State<CardTask> {
  final apiService = APIService();

  late TaskModel task = widget.task;

  _switchTaskStatus() {
    setState(() {
      task.completed = !task.completed;
    });

    widget.onChange(task);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueGrey, style: BorderStyle.solid),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        spacing: 16,
        children: [
          Icon(
            task.completed ? Icons.task_alt_outlined : Icons.pending_outlined,
            color: task.completed ? Colors.lightGreen : Colors.orangeAccent,
          ),
          Expanded(flex: 2, child: Text(task.description)),
          Expanded(child: Container()),
          ElevatedButton(
            onPressed: _switchTaskStatus,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  task.completed ? Colors.redAccent : Colors.lightGreen,
              overlayColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              widget.task.completed ? 'Uncheck' : 'Complete',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
