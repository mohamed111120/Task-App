import 'package:flutter/material.dart';

import '../cubit/task_cubit/task_cubit.dart';
import 'add_task.dart';
import 'custom_text.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  FloatingActionButton(
      onPressed: () {
        TaskCubit.get(context).reset();
        showModalBottomSheet(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          context: context,
          builder: (context) {

            return const AddTask();
          },
          enableDrag: true,
          isDismissible: true,
          isScrollControlled: true,
          barrierColor: Colors.blue.withOpacity(.3),
        );
      },
      child: const TextCustom(
        text: '+',
        color: Colors.white,
      ),
    );
  }
}
