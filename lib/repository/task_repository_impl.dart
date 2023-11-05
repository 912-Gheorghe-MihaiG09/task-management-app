import 'package:shortpoint_test/domain/task.dart';
import 'package:shortpoint_test/repository/task_repository.dart';

class TaskRepositoryImplementation extends TaskRepository {
  late List<Task> _tasks;
  int latestId = 4;

  TaskRepositoryImplementation() {
    _tasks = Task.getPopulation();
  }

  @override
  Future<Task> addTask(String name) async {
    Task newTask = Task(id: latestId.toString(), name: name);

    _tasks.add(Task(id: latestId.toString(), name: name));

    latestId++;

    await Future.delayed(const Duration(milliseconds: 500));

    return newTask;
  }

  @override
  Future<List<Task>> getTasks() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return _tasks;
  }

  @override
  Future<Task?> updateTask(Task task) async {
    Task? updatedTask;
    for (int i = 0; i < _tasks.length; i++) {
      if (_tasks[i].id == task.id) {
        _tasks[i].name = task.name;
        _tasks[i].isCompleted = task.isCompleted;
        updatedTask = _tasks[i];
        break;
      }
    }
    await Future.delayed(const Duration(milliseconds: 500));

    return updatedTask;
  }
}
