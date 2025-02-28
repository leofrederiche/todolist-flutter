import 'package:flutter/material.dart';

class InputNewTask extends StatefulWidget {
  final Function(String) onAdd;

  const InputNewTask({
    super.key, 
    required this.onAdd
  });

  @override
  State<InputNewTask> createState() => _InputNewTaskState();
}

class _InputNewTaskState extends State<InputNewTask> {

  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  onAdd() {
    widget.onAdd(descriptionController.text);
    descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey, 
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Task description',
                hintText: 'Wash dish'
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Insert task description";
                }

                return null;
              },
            )
          ),
          ElevatedButton(
            onPressed: (){
              if (formKey.currentState!.validate()) {
                onAdd();
              }
            }, 
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent.shade400,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))
            ),
            child: Text("ADD"),
          )
        ],
      ),
    );
  }
}