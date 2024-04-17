import 'package:auth/models/task_model.dart';
import 'package:auth/view_model/componants/custom_floating_action_button.dart';
import 'package:auth/view_model/componants/edit_delete_task.dart';
import 'package:auth/view_model/componants/task_widget.dart';
import 'package:auth/view_model/cubit/auth_cubit/authentication_cubit.dart';
import 'package:auth/view_model/cubit/auth_cubit/authentication_state.dart';
import 'package:auth/view_model/cubit/task_cubit/task_cubit.dart';
import 'package:auth/view_model/data/local/shared_helper.dart';
import 'package:auth/view_model/data/local/shared_keys.dart';
import 'package:auth/views/auth_screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_model/componants/custom_text.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  void initState() {
    TaskCubit.get(context).getAllTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TaskCubit.get(context).initListener();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            TextCustom(
              text: '${SharedHelper.get(key: SharedKeys.userName)} Tasks',
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            Spacer(),
            BlocListener<AuthCubit, AuthStates>(
              listener: (context, state) {
                if(state is LogOutSuccessState){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen(),), (route) => false);
                }
              },
              child: InkWell(
                onTap: () {
                  AuthCubit.get(context).logOut();
                },
                child: Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,


      ),
      body: BlocConsumer<TaskCubit, TaskStates>(
        listener: (context, state) {
          if (state is TokenExpierd) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                    (route) => false);
          }

          if (state is EditTaskSucssesState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          var cubit = TaskCubit.get(context);
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  controller: cubit.scrollcontroller,
                  itemCount: cubit.taskModel?.data?.tasks?.length ?? 0,
                  itemBuilder: (context, index) {
                    return TaskWidget(
                      task: cubit.taskModel?.data?.tasks?[index] ?? Task(),
                      onTap: () {
                        TaskCubit.get(context).reset();
                        showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          context: context,
                          builder: (context) {
                            return EditDeleteTask(
                              task: cubit.taskModel?.data?.tasks?[index] ??
                                  Task(),
                            );
                          },
                          enableDrag: true,
                          isDismissible: true,
                          isScrollControlled: true,
                          barrierColor: Colors.blue.withOpacity(.3),
                        );
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox();
                  },
                ),
              ),
              if (state is GetMoreTasksLodingState)
                const CircularProgressIndicator(),
              if ((cubit.taskModel?.data?.meta?.currentPage ?? 0) ==
                  (cubit.taskModel?.data?.meta?.lastPage ?? 0))
                const TextCustom(text: 'Thier is no more Tasks'),
            ],
          );
        },
      ),
      floatingActionButton: const CustomFloatingActionButton(),
    );
  }
}
