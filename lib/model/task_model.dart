class TaskModel {
  int? id;
  String? title;
  String? description;
  int completed; // Moved 'completed' outside of the constructor

  TaskModel(
      {this.id,
      this.title,
      this.description,
      this.completed = 0}); // Corrected the constructor

  TaskModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        completed = json['Completed'] ?? 0 {
    print("Incoming JSON data: $json");
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['completed'] = completed; // Include 'completed' in JSON
    return data;
  }
}
