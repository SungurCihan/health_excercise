import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_excercise/feature/auth/model/excercise.dart';
import 'package:health_excercise/feature/exercise/view/sunny_day_view.dart';
import 'package:health_excercise/product/init/cache/shared_manager.dart';
import 'package:health_excercise/product/init/theme/greys.dart';
import 'package:health_excercise/product/navigation/app_router.dart';
import 'package:health_excercise/product/service/excercise_service.dart';
import 'package:health_excercise/product/service/step_service.dart';
import 'package:health_excercise/product/widget/padding/spaces/gaps.dart';

/// Home view
@RoutePage()
final class HomeView extends StatefulWidget {
  /// Home view constructor
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  DateTime nearestExcercise = DateTime.now();
  int nearestExcerciseId = 0;
  int stepCount = 0;
  double burnedCalories = 0;
  int hours = 0;
  int minutes = 0;
  String formattedHour = '';
  String formattedMinute = '';

  @override
  void initState() {
    super.initState();
    controlExcercises();
  }

  Future<void> controlExcercises() async {
    try {
      // Kullanıcının egzerzisleri getiriliyor.
      final excercises = await ExcerciseService.getExcercise();
      // Egzerzisler tarihe göre sıralanıyor.
      excercises?.sort(
        (a, b) => a.excerciseDate.compareTo(b.excerciseDate),
      );

      // Mevcut tarih
      final now = DateTime.now();
      // Haftanın ilk günü (Pazartesi varsayılarak)
      final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
      // Haftanın son günü (Pazar varsayılarak)
      final endOfWeek = startOfWeek.add(const Duration(days: 6));

      // Egzerzisler tarihe göre sıralanıyor ve mevcut haftada olanlar filtreleniyor.
      final thisWeekExcercises = excercises?.where((excercise) {
        final date = excercise.excerciseDate;
        return date.isAfter(startOfWeek) &&
            date.isBefore(endOfWeek) &&
            excercise.doneExercise;
      }).toList();

      // Hafta içinde yapılan egzersizlerin kalori değerleri toplanıyor.
      for (final element in thisWeekExcercises ?? []) {
        final excercise = element as Excercise;
        burnedCalories += double.tryParse(excercise.calories) ?? 0.0;
        stepCount += await StepService.getStep(excercise.excerciseDate);
      }

      // Hafta içinde yapılan egzersizlerin süreleri toplanıyor.
      final excerciseTime = (thisWeekExcercises?.length ?? 0) * 30;
      hours = excerciseTime ~/ 60; // Saat değeri
      minutes = excerciseTime % 60; // Dakika değeri

      formattedHour = hours != 0 ? '$hours saat ' : '';
      formattedMinute = minutes != 0 ? '$minutes dakika' : '';

      if (formattedHour == '' && formattedMinute == '') {
        formattedHour = '-';
      }

      // Eğer kullanıcının bu hafta egzersiz yapmadığı günler varsa, bu günler için egzersiz oluşturuluyor.
      if ((excercises != null && excercises.isEmpty) ||
          (excercises != null && excercises.last.doneExercise)) {
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

      if (excercises != null) {
        for (final element in excercises) {
          if (!element.doneExercise &&
              element.excerciseDate.isAfter(DateTime.now())) {
            setState(() {
              nearestExcercise = element.excerciseDate;
              nearestExcerciseId = element.id;
            });
            break;
          }
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bir şeyler ters gitti'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Greys.neutral10,
        title: const Text('Anasayfa'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await SharedManager.removeToken();
          if (context.mounted) {
            await context.pushRoute(const LoginRoute());
          }
          // await ExcerciseService.getExcercise();
          // final step = await StepService.getStep(
          //   DateTime.parse('2024-07-05T19:51:08.409+00:00'),
          // );
          // if (step != -1) {
          //   print(step);
          // }
        },
        child: const Icon(Icons.logout),
      ),
      backgroundColor: Greys.neutral10,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            _topHalf(),
            Expanded(
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Sonraki Egzersiz',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Gaps.heightLarge(),
                  _nextExcercise(context),
                  const Gaps.heightMedium(),
                  const Text(
                    'Unutma, istikrar her şeydir. Sen çok daha fazlazısın. Her gün ileriye doğru bir adım daha at. Hayallerin çok uzakta değil.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Gaps.heightMedium(),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Bir Sonraki Egzersiz',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '${getDayName(nearestExcercise.weekday)}, ${nearestExcercise.day} ${getMonthName(nearestExcercise.month)} ${nearestExcercise.year}',
                      // 'Pazartesi, 10 Haziran 2024, 18.30',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffE32685),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _nextExcercise(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            children: [
              const Text(
                'Zinde Kalmak İçin Hareketi Bırakma!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Gaps.heightSmall(),
              GestureDetector(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SunnyDayView(),
                      settings: RouteSettings(
                        arguments: [nearestExcerciseId, 1800],
                      ),
                    ),
                  );
                },
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffF2E8ED),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(
                        top: 5,
                        left: 20,
                        bottom: 5,
                        right: 20,
                      ),
                      child: Text(
                        'Egzersizi Başlat',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Gaps.widthSmall(),
        Expanded(
          flex: 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10), // Köşeleri yuvarlar
            child: Image.asset('assets/images/yoga.jpeg'),
          ),
        ),
      ],
    );
  }

