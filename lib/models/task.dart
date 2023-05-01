class Task {
  final String name;
  final DateTime dueDate;
  final String label;
  bool isComplete;

  Task({
    required this.name,
    required this.dueDate,
    required this.label,
    this.isComplete = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      name: json['name'],
      dueDate: DateTime.parse(json['due_date']),
      label: json['label'],
      isComplete: json['is_complete'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'due_date': dueDate.toIso8601String(),
      'label': label,
      'is_complete': isComplete,
    };
  }

  Task copyWith({
    String? name,
    DateTime? dueDate,
    String? label,
    bool? isComplete,
  }) {
    return Task(
      name: name ?? this.name,
      dueDate: dueDate ?? this.dueDate,
      label: label ?? this.label,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}
