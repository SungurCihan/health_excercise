import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_excercise/feature/auth/model/user.dart';
import 'package:health_excercise/feature/auth/viewmodel/user_cubit.dart';
import 'package:health_excercise/product/init/theme/custom_light_theme.dart';
import 'package:health_excercise/product/init/theme/greys.dart';
import 'package:health_excercise/product/service/auth_service.dart';
import 'package:health_excercise/product/widget/padding/project_padding.dart';
import 'package:health_excercise/product/widget/padding/spaces/gaps.dart';
import 'package:health_excercise/product/widget/text_form_field/editable_text_form_field.dart';

/// ProfileView
class ProfileView extends StatefulWidget {
  /// ProfileView initialization
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController(
      text: context.read<UserCubit>().state.user?.name ?? '',
    );
    final ageTextController = TextEditingController(
      text: context.read<UserCubit>().state.user?.age ?? '',
    );
    final weightTextController = TextEditingController(
      text: context.read<UserCubit>().state.user?.weight.toString() ?? '',
    );
    final heightTextController = TextEditingController(
      text: context.read<UserCubit>().state.user?.height.toString() ?? '',
    );

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
      body: SingleChildScrollView(
        child: Column(
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
            Padding(
              padding: const ProjectPadding.symetricHorizontalNormal(),
              child: Column(
                children: [
                  EditableTextFormField(
                    prefixIcon: const Icon(Icons.person),
                    label:
                        'Rumuz - ${context.read<UserCubit>().state.user?.name ?? ''}',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Rumuzunuzu Güncelleyin'),
                              content: TextFormField(
                                controller: usernameController,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                // Diğer özellikleriniz
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Güncelle'),
                                  onPressed: () async {
                                    final currentUser =
                                        context.read<UserCubit>().getUser();
                                    final newUser = User(
                                      name: usernameController.text,
                                      surname: currentUser?.surname ?? '',
                                      email: currentUser?.email ?? '',
                                      password: currentUser?.password ?? '',
                                      generalAnlysisRegion:
                                          currentUser?.generalAnlysisRegion ??
                                              '',
                                      age: currentUser?.age ?? '',
                                      weight: currentUser?.weight ?? 0,
                                      height: currentUser?.height ?? 0,
                                    );

                                    context.read<UserCubit>().setUser(newUser);

                                    await AuthService.updateUser(newUser);

                                    setState(() {});
                                    if (context.mounted) {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const Gaps.heightMedium(),
                  EditableTextFormField(
                    prefixIcon: const Icon(Icons.calendar_today),
                    label:
                        'Yaş - ${context.read<UserCubit>().state.user?.age ?? ''}',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Yaşınızı Güncelleyin'),
                              content: TextFormField(
                                maxLength: 2,
                                controller: ageTextController,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                decoration: const InputDecoration(
                                  counterText: '',
                                ),
                                // Diğer özellikleriniz
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Güncelle'),
                                  onPressed: () async {
                                    final currentUser =
                                        context.read<UserCubit>().getUser();
                                    final newUser = User(
                                      name: currentUser?.name ?? '',
                                      surname: currentUser?.surname ?? '',
                                      email: currentUser?.email ?? '',
                                      password: currentUser?.password ?? '',
                                      generalAnlysisRegion:
                                          currentUser?.generalAnlysisRegion ??
                                              '',
                                      age: ageTextController.text,
                                      weight: currentUser?.weight ?? 0,
                                      height: currentUser?.height ?? 0,
                                    );

                                    context.read<UserCubit>().setUser(newUser);

                                    await AuthService.updateUser(newUser);

                                    setState(() {});
                                    if (context.mounted) {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const Gaps.heightMedium(),
                  EditableTextFormField(
                    prefixIcon: const Icon(Icons.fitness_center),
                    label:
                        'Ağırlık - ${context.read<UserCubit>().state.user?.weight ?? ''} kg',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Kilonuzu Güncelleyin'),
                              content: TextFormField(
                                maxLength: 3,
                                controller: weightTextController,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                decoration: const InputDecoration(
                                  counterText: '',
                                ),
                                // Diğer özellikleriniz
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Güncelle'),
                                  onPressed: () async {
                                    final currentUser =
                                        context.read<UserCubit>().getUser();
                                    final newUser = User(
                                      name: currentUser?.name ?? '',
                                      surname: currentUser?.surname ?? '',
                                      email: currentUser?.email ?? '',
                                      password: currentUser?.password ?? '',
                                      generalAnlysisRegion:
                                          currentUser?.generalAnlysisRegion ??
                                              '',
                                      age: currentUser?.age ?? '',
                                      weight:
                                          int.parse(weightTextController.text),
                                      height: currentUser?.height ?? 0,
                                    );

                                    context.read<UserCubit>().setUser(newUser);

                                    await AuthService.updateUser(newUser);

                                    setState(() {});
                                    if (context.mounted) {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const Gaps.heightMedium(),
                  EditableTextFormField(
                    prefixIcon: const Icon(Icons.height),
                    label:
                        'Boy - ${context.read<UserCubit>().state.user?.height ?? ''} cm',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Boyunuzu Güncelleyin'),
                              content: TextFormField(
                                maxLength: 3,
                                controller: heightTextController,
                                // initialValue:
                                //     context.read<UserCubit>().state.user?.age,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                decoration: const InputDecoration(
                                  counterText: '',
                                ),
                                // Diğer özellikleriniz
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Güncelle'),
                                  onPressed: () async {
                                    final currentUser =
                                        context.read<UserCubit>().getUser();
                                    final newUser = User(
                                      name: currentUser?.name ?? '',
                                      surname: currentUser?.surname ?? '',
                                      email: currentUser?.email ?? '',
                                      password: currentUser?.password ?? '',
                                      generalAnlysisRegion:
                                          currentUser?.generalAnlysisRegion ??
                                              '',
                                      age: currentUser?.age ?? '',
                                      weight: currentUser?.weight ?? 0,
                                      height:
                                          int.parse(heightTextController.text),
                                    );

                                    context.read<UserCubit>().setUser(newUser);

                                    await AuthService.updateUser(newUser);

                                    setState(() {});
                                    if (context.mounted) {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const Gaps.heightMedium(),
                  EditableTextFormField(
                    prefixIcon: const Icon(Icons.sports),
                    label:
                        'Temel Egzersiz Bölgesi - ${context.read<UserCubit>().state.user?.generalAnlysisRegion ?? ''}',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
