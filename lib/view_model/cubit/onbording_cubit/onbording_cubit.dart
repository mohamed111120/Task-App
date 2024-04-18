import 'package:auth/view_model/data/local/shared_helper.dart';
import 'package:auth/view_model/data/local/shared_keys.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'onbording_state.dart';

class OnbordingCubit extends Cubit<OnbordingState> {
  OnbordingCubit() : super(OnbordingInitial());

  static OnbordingCubit get(context) =>
      BlocProvider.of<OnbordingCubit>(context);

  PageController? controller = PageController();
}
