import 'package:auth/models/task_model.dart';
import 'package:auth/view_model/componants/custom_text.dart';
import 'package:flutter/material.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({Key? key, required this.task, this.onTap,}) : super(key: key);
  final Task task;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap:onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blueAccent.withOpacity(.2),
          ),
          width: double.infinity,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCustom(text: task.title??'',fontWeight: FontWeight.bold,fontSize: 22),
                  TextCustom(text: task.description??'',color: Colors.black.withOpacity(.5),),
                  TextCustom(text: task.startDate??''),
                  Container(
                    child: Row(
                      children: [
                        TextCustom(text: task.endDate??''),
                        const Spacer(),
                        TextCustom(text: task.status??''),
                      ],
                    ),
                  ),

                ],
              ),
              if(task.image !=null)
                Image.network(task.image??'',width:  double.infinity, height: 200,fit: BoxFit.cover,),
            ],
          ),
        ),
      ),
    );
  }
}
