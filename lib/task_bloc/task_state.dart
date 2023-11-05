part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();
}

class TaskInitial extends TaskState {
  @override
  List<Object> get props => [];
}

class TaskLoading extends TaskState {
  @override
  List<Object> get props => [];
}

class TaskLoaded extends TaskState {
  final List<Task> tasks;

  const TaskLoaded({required this.tasks});
  @override
  List<Object> get props => [];
}


class TaskError extends TaskState {
  final String errorMessage;

  const TaskError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
