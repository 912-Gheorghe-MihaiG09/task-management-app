import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shortpoint_test/domain/task.dart';
import 'package:shortpoint_test/repository/task_repository.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository;

  TaskBloc(this.taskRepository) : super(TaskInitial()) {
    on<UpdateTask>(_onUpdateTask);
    on<FetchTasks>(_onFetchTasks);
    on<AddTask>(_onAddTask);
  }

  FutureOr<void> _onUpdateTask(
      UpdateTask event, Emitter<TaskState> emit) async {
    emit(TaskLoading());

    try {
      await taskRepository.updateTask(event.task);
      List<Task> tasks = await taskRepository.getTasks();

      emit(TaskLoaded(tasks: tasks));
    } catch (e, stack) {
      log("$runtimeType _onAddTask error: $e, stack: $stack");

      emit(TaskError(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _onFetchTasks(
      FetchTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());

    try {
      List<Task> tasks = await taskRepository.getTasks();

      emit(TaskLoaded(tasks: tasks));
    } catch (e, stack) {
      log("$runtimeType _onFetchTasks error: $e, stack: $stack");

      emit(TaskError(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _onAddTask(AddTask event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    emit(TaskLoading());

    try {
      await taskRepository.addTask(event.taskName);
      List<Task> tasks = await taskRepository.getTasks();

      emit(TaskLoaded(tasks: tasks));
    } catch (e, stack) {
      log("$runtimeType _onAddTask error: $e, stack: $stack");

      emit(TaskError(errorMessage: e.toString()));
    }
  }
}
