import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_excercise/feature/auth/viewmodel/user_cubit.dart';
import 'package:health_excercise/feature/exercise/view/sunny_day_view.dart';
import 'package:health_excercise/product/init/cache/shared_manager.dart';
import 'package:health_excercise/product/navigation/app_router.dart';
import 'package:health_excercise/product/service/auth_service.dart';
import 'package:health_excercise/product/widget/button/login_button.dart';
import 'package:health_excercise/product/widget/padding/spaces/gaps.dart';
import 'package:health_excercise/product/widget/text_form_field/login_text_form_field.dart';

@RoutePage()

/// Login view
class LoginView extends StatelessWidget {
  /// Login view constructor
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Giriş Yap',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Tekrar Hoşgeldin',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const Gaps.heightMedium(),
            LoginTextFormField(
              hintText: 'Kullanıcı Adı',
              controller: usernameController,
            ),
            const Gaps.heightMedium(),
            LoginTextFormField(
              hintText: 'Şifre',
              controller: passwordController,
              isPassword: true,
            ),
            const Gaps.heightMedium(),
            SizedBox(
              width: double.infinity,
              child: LoginButton(
                text: 'Giriş Yap',
                onPressed: () async {
                  final result = await AuthService.login(
                    context,
                    usernameController.text,
                    passwordController.text,
                  );

                  if (!result && context.mounted) {
                    await _showAlert(context);
                  }

                  if (result && context.mounted) {
                    final user = context.read<UserCubit>().getUser();
                    final dataUsage = await SharedManager.getDataUsage();

                    if (!dataUsage && context.mounted) {
                      await context.router.push(const DataUsageRoute());
                    } else if (user != null &&
                        user.age == 'string' &&
                        context.mounted) {
                      await context.router.push(const PersonalInfoRoute());
                    } else if (user != null &&
                        (user.generalAnlysisRegion == 'string' ||
                            user.generalAnlysisRegion == 'null') &&
                        context.mounted) {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SunnyDayView(),
                          settings: const RouteSettings(
                            arguments: [-1, 360],
                          ),
                        ),
                      );
                    } else {
                      if (context.mounted) {
                        // SharedManager.setJwtToken(token: token);
                        await context.router.push(BottomNavigationBarRoute());
                      }
                    }
                  }
                },
              ),
            ),
            const Gaps.heightNormal(),
            TextButton(
              onPressed: () {
                context.router.push(const RegisterRoute());
              },
              child: const Text(
                'Hesabın Yok Mu? Kayıt Ol',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _showAlert(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData(
            dialogBackgroundColor: Colors.red,
          ),
          child: AlertDialog(
            title: const Text(
              'İşlem Başarısız',
              style: TextStyle(color: Colors.white),
            ),
            content: const Text(
              'Giriş Bilgileriniz Hatalı',
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'Tamam',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
