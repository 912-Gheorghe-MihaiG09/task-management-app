import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortpoint_test/home_screen.dart';
import 'package:shortpoint_test/repository/task_repository.dart';
import 'package:shortpoint_test/repository/task_repository_impl.dart';
import 'package:shortpoint_test/task_bloc/task_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final TaskRepository _taskRepository = TaskRepositoryImplementation();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => _taskRepository,
      child: BlocProvider(
        create: (_) => TaskBloc(_taskRepository)..add(const FetchTasks()),
        child: const MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );
  }
}
