import 'package:flutter/material.dart';
import 'package:health_excercise/product/init/theme/custom_light_theme.dart';
import 'package:health_excercise/product/init/theme/greys.dart';
import 'package:health_excercise/product/widget/padding/project_padding.dart';
import 'package:health_excercise/product/widget/padding/spaces/gaps.dart';
import 'package:health_excercise/product/widget/text_form_field/editable_text_form_field.dart';

/// ProfileView
class ProfileView extends StatelessWidget {
  /// ProfileView initialization
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Greys.neutral30,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Greys.neutral30,
          title: const Text(
            'Profil',
          ),
          centerTitle: true,
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.settings),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.fromBorderSide(
                  BorderSide(
                    color: CustomLightTheme().themeData.colorScheme.tertiary,
                  ),
                ),
                image: const DecorationImage(
                  image: AssetImage('assets/images/profile.png'),
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
          const Gaps.heightSmall(),
          RichText(
            text: TextSpan(
              text: 'Toplamda ',
              style: DefaultTextStyle.of(context).style,
              children: const <TextSpan>[
                TextSpan(
                  text: '43',
                  style: TextStyle(color: Colors.green),
                ),
                TextSpan(text: ' kere uygulamaya giriş yaptınız.'),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'Bugün ',
              style: DefaultTextStyle.of(context).style,
              children: const <TextSpan>[
                TextSpan(
                  text: '3',
                  style: TextStyle(color: Colors.pink),
                ),
                TextSpan(text: ' kere uygulamaya giriş yaptınız.'),
              ],
            ),
          ),
          const Gaps.heightNormal(),
          const Padding(
            padding: ProjectPadding.symetricHorizontalNormal(),
            child: Column(
              children: [
                EditableTextFormField(
                  prefixIcon: Icon(Icons.person),
                  label: 'Rumuz',
                  suffixIcon: Icon(Icons.edit),
                ),
                Gaps.heightMedium(),
                EditableTextFormField(
                  prefixIcon: Icon(Icons.calendar_today),
                  label: 'Yaş',
                  suffixIcon: Icon(Icons.edit),
                ),
                Gaps.heightMedium(),
                EditableTextFormField(
                  prefixIcon: Icon(Icons.female),
                  label: 'Cinsiyet',
                  suffixIcon: Icon(Icons.edit),
                ),
                Gaps.heightMedium(),
                EditableTextFormField(
                  prefixIcon: Icon(Icons.fitness_center),
                  label: 'Ağırlık',
                  suffixIcon: Icon(Icons.edit),
                ),
                Gaps.heightMedium(),
                EditableTextFormField(
                  prefixIcon: Icon(Icons.height),
                  label: 'Boy',
                  suffixIcon: Icon(Icons.edit),
                ),
                Gaps.heightMedium(),
                EditableTextFormField(
                  prefixIcon: Icon(Icons.sports),
                  label: 'Temel Egzersiz Bölgesi',
                  suffixIcon: Icon(Icons.edit),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
