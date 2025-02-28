import 'package:flutter/material.dart';
import 'package:todolist/models/task-model.dart';
import 'package:todolist/services/api.dart';

class CardTask extends StatefulWidget {
  final int index;
  final TaskModel task;

  final Function(TaskModel) onChange;
  final Function(TaskModel) onDelete;

  CardTask({
    super.key,
    required this.index,
    required this.task,
    required this.onChange,
    required this.onDelete,
  });

  @override
  State<CardTask> createState() => _CardTaskState();
}

class _CardTaskState extends State<CardTask> {
  final apiService = APIService();

  late TaskModel task = widget.task;

  onChangeTaskCompleted(bool? newValue) {
    setState(() {
      task.completed = newValue ?? false;
    });

    widget.onChange(task);
  }

  onDeleteTask() {
    widget.onDelete(task);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(
          color: Colors.blueGrey,
          style: BorderStyle.solid
        )),
      ),
      child: Row(
        spacing: 16,
        children: [
          Transform.scale(
            scale: 1.4,
            child: Checkbox(
              visualDensity: VisualDensity.compact,
              activeColor: Colors.blueGrey.shade400,
              shape: CircleBorder(),
              value: widget.task.completed,
              onChanged: onChangeTaskCompleted,
            ),
          ),
          
          Expanded(
            flex: 1, 
            child: Text(
              task.description, 
              style: TextStyle(
                color: Colors.blueGrey.shade700
              )
            )
          ),
          IconButton(
            icon: Icon(Icons.delete_outline_rounded),
            color: Colors.redAccent,
            onPressed: onDeleteTask,
          )
        ],
      ),
    );
  }
}