  Expanded _topHalf() {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Atılan Adım Sayısı',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '$stepCount/3.000',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Gaps.heightSmall(),
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ), // Kenarları yuvarlar
            child: SizedBox(
              height: 7, // Kalınlığı artırır
              child: LinearProgressIndicator(
                value: stepCount / 3000,
                backgroundColor:
                    const Color(0xffE5D1DB), // Boş hali E5D1DB renginde
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xffE32685),
                ), // Dolu hali E32685 renginde
              ),
            ),
          ),
          const Gaps.heightLarge(),
          Row(
            children: [
              Expanded(
                flex: 10,
                child: _infoCard(
                  title: 'Adım Sayısı',
                  value: stepCount.toString(),
                ),
              ),
              const Expanded(
                child: SizedBox(
                  height: 150,
                ),
              ),
              Expanded(
                flex: 10,
                child: _infoCard(
                  title: 'Yakılan Kalori',
                  value: burnedCalories.toStringAsFixed(2),
                ),
              ),
            ],
          ),
          _infoCard(
            title: 'Toplam Egzersiz Süresi',
            value: '$formattedHour$formattedMinute',
          ),
        ],
      ),
    );
  }

  Container _infoCard({
    required String title,
    required String value,
  }) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: const Color(0xffF2E8ED),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Expanded(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Metinleri yükseklik olarak ortalar
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                bottom: 10,
              ), // Soldan ve alttan boşluk bırakır
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
              ), // Soldan boşluk bırakır
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
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

  String getDayName(int weekDay) {
    switch (weekDay) {
      case 1:
        return 'Pazartesi';
      case 2:
        return 'Salı';
      case 3:
        return 'Çarşamba';
      case 4:
        return 'Perşembe';
      case 5:
        return 'Cuma';
      case 6:
        return 'Cumartesi';
      case 7:
        return 'Pazar';
      default:
        return '';
    }
  }

  String getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Ocak';
      case 2:
        return 'Şubat';
      case 3:
        return 'Mart';
      case 4:
        return 'Nisan';
      case 5:
        return 'Mayıs';
      case 6:
        return 'Haziran';
      case 7:
        return 'Temmuz';
      case 8:
        return 'Ağustos';
      case 9:
        return 'Eylül';
      case 10:
        return 'Ekim';
      case 11:
        return 'Kasım';
      case 12:
        return 'Aralık';
      default:
        return '';
    }
  }
}
