import 'package:auth/utils/components/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/app_help/app_colores.dart';
import '../../view_model/componants/custom_text.dart';
import '../../view_model/cubit/auth_cubit/authentication_cubit.dart';
import '../../view_model/cubit/auth_cubit/authentication_state.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is RegisterSuccsesState) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ));
          }
        },
        builder: (context, state) {
          AuthCubit registerCubit = AuthCubit.get(context);
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: registerCubit.registerFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 100,
                    ),
                    Text(
                      'Create Account',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      'create your account bro ♥',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextFormFieldAuth(
                        hintText: 'user name',
                        controller: registerCubit.UserNameController),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextFormFieldAuth(
                        hintText: 'email',
                        controller: registerCubit.emailController),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextFormFieldAuth(
                        hintText: 'pasword',
                        controller: registerCubit.PaswordController),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextFormFieldAuth(
                        hintText: 'confirm password',
                        controller: registerCubit.confirmPaswordController),
                    const SizedBox(
                      height: 15,
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
                                    builder: (context) => LoginScreen(),
                                  ));
                            },
                            child: Text(
                              'Login Now',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: AppColores.primary),
                            ))
                      ],
                    ),

                    MaterialButton(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      onPressed: () {
                        if (registerCubit.registerFormKey.currentState!.validate()) {
                          registerCubit.register();
                        }
                      },
                      color: Colors.blue,
                      minWidth: double.infinity,
                      child: state is RegisterLodingState
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'Register',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12),
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
                    const SizedBox(
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
                            fit: BoxFit.contain,
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrXehS6NSSkGA0n-nITk7zlew7B5S-0ge_Uw&s',
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
