part of 'task_cubit.dart';

@immutable
abstract class TaskStates {}

class TaskInitialState extends TaskStates {}
class GetTaskLodingState extends TaskStates {}
class GetTaskSucssesState extends TaskStates {}
class GetTaskFaliedState extends TaskStates {}
class TokenExpierd extends TaskStates {}

class AddTaskLodingState extends TaskStates {}
class AddTaskSucssesState extends TaskStates {}
class AddTaskFaliedState extends TaskStates {}

class ChangeTaskStatusState extends TaskStates {}


class DeleteTaskLodingState extends TaskStates {}
class DeleteTaskSucssesState extends TaskStates {}
class DeleteTaskFaliedState extends TaskStates {}

class EditTaskLodingState extends TaskStates {}
class EditTaskSucssesState extends TaskStates {}
class EditTaskFaliedState extends TaskStates {}

class PickImageLodingState extends TaskStates {}
class PickImageSucssesState extends TaskStates {}




class GetMoreTasksLodingState extends TaskStates {}
class GetMoreTasksSucssesState extends TaskStates {}
class GetMoreTasksFaliedState extends TaskStates {}