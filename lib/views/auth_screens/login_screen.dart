import 'package:auth/utils/app_help/app_colores.dart';
import 'package:auth/utils/components/custom_text_form_field.dart';
import 'package:auth/view_model/componants/custom_text.dart';
import 'package:auth/views/auth_screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/app_help/app_images.dart';
import '../../view_model/cubit/auth_cubit/authentication_cubit.dart';
import '../../view_model/cubit/auth_cubit/authentication_state.dart';
import '../home_screen/task_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is LoginSuccsesState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const TaskScreen(),
              ),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          AuthCubit loginCubit = AuthCubit.get(context);
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: loginCubit.loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Text(
                      'Login Here',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      'welcome Back we missed you!',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    CustomTextFormFieldAuth(
                        hintText: 'email',
                        controller: loginCubit.emailController),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormFieldAuth(
                        hintText: 'password',
                        controller: loginCubit.PaswordController),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          'if you don\'t have an account ->',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        MaterialButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterScreen(),
                                  ));
                            },
                            child: Text(
                              'Register Now',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: AppColores.primary),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    MaterialButton(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      onPressed: () {
                        if (loginCubit.loginFormKey.currentState!.validate()) {
                          loginCubit.login();
                        }
                      },
                      color: AppColores.primary,
                      minWidth: double.infinity,
                      child: state is LoginLodingState
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'Login',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'or contain with',
                      style:
                      TextStyle(color: AppColores.primary, fontSize: 16),
                    ),

                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1 ,color: AppColores.primary,strokeAlign: 1),

                            color: AppColores.formField,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: 45,
                          height: 45,
                          child: Image.network(
                            fit: BoxFit.contain,
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSfq1ApEC2D26pFVLR-MMDfSekvuj1SGYBNSD3irjt7Iw&s',
                          ),
                        ),
                        Container(clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1 ,color: AppColores.primary,strokeAlign: 1),

                            color: AppColores.formField,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: 45,
                          height: 45,
                          child: Image.network(
                            fit: BoxFit.contain,
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNRHHZB2MPlU0bEhq29mFkzVPJ-NAFLDlMbQ&s',
                          ),
                        ),
                        Container(clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1 ,color: AppColores.primary,strokeAlign: 1),

                            color: AppColores.formField,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: 45,
                          height: 45,
                          child: Image.network(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQEDvQsVSPhlLKnT66KTeTCGjvExnHDTWivtA&s',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
