class TaskModel {
  int id;
  String description;
  bool completed;

  TaskModel({
    required this.id,
    required this.description,
    this.completed = false,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      description: json['description'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'description': description.toString(), 'completed': completed};
  }
}
