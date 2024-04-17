import 'dart:io';

import 'package:auth/utils/app_help/app_colores.dart';
import 'package:auth/view_model/componants/custom_text.dart';
import 'package:auth/view_model/componants/custom_text_form_field.dart';
import 'package:auth/view_model/cubit/task_cubit/task_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

// BlocProvider And Builder
// BlocProvider And Builder
// BlocProvider And Builder
// BlocProvider And Builder
// BlocProvider And Builder

class AddTask extends StatelessWidget {
  const AddTask({Key? key}) : super(key: key);

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
              //Title
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
              //Description
              CustomTextFormField(
                // textInputAction: TextInputAction.done,
                hintText: 'Description',
                controller:
                TaskCubit.get(context).descriptionController,
              ),
              // StartDate
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
                controller:
                TaskCubit.get(context).startDateController,
                onTap: () {
                  showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(DateTime.now().year + 10),
                  ).then((value) {
                    if (value != null) {
                      TaskCubit.get(context).startDateController
                          .text = DateFormat("yyyy-MM-dd").format(value);
                    }
                  });
                },
              ),
              // endDate
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
                controller:
                TaskCubit.get(context).endDateController,
                onTap: () {
                  showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(DateTime.now().year + 10),
                  ).then((value) {
                    if (value != null) {
                      TaskCubit.get(context).endDateController
                          .text = DateFormat("yyyy-MM-dd").format(value);
                    }
                  });
                },
              ),
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColores.primary),
                    ),
                    child: BlocBuilder<TaskCubit, TaskStates>(
                      builder: (context, state) {
                        print(TaskCubit.get(context).image);
                        return Visibility(
                          visible: TaskCubit.get(context).image == null,
                          replacement: Image.file(
                            File(TaskCubit.get(context).image?.path ?? ''),
                            fit: BoxFit.contain,
                            width: 200,
                            height: 200,
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
                              const TextCustom(text: 'Enter Your Task Image'),
                              const SizedBox(height: 10),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              BlocBuilder<TaskCubit, TaskStates>(
                builder: (context, state) =>
                    Visibility(
                      visible: state is AddTaskLodingState,
                        child: const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: LinearProgressIndicator(color: Colors.blue),
                        ),
                    ),
              ),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () async {
                      if (TaskCubit.get(context).globalKey
                          .currentState!
                          .validate()) {
                        await TaskCubit.get(context).addTAsk()
                            .then((value) {
                          Navigator.pop(context);
                        });
                      }
                    },
                    child: const TextCustom(
                      text: 'Add',
                      color: Colors.white,
                    )),
              )
            ],
          ),
        )));
  }
}
