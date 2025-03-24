import 'package:flutter/material.dart';
import 'package:todolist/components/content_loading.dart';
import 'package:todolist/models/task_model.dart';
import 'package:todolist/services/api.dart';

class CardTask extends StatefulWidget {
  final TaskModel task;

  final Function(TaskModel) onChange;
  final Future<void> Function(TaskModel) onDelete;

  CardTask({
    super.key,
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
  late bool isLoadingDelete = task.id % 2 == 0;

  _onChangeTaskCompleted(bool? newValue) {
    setState(() {
      task.completed = newValue ?? false;
    });

    widget.onChange(task);
  }

  _onDeleteTask() async {
    setState(() {
      isLoadingDelete = true;
    });

    await widget.onDelete(task);

    setState(() {
      isLoadingDelete = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.blueGrey, style: BorderStyle.solid),
        ),
      ),
      child: Row(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.scale(
            scale: 1.4,
            child: Checkbox(
              visualDensity: VisualDensity.compact,
              activeColor: Colors.blueGrey.shade400,
              shape: CircleBorder(),
              value: widget.task.completed,
              onChanged: _onChangeTaskCompleted,
            ),
          ),

          Expanded(
            flex: 2,
            child: Text(
              task.description,
              style: TextStyle(color: Colors.blueGrey.shade700),
            ),
          ),
          Container(
            width: 40,
            child: (isLoadingDelete)
              ? ContentLoading(isSmall: true, color: Colors.redAccent)
              : IconButton(
                  alignment: Alignment.centerRight,
                  icon: Icon(Icons.delete_outline_rounded),
                  color: Colors.redAccent,
                  onPressed: _onDeleteTask,
                ),
          ),
        ],
      ),
    );
  }
}
