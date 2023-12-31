part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

class FetchTasks extends TaskEvent {
  const FetchTasks();
}

class UpdateTask extends TaskEvent {
  final Task task;

  const UpdateTask({required this.task});

  @override
  List<Object?> get props => [task];
}

class AddTask extends TaskEvent {
  final String taskName;
  const AddTask({required this.taskName});

  @override
  List<Object?> get props => [taskName];
}
