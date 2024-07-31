import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_excercise/feature/auth/model/user.dart';
import 'package:health_excercise/feature/auth/viewmodel/user_cubit.dart';
import 'package:health_excercise/feature/exercise/view/sunny_day_view.dart';
import 'package:health_excercise/product/service/auth_service.dart';
import 'package:health_excercise/product/widget/button/login_button.dart';
import 'package:health_excercise/product/widget/padding/spaces/gaps.dart';
import 'package:health_excercise/product/widget/text_form_field/login_text_form_field.dart';

@RoutePage()

/// PersonalInfoView
class PersonalInfoView extends StatelessWidget {
  /// PersonalInfoView constructor
  const PersonalInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    final ageController = TextEditingController();
    final heightController = TextEditingController();
    final weightController = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: const Color(0xffFCF7FA),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          children: [
            const Center(
              child: Text(
                'Kişisel Sağlık Bilgileri',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Gaps.heightMedium(),
            const Text(
              'Size daha iyi rehberlik edebilmemiz için lütfen kilo, boy ve yaş bilgilerinizi giriniz.',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const Gaps.heightMedium(),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Yaş',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            LoginTextFormField(
              hintText: 'Yaş',
              digitOnly: true,
              maxLength: 2,
              controller: ageController,
            ),
            const Gaps.heightMedium(),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Boy',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            LoginTextFormField(
              hintText: 'Boy',
              digitOnly: true,
              maxLength: 3,
              controller: heightController,
            ),
            const Gaps.heightMedium(),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Kilo',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            LoginTextFormField(
              hintText: 'Kilo',
              digitOnly: true,
              maxLength: 3,
              controller: weightController,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: LoginButton(
                    text: 'Devam Et',
                    color: const Color(0xffF5E5E8),
                    onPressed: () async {
                      final age = ageController.text;
                      final weight = int.parse(weightController.text);
                      final height = int.parse(heightController.text);

                      final currentUser = context.read<UserCubit>().getUser();
                      final newUser = User(
                        name: currentUser?.name ?? '',
                        surname: currentUser?.surname ?? '',
                        // password: currentUser?.password ?? '',
                        email: currentUser?.email ?? '',
                        generalAnlysisRegion:
                            currentUser?.generalAnlysisRegion ?? '',
                        age: age,
                        weight: weight,
                        height: height,
                      );
                      context.read<UserCubit>().updateUser(
                            age,
                            weight,
                            height,
                          );

                      await AuthService.updateUser(newUser);

                      if (context.mounted) {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SunnyDayView(),
                            settings: const RouteSettings(
                              arguments: [-1, 360],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
