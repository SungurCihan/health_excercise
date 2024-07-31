import 'package:flutter/material.dart';
import 'package:health_excercise/feature/auth/model/excercise.dart';
import 'package:health_excercise/product/init/theme/greys.dart';
import 'package:health_excercise/product/service/excercise_service.dart';
import 'package:health_excercise/product/service/step_service.dart';
import 'package:health_excercise/product/widget/padding/project_padding.dart';
import 'package:health_excercise/product/widget/padding/spaces/gaps.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vertical_percent_indicator/vertical_percent_indicator.dart';

/// ActivityView
class ActivityView extends StatefulWidget {
  /// ActivityView initialization
  const ActivityView({super.key});

  @override
  State<ActivityView> createState() => _ActivityViewState();
}

class _ActivityViewState extends State<ActivityView> {
  List<int> steps = [];
  List<Excercise> theseWeek = [];
  int totalSte = 0;

  @override
  void initState() {
    super.initState();
    getSteps();
  }

  Future<void> getSteps() async {
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
    theseWeek = excercises?.where((excercise) {
          final date = excercise.excerciseDate;
          return date.isAfter(startOfWeek) &&
              date.isBefore(endOfWeek) &&
              excercise.doneExercise;
        }).toList() ??
        [];

    for (final element in theseWeek) {
      final step = await StepService.getStep(element.excerciseDate);
      setState(() {
        steps.add(step);
        totalSte += step;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Greys.neutral10,
          title: const Text(
            'Günlük Aktivite',
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
      backgroundColor: Greys.neutral10,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: Center(
              child: CircularPercentIndicator(
                radius: 100,
                percent: totalSte / 3000,
                progressColor: Colors.pinkAccent,
                backgroundColor: Greys.neutral10,
                circularStrokeCap: CircularStrokeCap.round,
                animation: true,
                animationDuration: 1000,
                lineWidth: 8,
                center: Padding(
                  padding: const ProjectPadding.allMedium(),
                  child: Container(
                    height: 160,
                    width: 160,
                    decoration: BoxDecoration(
                      color: Greys.neutral00,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Greys.neutral10,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            totalSte.toString(),
                            style: const TextStyle(fontSize: 28),
                          ),
                          const Gaps.heightSmall(),
                          Text(
                            '3 000',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // const Gaps.heightLarge(),
          // const Gaps.heightLarge(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Aktivite Geçmişi',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Detaylar',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          // const Gaps.heightMedium(),
          Expanded(
            flex: 4,
            child: Center(
              child: ListView.builder(
                shrinkWrap: true,
                // itemCount: steps.length,
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: VerticalBarIndicator(
                      // percent: steps[index] / 3000,
                      percent: 0.75,
                      width: 10,
                      animationDuration: const Duration(seconds: 1),
                      color: [
                        Colors.pinkAccent,
                        Colors.pinkAccent.withOpacity(0.9),
                      ],
                      footer: '0.2',
                      // footer:
                      //     '${theseWeek[index].excerciseDate.day.toString().padLeft(2, '0')}.${theseWeek[index].excerciseDate.month.toString().padLeft(2, '0')}',
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
