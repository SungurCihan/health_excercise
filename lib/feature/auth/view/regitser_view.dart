import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_excercise/product/navigation/app_router.dart';
import 'package:health_excercise/product/service/auth_service.dart';
import 'package:health_excercise/product/widget/button/login_button.dart';
import 'package:health_excercise/product/widget/padding/spaces/gaps.dart';
import 'package:health_excercise/product/widget/text_form_field/login_text_form_field.dart';

@RoutePage()

/// Register view
class RegisterView extends StatelessWidget {
  /// Register view constructor
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kayıt Ol',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            LoginTextFormField(
              hintText: 'Kullanıcı Adı',
              controller: usernameController,
            ),
            const Gaps.heightNormal(),
            LoginTextFormField(
              hintText: 'Şifre',
              controller: passwordController,
              isPassword: true,
            ),
            const Gaps.heightNormal(),
            const Text(
              style: TextStyle(
                color: Color(0xff9E4759),
              ),
              'Daha zinde ve sağlıklı hissetmenizi sağlamak için size yardım edeceğiz. Belli bir program dahilinde aksatmadan günlük egzersizlerini yaparak özgüveninizi arttıracak ve sağlığınızı koruyacaksınız.',
            ),
            const Gaps.heightNormal(),
            SizedBox(
              width: double.infinity,
              child: LoginButton(
                text: 'Kayıt Ol',
                onPressed: () async {
                  final result = await AuthService.register(
                    usernameController.text,
                    passwordController.text,
                  );

                  if (context.mounted) {
                    await _showAlert(context, result);
                  }

                  if (result && context.mounted) {
                    await context.router.push(const LoginRoute());
                  }
                },
              ),
            ),
            const Gaps.heightNormal(),
            TextButton(
              onPressed: () {
                context.router.push(const LoginRoute());
              },
              child: const Text(
                'Zaten Hesabın Var Mı? Giriş Yap',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _showAlert(BuildContext context, bool success) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData(
            dialogBackgroundColor: success ? Colors.green : Colors.red,
          ),
          child: AlertDialog(
            title: Text(
              success ? 'İşlem Başarılı' : 'İşlem Başarısız',
              style: const TextStyle(color: Colors.white),
            ),
            content: Text(
              success
                  ? 'Kayıt işlemi başarıyla tamamlandı.'
                  : 'Kayıt işlemi başarısız oldu. Bu kullanıcı adı daha önce alınmış olabilir.',
              style: const TextStyle(color: Colors.white),
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
