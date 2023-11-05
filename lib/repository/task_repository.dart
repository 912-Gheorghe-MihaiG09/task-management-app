import 'package:shortpoint_test/domain/task.dart';

abstract class TaskRepository {

  Future<List<Task>> getTasks();

  Future<Task?> updateTask(Task task);

  Future<Task> addTask(String name);
}