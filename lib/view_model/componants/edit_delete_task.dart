import 'dart:io';

import 'package:auth/models/task_model.dart';
import 'package:auth/utils/app_help/app_colores.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import '../cubit/task_cubit/task_cubit.dart';
import 'custom_text.dart';
import 'custom_text_form_field.dart';

class EditDeleteTask extends StatefulWidget {
  const EditDeleteTask({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  State<EditDeleteTask> createState() => _EditDeleteTaskState();
}

class _EditDeleteTaskState extends State<EditDeleteTask> {


  @override
  void initState() {
    TaskCubit.get(context).titleController.text = widget.task.title ?? '';
    TaskCubit.get(context).descriptionController.text = widget.task.description ?? '';
    TaskCubit.get(context).startDateController.text = widget.task.startDate ?? '';
    TaskCubit.get(context).endDateController.text = widget.task.endDate ?? '';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SafeArea(
          child: Form(
            key: TaskCubit.get(context).globalKey,
            child: ListView(
              padding: const EdgeInsets.all(10),
              shrinkWrap: true,
              children: [
                CustomTextFormField(
                  validator: (value) {
                    if ((value ?? '').trim().isEmpty) {
                      return 'Pleas , enter Title of task';
                    } else {
                      return null;
                    }
                  },
                  hintText: 'title',
                  controller: TaskCubit.get(context).titleController,
                ),
                CustomTextFormField(
                  textInputAction: TextInputAction.done,
                  hintText: 'Description',
                  controller: TaskCubit.get(context).descriptionController,
                ),
                CustomTextFormField(
                  validator: (value) {
                    if ((value ?? '').trim().isEmpty) {
                      return 'Pleas , enter Start Date of task';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.none,
                  hintText: 'Start Date',
                  controller: TaskCubit.get(context).startDateController,
                  onTap: () {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(DateTime.now().year + 10),
                    ).then((value) {
                      if (value != null) {
                        BlocProvider.of<TaskCubit>(context)
                            .startDateController
                            .text = DateFormat("yyyy-MM-dd").format(value);
                      }
                    });
                  },
                ),
                CustomTextFormField(
                  validator: (value) {
                    if ((value ?? '').trim().isEmpty) {
                      return 'Pleas , enter End Date of task';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.none,
                  hintText: 'End Date',
                  controller: TaskCubit.get(context).endDateController,
                  onTap: () {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(DateTime.now().year + 10),
                    ).then((value) {
                      if (value != null) {
                        BlocProvider.of<TaskCubit>(context)
                            .endDateController
                            .text = DateFormat("yyyy-MM-dd").format(value);
                      }
                    });
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                DropdownButtonFormField(
                  value: widget.task.status,
                  items: const [
                    DropdownMenuItem(
                      value: 'new',
                      child: TextCustom(
                        text: 'New',
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'compeleted',
                      child: TextCustom(
                        text: 'Compeleted',
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'outdated',
                      child: TextCustom(
                        text: 'Outdated',
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'doing',
                      child: TextCustom(
                        text: 'Doing',
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      TaskCubit.get(context).changeTaskStatus(value);
                    }
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'please, Select status';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                //image

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () async {
                      await Permission.photos.request();
                      var status = await Permission.photos.status;
                      print(status);
                      if (status == PermissionStatus.granted) {
                        TaskCubit.get(context).pickImage();
                      } else {
                        await Permission.photos.request();
                      }
                    },
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColores.primary),
                      ),
                      child: BlocBuilder<TaskCubit, TaskStates>(
                        builder: (context, state) {
                          print(
                              '-------------------------------------------------');
                          print(TaskCubit.get(context).image);
                          print(widget.task.image);
                          return Visibility(
                              visible: widget.task.image == null &&
                                  TaskCubit.get(context).image == null,
                              replacement: Visibility(
                                visible: TaskCubit.get(context).image == null,
                                replacement: Image.file(
                                  File(
                                      TaskCubit.get(context).image?.path ?? ''),
                                  fit: BoxFit.contain,
                                  width: 200,
                                  height: 200,
                                ),
                                child: Image.network(
                                  widget.task.image ?? '',
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  Image.network(
                                    'https://static-00.iconduck.com/assets.00/task-list-add-icon-512x512-hjg3jflj.png',
                                    height: 80,
                                    width: 80,
                                  ),
                                  const SizedBox(height: 10),
                                  const TextCustom(
                                      text: 'Enter Your Task Image'),
                                  const SizedBox(height: 10),
                                ],
                              ));
                        },
                      ),
                    ),
                  ),
                ),
                BlocBuilder<TaskCubit, TaskStates>(
                  builder: (context, state) => Visibility(
                    visible: state is AddTaskLodingState,
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: LinearProgressIndicator(color: Colors.blue),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              if (TaskCubit.get(context)
                                  .globalKey
                                  .currentState!
                                  .validate()) {
                                TaskCubit.get(context).editTask(widget.task.id ?? 0);
                              }
                            },
                            child: const TextCustom(
                              text: 'Edit',
                              color: Colors.white,
                            )),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: const BorderSide(
                                      color: Colors.red, width: 2)),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const TextCustom(
                                      text: 'Are you want to delete this task?',
                                    ),
                                    titlePadding: const EdgeInsets.all(30),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    actions: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          fixedSize: Size(100, 40)
                                        ),
                                          onPressed: () {
                                            BlocProvider.of<TaskCubit>(context)
                                                .deleteTask(widget.task.id!)
                                                .then((value) {
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            });
                                          },
                                          child: const TextCustom(
                                            text: 'Yes',color: Colors.white,
                                          )),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              fixedSize: Size(100, 40)
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                          child: const TextCustom(
                                            text: 'No',color: Colors.white,
                                          )),
                                    ],
                                  );
                                },
                              );
                            },
                            child: const TextCustom(
                              text: 'Delete',
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
