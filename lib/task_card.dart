import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shortpoint_test/domain/task.dart';
import 'package:shortpoint_test/edit_task_screen.dart';
import 'package:shortpoint_test/task_bloc/task_bloc.dart';
import 'package:shortpoint_test/theme/colors/app_colors.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Padding(
        padding: const EdgeInsets.all(23),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => BlocProvider.of<TaskBloc>(context).add(UpdateTask(
                  task: task.copyWith(isCompleted: !task.isCompleted))),
              child: task.isCompleted
                  ? SvgPicture.asset("assets/task_card_radio_box_completed.svg")
                  : SvgPicture.asset("assets/task_card_radio_box.svg"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 17),
              child: Text(
                task.name,
                style: task.isCompleted
                    ? GoogleFonts.roboto(
                        color: AppColors.gray,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.lineThrough,
                      )
                    : GoogleFonts.roboto(
                        color: AppColors.secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditTaskScreen(
                    task: task,
                  ),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4), // Border radius
                  border: Border.all(
                    color: AppColors.secondary, // Border color
                    width: 1, // Border width
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    "EDIT",
                    style: GoogleFonts.roboto(
                        color: AppColors.secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
