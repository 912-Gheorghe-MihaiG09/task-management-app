class Task {
  String id;
  bool isCompleted;
  String name;

  Task({required this.id, required this.name, this.isCompleted = false});

  static List<Task> getPopulation() {
    return [
      Task(id: "1", name: "Training at the Gym", isCompleted: true),
      Task(id: "2", name: "Play Paddle with friends", isCompleted: false),
      Task(id: "3", name: "Burger BBQ with family", isCompleted: false),
    ];
  }

  Task copyWith({String? id, bool? isCompleted, String? name}) {
    return Task(
        id: id ?? this.id,
        isCompleted: isCompleted ?? this.isCompleted,
        name: name ?? this.name);
  }
}
