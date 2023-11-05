import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shortpoint_test/domain/task.dart';
import 'package:shortpoint_test/task_bloc/task_bloc.dart';
import 'package:shortpoint_test/theme/colors/app_colors.dart';

class EditTaskScreen extends StatefulWidget {
  final Task? task;

  const EditTaskScreen({super.key, this.task});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _controller.text = widget.task!.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, TaskState>(
      listenWhen: (prev, current) {
        return prev is TaskLoading && current is TaskLoaded;
      },
      listener: (_, __) => Navigator.pop(context),
      builder: (context, state) => WillPopScope(
        onWillPop: () async => state is! TaskLoading,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primary,
            leading: GestureDetector(
              onTap: () => state is! TaskLoading ? Navigator.pop(context) : null,
              child: const Icon(
                Icons.arrow_back,
                color: AppColors.white,
              ),
            ),
            title: Text(
              widget.task != null ? "Edit Task" : "Add new Task",
              style: GoogleFonts.roboto(
                  color: AppColors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  shadows: <Shadow>[
                    const Shadow(
                      offset: Offset(0, 1),
                      color: Colors.black,
                    ),
                  ]),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text(
                    "Task Name",
                    style: GoogleFonts.roboto(
                        color: AppColors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.84,
                        height: 1.215),
                  ),
                ),
                TextFormField(
                  controller: _controller,
                  style: GoogleFonts.roboto(
                      color: AppColors.third,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      height: 1.215),
                  cursorColor: AppColors.primary,
                  validator: _emptyValidator,
                  decoration: _textFieldDecoration(),
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_emptyValidator(_controller.text) == null) {
                            widget.task == null
                                ? BlocProvider.of<TaskBloc>(context).add(
                                    AddTask(taskName: _controller.text),
                                  )
                                : BlocProvider.of<TaskBloc>(context).add(
                                    UpdateTask(
                                      task: widget.task!
                                          .copyWith(name: _controller.text),
                                    ),
                                  );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please insert Task Name!'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          }
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(6.0), // Border radius
                              side: const BorderSide(
                                color: AppColors.third, // Border color
                                width: 2.0, // Border width
                              ),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.primary), // Background color
                          elevation: MaterialStateProperty.all<double>(
                              0), // Remove default elevation
                          shadowColor: MaterialStateProperty.all<Color>(
                              AppColors.white), // Shadow color
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: state is TaskLoaded
                              ? Text(
                                  'Done',
                                  style: GoogleFonts.roboto(
                                    color: AppColors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    shadows: <Shadow>[
                                      const Shadow(
                                        offset: Offset(0, 2),
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                )
                              : const Center(
                                  child: CircularProgressIndicator()),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _textFieldDecoration() {
    return InputDecoration(
      focusColor: AppColors.primary,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(
          color: AppColors.primary, // Border color when selected
          width: 2.0, // Border width
        ),
      ),
      contentPadding:
          const EdgeInsets.only(left: 17, right: 17, top: 20, bottom: 25),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(
          color: Color(0xFFCBCBCB),
          width: 2,
        ),
      ),
      filled: true,
      fillColor: const Color(0xFFFDFDFD), // Background color
    );
  }

  String? _emptyValidator(String? s) {
    if (s == null || s.isEmpty) {
      return "* Required";
    }
    return null;
  }
}
