import 'package:auth/view_model/cubit/auth_cubit/authentication_cubit.dart';
import 'package:auth/view_model/cubit/onbording_cubit/onbording_cubit.dart';
import 'package:auth/view_model/cubit/task_cubit/task_cubit.dart';
import 'package:auth/view_model/cubit/theme_cubit/theme_cubit.dart';
import 'package:auth/view_model/data/local/shared_helper.dart';
import 'package:auth/view_model/data/network/dio_helper.dart';
import 'package:auth/view_model/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc consumer.dart';
import 'views/splash_screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await SharedHelper.sharedInit();
  // await SharedHelper.clear();
  // print(SharedHelper.get(key: SharedKeys.token));
  DioHelper.dioInit();

  runApp(const TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TaskCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(
          create: (context) => OnbordingCubit(),
        ),
      ],
      child: Builder(builder: (context) {
        return BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            print('ThemeCubit.get(context).isDark');
            print(ThemeCubit.get(context).isDark);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: getLightTheme(),
              darkTheme: getDarkTheme(),
              themeMode: ThemeCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: SplashScreen(),
            );
          },
        );
      }),
    );
  }
}
