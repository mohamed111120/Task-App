// part of '../cubit/auth_cubit/authentication_cubit.dart';

// @immutable
abstract class AuthStates {}

class RegisterInitialState extends AuthStates {}
class RegisterLodingState extends AuthStates {}
class RegisterSuccsesState extends AuthStates {}
class RegisterFailedState extends AuthStates {
  String massage;
  RegisterFailedState({required this.massage});
}

class LoginLodingState extends AuthStates {}
class LoginSuccsesState extends AuthStates {}
class LoginFailedState extends AuthStates {
  String massage;
  LoginFailedState({required this.massage});
}


class LogOutLoadingState extends AuthStates {}
class LogOutSuccessState extends AuthStates {}
class LogOutFailedState extends AuthStates {
  String massage;
  LogOutFailedState({required this.massage});
}


