import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_excercise/feature/auth/model/user.dart';
import 'package:health_excercise/feature/bottom_navigation_bar/view/bottom_navigation_bar_view.dart';
import 'package:health_excercise/feature/exercise/view/sunny_day_view.dart';
import 'package:health_excercise/feature/home/view/home_view.dart';
import 'package:health_excercise/product/init/theme/greys.dart';
import 'package:health_excercise/product/service/auth_service.dart';
import 'package:health_excercise/product/service/excercise_service.dart';
import 'package:health_excercise/product/service/step_service.dart';
import 'package:health_excercise/product/widget/padding/spaces/gaps.dart';

/// SurveyAfterExcercise
@RoutePage()
final class SurveyAfterExcerciseView extends StatefulWidget {
  /// SurveyAfterExcercise
  const SurveyAfterExcerciseView({super.key});

  @override
  State<SurveyAfterExcerciseView> createState() =>
      _SurveyAfterExcerciseViewState();
}

class _SurveyAfterExcerciseViewState extends State<SurveyAfterExcerciseView> {
  int selectedValue = -1;

  List<String> surveyResponses = [
    'Hiç Yorulmadım',
    'Biraz Yoruldum',
    'Yoruldum',
    'Gerçekten Yoruldum',
    'Çok Yoruldum',
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Greys.neutral20,
        appBar: AppBar(
          backgroundColor: Greys.neutral20,
          title: const Text('Egzersiz Değerlendirmesi'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Egzersiz sonrası nasıl hissediyorsunuz?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _option(
                  context,
                  'Hiç Yorulmadım',
                  0,
                ),
                const Gaps.heightNormal(),
                _option(
                  context,
                  'Biraz Yoruldum',
                  1,
                ),
                _subText(context, '*Nefes Almak Kolay Geldi'),
                const Gaps.heightNormal(),
                _option(
                  context,
                  'Yoruldum',
                  2,
                ),
                _subText(context, '*Hala Konuşabiliyorum'),
                const Gaps.heightNormal(),
                _option(
                  context,
                  'Gerçekten Yoruldum',
                  3,
                ),
                _subText(context, '*Nefes Nefese Kaldım'),
                const Gaps.heightNormal(),
                _option(
                  context,
                  'Çok Yoruldum',
                  4,
                ),
                _subText(context, '*Durmak Zorunda Kaldım'),
                const Gaps.heightNormal(),
                ElevatedButton(
                  onPressed: () {
                    // Butona tıklandığında yapılacak işlemler
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      Colors.green,
                    ), // Butonun rengini kırmızı yapar
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          30,
                        ), // Butonun kenarlarını yarım daire yapar
                      ),
                    ),
                  ),
                  child: TextButton(
                    child: const Text(
                      'Tamamla',
                      style: TextStyle(color: Greys.neutral00),
                    ),
                    onPressed: () async {
                      final routeData =
                          ModalRoute.of(context)!.settings.arguments as List?;

                      if (routeData?[0] == -1 && selectedValue > 1) {
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Uyarı'),
                              content: const Text(
                                'Test Egzerzisi sizin için olağan seviyenin üstünde efor gerektirdi. Uygulamayı kullanmaya devam edebilmeniz için test aşamasını yorulmadan geçmeniz beklenmektedir.',
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Tamam'),
                                  onPressed: () async {
                                    Navigator.of(context)
                                        .pop(); // Dialog'u kapat
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SunnyDayView(),
                                        settings: const RouteSettings(
                                          arguments: [-1, 360],
                                        ),
                                      ),
                                    );
                                    return;
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }

                      if (routeData?[0] == -1 &&
                          selectedValue >= -1 &&
                          selectedValue < 2) {
                        final currentUser = await AuthService.getUser();
                        if (currentUser != null) {
                          final generalAnlysisRegion = selectedValue + 1;
                          final newUser = User(
                            name: currentUser.name,
                            surname: currentUser.surname,
                            email: currentUser.email,
                            generalAnlysisRegion:
                                generalAnlysisRegion.toString(),
                            age: currentUser.age,
                            weight: currentUser.weight,
                            height: currentUser.height,
                          );

                          await AuthService.updateUser(newUser);

                          if (context.mounted) {
                            await Navigator.push(
                              context,
                              MaterialPageRoute<HomeView>(
                                builder: (context) => BottomNavigationBarView(),
                              ),
                            );
                          }
                        }
                      }

                      // Kullanıcının egzerzisleri getiriliyor.
                      final excercises = await ExcerciseService.getExcercise();

                      final date = excercises
                          ?.where(
                            (element) => element.id == routeData?[0],
                          )
                          .first
                          .excerciseDate;

                      final result = await StepService.saveStep(
                        routeData?[0] as int,
                        routeData?[1] as int,
                        date ?? DateTime.now(),
                      );

                      final calories =
                          _calculateCalories(routeData?[1] as int).toString();

                      final resultCalory =
                          await ExcerciseService.updateExcerciseCalory(
                        routeData?[0] as int,
                        calories,
                        date ?? DateTime.now(),
                        surveyResponses[selectedValue],
                      );

                      // final resultIsDone =
                      //     await ExcerciseService.updateExcerciseIsDone(
                      //   routeData?[0] as int,
                      //   true,
                      // );

                      if (result && resultCalory && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Egzersiz Kaydedildi.'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (!result && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Egzersiz Kaydedilemedi.'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }

                      // Egzerzisler tarihe göre sıralanıyor.
                      excercises?.sort(
                        (a, b) => a.excerciseDate.compareTo(b.excerciseDate),
                      );

                      if (excercises != null && excercises.last.doneExercise) {
                        final assignments = assignJobs(3);
                        final today = DateTime.now();
                        for (final element in assignments) {
                          final index = getIndexOfWeek(element) + 1;
                          if (index > today.weekday) {
                            await ExcerciseService.saveExcercise(
                              today.add(Duration(days: index - today.weekday)),
                            );
                          }
                        }
                      }

                      if (context.mounted) {
                        await Navigator.push(
                          context,
                          MaterialPageRoute<HomeView>(
                            builder: (context) => BottomNavigationBarView(),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Align _subText(BuildContext context, String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.12,
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  GestureDetector _option(BuildContext context, String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedValue = index;
        });
      },
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.05,
          decoration: BoxDecoration(
            color: selectedValue == index ? Colors.purple : Greys.neutral10,
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: selectedValue == index
                        ? Greys.neutral00
                        : Greys.neutral30,
                    shape: BoxShape.circle,
                  ),
                ),
                const Gaps.widthMedium(),
                Text(
                  text,
                  style: TextStyle(
                    color:
                        selectedValue == index ? Greys.neutral00 : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<String> assignJobs(int days) {
    final week = <String>[
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    final assignments = <String>[];

    while (assignments.length < days) {
      final day = week[Random().nextInt(week.length)];

      if (assignments.contains(day)) {
        continue;
      }

      final dayIndex = week.indexOf(day);
      final prevDay = dayIndex > 0 ? week[dayIndex - 1] : null;
      final nextDay = dayIndex < week.length - 1 ? week[dayIndex + 1] : null;

      if (days == 3) {
        if (assignments.contains(prevDay) ||
            (nextDay != null && assignments.contains(nextDay))) {
          continue;
        }
      }

      assignments.add(day);
    }

    return assignments;
  }

  int getIndexOfWeek(String weekDay) {
    final week = <String>[
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    return week.indexOf(weekDay);
  }

  double _calculateCalories(int steps) {
    // Ortalama bir adım başına kalori değeri
    const caloriesPerStep = 0.04;
    return steps * caloriesPerStep;
  }
}
