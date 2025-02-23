class TaskModel {
  String description;
  bool completed;

  TaskModel({
    required this.description,
    this.completed = false,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      description: json['description'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'completed': completed,
    };
  }
}