import 'package:auth/utils/app_help/custom_toast.dart';
import 'package:auth/view_model/data/local/shared_helper.dart';
import 'package:auth/view_model/data/network/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/local/shared_keys.dart';
import '../../data/network/end_points.dart';
import 'authentication_state.dart';

// part '../cubit/auth_cubit/authentication_state.dart.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(RegisterInitialState());

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);

  final registerFormKey = GlobalKey<FormState>();
  final loginFormKey = GlobalKey<FormState>();

  final UserNameController = TextEditingController();
  final emailController = TextEditingController();
  final PaswordController = TextEditingController();

  final confirmPaswordController = TextEditingController();

  // Register
  void register() async {
    emit(RegisterLodingState());

    DioHelper.post(
      endPoint: EndPoints.registerEndPoint,
      body: {
        'name': UserNameController.text,
        'email': emailController.text,
        'password': PaswordController.text,
        'password_confirmation': confirmPaswordController.text,
      },
    ).then((response) {
      SharedHelper.set(
          key: SharedKeys.userName,
          value: response.data['data']['user']['name']);
      showToast(message: response.data['message'], state: ToastState.success);

      emit(RegisterSuccsesState());
    }).catchError((e) {
      print(e);
      if (e is DioException) {
        emit(RegisterFailedState(massage: e.response?.data['message']));
        showToast(message: e.response!.data['message'], state: ToastState.error);
      }
      throw e;
    });
  }

  void login() async {
    emit(LoginLodingState());
    DioHelper.post(endPoint: EndPoints.loginEndPoint, body: {
      'email': emailController.text,
      'password': PaswordController.text,
    }).then((response) async {
      await SharedHelper.set(
          key: SharedKeys.token, value: response.data['data']['token']);
      await SharedHelper.set(
          key: SharedKeys.userID, value: response.data['data']['user']['id']);
      await SharedHelper.set(
          key: SharedKeys.userName,
          value: response.data['data']['user']['name']);
      await SharedHelper.set(
          key: SharedKeys.userEmail,
          value: response.data['data']['user']['email']);
      showToast(message: response.data['message'], state: ToastState.success);

      emit(LoginSuccsesState());
    }).catchError((e) {
      print(e);
      if (e is DioException) {
        showToast(message: e.response!.data['message'], state: ToastState.error);
        emit(LoginFailedState(massage: e.response?.data['message']));
      }
      throw e;
    });
  }

  void logOut() async {
    emit(LogOutLoadingState());

    await DioHelper.post(endPoint: EndPoints.logout, withToken: true)
        .then((value) {
      SharedHelper.remove(key: SharedKeys.token);
      SharedHelper.remove(key: SharedKeys.userEmail);
      SharedHelper.remove(key: SharedKeys.userID);
      SharedHelper.remove(key: SharedKeys.userName);
      UserNameController.clear();
      confirmPaswordController.clear();
      PaswordController.clear();
      emailController.clear();
      showToast(message: value.data['message'], state: ToastState.success);
      emit(LogOutSuccessState());
    }).catchError((e) {
      if (e is DioException) {
        showToast(message: e.response!.data['message'], state: ToastState.error);
      }

      emit(LogOutFailedState(massage: e.response?.data['message']));
    });
  }
}
