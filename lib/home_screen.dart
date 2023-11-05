import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shortpoint_test/domain/task.dart';
import 'package:shortpoint_test/edit_task_screen.dart';
import 'package:shortpoint_test/task_card.dart';
import 'package:shortpoint_test/theme/colors/app_colors.dart';

import 'task_bloc/task_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 123,
        backgroundColor: AppColors.primary,
        title: Row(children: [
          Padding(
            padding: const EdgeInsets.only(right: 21, bottom: 34),
            child: Image.asset("assets/home_screen_assistent.png"),
          ),
          RichText(
            text: TextSpan(
              text: "Hello, Jhon \n",
              style: GoogleFonts.roboto(fontSize: 16, color: AppColors.white),
              children: [
                TextSpan(
                  text: "What are  your plans \nfor today?",
                  style: GoogleFonts.roboto(
                    fontSize: 25,
                    color: AppColors.white,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w100,
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const EditTaskScreen(),
            ),
          );
        },
        child: Container(
          width: 60,
          height: 61,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary,
            border: Border.all(
              color: const Color(0xFF123EB1),
              width: 2.0,
            ),
            boxShadow: [
              const BoxShadow(
                color: Color.fromRGBO(168, 181, 222, 0.5),
                offset: Offset(0, 3),
                blurRadius: 1,
                spreadRadius: 0,
              ),
              BoxShadow(
                color: AppColors.black.withOpacity(0.25),
                offset: const Offset(4, 4),
                blurRadius: 4,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Center(
            child: Text(
              "+",
              style: GoogleFonts.roboto(
                color: AppColors.white,
                fontSize: 36,
                fontWeight: FontWeight.w400,
                shadows: <Shadow>[
                  const Shadow(
                    offset: Offset(0, 2),
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFF9EB031), // Border color
                width: 2.0, // Border width
              ),
              color: AppColors.accent, // Background color
              boxShadow: [
                BoxShadow(
                  color: AppColors.white.withOpacity(0.60),
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 32, horizontal: 25),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 28),
                          child:
                              SvgPicture.asset("assets/home_screen_trophy.svg"),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "GO PRO(NO ADS)",
                              style: GoogleFonts.roboto(
                                  color: AppColors.secondary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "No fuss, no ads, for only \$1\na month",
                              style: GoogleFonts.roboto(
                                  color: const Color(0xFF0D2972),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Container(
                        height: 71,
                        width: 66,
                        color: AppColors.secondary,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "\$1",
                              style: GoogleFonts.roboto(
                                  color: AppColors.gold,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) => state is TaskLoaded
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.tasks.length,
                        itemBuilder: (context, index) =>
                            TaskCard(task: state.tasks[index]),
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
