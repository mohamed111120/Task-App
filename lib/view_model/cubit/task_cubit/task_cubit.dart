import 'package:auth/models/task_model.dart';
import 'package:auth/utils/app_help/custom_toast.dart';
import 'package:auth/view_model/data/local/shared_helper.dart';
import 'package:auth/view_model/data/local/shared_keys.dart';
import 'package:auth/view_model/data/network/dio_helper.dart';
import 'package:auth/view_model/data/network/end_points.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskStates> {
  TaskCubit() : super(TaskInitialState());

  static TaskCubit get(context) => BlocProvider.of<TaskCubit>(context);

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TaskModel? taskModel;

  String status = 'new';

  void changeTaskStatus(status) {
    this.status = status;
    emit(ChangeTaskStatusState());
  }

  Future<void> getAllTasks() async {
    emit(GetTaskLodingState());
    await DioHelper.get(
      endPoint: EndPoints.tasksEndPoint,
      withToken: true,
    ).then((response) {
      print('================================response======================================');
      print(response.data);
      taskModel = TaskModel.fromJson(response.data);
      emit(GetTaskSucssesState());
    }).catchError((onError) {
      if (onError is DioException) {
        print(onError.response?.data);
        if (onError.response?.data['status'] == 401) {
          SharedHelper.remove(key: SharedKeys.token);
          emit(TokenExpierd());

        }
      }
      emit(GetTaskFaliedState());
      throw onError;
    });
  }

  Future<void> addTAsk() async {
    emit(AddTaskLodingState());
    // Task newTask = Task(
    //   title: titleController.text,
    //   description: descriptionController.text,
    //   startDate: startDateController.text,
    //   endDate: endDateController.text,
    //   status: 'new',
    // );
    // FormData formData = FormData.fromMap({
    //   ...newTask.toJson(),
    //   // if (image != null)
    //   //   'image': await MultipartFile.fromFile(image?.path ?? ''),
    // });
    await DioHelper.post(
      endPoint: EndPoints.tasksEndPoint,
      withToken: true,
      formData: FormData.fromMap({
        "title": titleController.text,
        'description': descriptionController.text,
        'start_date': startDateController.text,
        'end_date': endDateController.text,
        'status': 'new',
        if (image != null)
          'image': await MultipartFile.fromFile(image?.path ?? ''),
      }),
    ).then((value) {
      showToast(message: value.data['message'], state: ToastState.success);
      getAllTasks();
      emit(AddTaskSucssesState());
    }).catchError((e) {
      if (e is DioException) {
        showToast(message: e.response!.data['message'], state: ToastState.error);
      }
      print(image);
      emit(AddTaskFaliedState());
      throw onError;
    });
  }

  void reset() {
    titleController.clear();
    descriptionController.clear();
    startDateController.clear();
    endDateController.clear();
    image = null;
    status = 'new';
  }

  Future<void> deleteTask(int taskId) async {
    emit(DeleteTaskLodingState());
    await DioHelper.delete(
            endPoint: '${EndPoints.tasksEndPoint}/$taskId', withToken: true)
        .then((value) {
      showToast(message: value.data['message'], state: ToastState.success);

      getAllTasks();
      emit(DeleteTaskSucssesState());
    }).catchError((e) {
      if (onError is DioException) {
        showToast(message: e.response!.data['message'], state: ToastState.error);

        print(e.response?.data);
      }
      emit(DeleteTaskFaliedState());
      throw e;
    });
  }

  Future<void> editTask(int taskId) async {
    emit(EditTaskLodingState());
    Task editTask = Task(
      title: titleController.text,
      description: descriptionController.text,
      startDate: startDateController.text,
      endDate: endDateController.text,
      status: status,
    );

    FormData formData = FormData.fromMap({
      '_method': 'PUT',
      ...editTask.toJson(),
      if (image != null)
        'image': await MultipartFile.fromFile(image?.path ?? ''),
    });
    await DioHelper.post(
      endPoint: '${EndPoints.tasksEndPoint}/$taskId',
      withToken: true,
      formData: formData,
    ).then((value) {
      // for(int i =0 ; i<(taskModel?.data?.tasks??[]).length;i++){
      //   if(taskModel?.data?.tasks?[i].id == taskId){
      //     taskModel?.data?.tasks?[i] == editTask;
      //     break;
      //   }
      // }
      showToast(message: value.data['message'], state: ToastState.success);

      getAllTasks();
      print(value.data);
      emit(EditTaskSucssesState());
    }).catchError((onError) {
      if (onError is DioException) {
        showToast(message: onError.response!.data['message'], state: ToastState.error);

      }
      emit(EditTaskFaliedState());
    });
  }

  final ImagePicker picker = ImagePicker();
  XFile? image;

  Future<void> pickImage() async {
    emit(PickImageLodingState());
    image = await picker.pickImage(source: ImageSource.gallery);
    emit(PickImageSucssesState());
  }

  ScrollController scrollcontroller = ScrollController();

  void initListener() {
    scrollcontroller.addListener(() {
      if (scrollcontroller.position.atEdge &&
          scrollcontroller.position.pixels != 0) {
        if ((taskModel?.data?.meta?.currentPage ?? 0) < (taskModel?.data?.meta?.lastPage ?? 0)) {
          getMoreTasks();
        }

      }
    });
  }

  bool isLoding = false;
  Future<void> getMoreTasks() async {
    if(isLoding){
      return;
    }
    isLoding = true ;
    emit(GetMoreTasksLodingState());
    await DioHelper.get(
        endPoint: EndPoints.tasksEndPoint,
        withToken: true,
        queryParameters: {
          'page': (taskModel?.data?.meta?.currentPage ??0)+1 ,
        }).then((value) {
      taskModel?.data?.meta = Meta.fromJson(value.data['data']['meta']);
      for(var i in value.data['data']['tasks']){
        taskModel?.data?.tasks?.add(Task.fromJson(i));
      }
      isLoding = false;
      print(value.data);
      emit(GetMoreTasksSucssesState());
    }).catchError((onError) {
      if (onError is DioException) {
        print(onError.response?.data ?? '');
      }
      isLoding = false;
      emit(GetMoreTasksFaliedState());
    });
  }
}
