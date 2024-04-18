import 'package:auth/models/onboarding_model.dart';
import 'package:auth/utils/app_help/app_colores.dart';
import 'package:auth/view_model/componants/custom_text.dart';
import 'package:auth/view_model/data/local/shared_helper.dart';
import 'package:auth/view_model/data/local/shared_keys.dart';
import 'package:auth/views/auth_screens/login_screen.dart';
import 'package:auth/views/auth_screens/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../view_model/cubit/onbording_cubit/onbording_cubit.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: OnbordingCubit.get(context).controller,
        itemCount: OnboardingModel.onboardingList.length,
        itemBuilder: (context, index) {
          return OnboardingWidget(
            onboardingModel: OnboardingModel.onboardingList[index],
            index: index,
          );
        },
      ),
    );
  }
}

class OnboardingWidget extends StatelessWidget {
  const OnboardingWidget(
      {super.key, required this.onboardingModel, required this.index});

  final int index;
  final OnboardingModel onboardingModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (index != 2)
              MaterialButton(
                color: AppColores.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  OnbordingCubit.get(context).controller!.jumpToPage(2);
                },
                child: TextCustom(
                  text: 'Skip',
                  color: Colors.white,
                ),
              ),
            SizedBox(
              height: 110,
            ),
            Center(
                child: Text(
              onboardingModel.title,
              style: Theme.of(context).textTheme.displayLarge,
            )),
            SizedBox(
              height: 50,
            ),
            Center(child: Image.network(onboardingModel.image)),
            SizedBox(
              height: 60,
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                onboardingModel.subTitle,
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
            )),
            Spacer(),
            Row(
              children: [
                index != 2
                    ? MaterialButton(
                        color: AppColores.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          OnbordingCubit.get(context).controller!.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.linear);
                        },
                        child: TextCustom(
                          text: 'Next',
                          color: Colors.white,
                        ),
                      )
                    : MaterialButton(
                        color: AppColores.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          OnbordingCubit.get(context).controller!.jumpToPage(0);
                        },
                        child: TextCustom(
                          text: 'Back',
                          color: Colors.white,
                        ),
                      ),
                Spacer(),
                if (index == 2)
                  MaterialButton(
                    color: AppColores.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: () async {
                      await SharedHelper.set(
                              key: SharedKeys.onbarding, value: true)
                          .then((value) {
                            print('SharedHelper.get(key: SharedKeys.onbarding');
                            print(SharedHelper.get(key: SharedKeys.onbarding));
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                            (route) => false);
                      });
                    },
                    child: TextCustom(
                      text: 'Get Started',
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
