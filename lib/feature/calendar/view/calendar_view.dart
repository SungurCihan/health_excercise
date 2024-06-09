import 'package:flutter/material.dart';
import 'package:health_excercise/product/init/theme/greys.dart';
import 'package:health_excercise/product/widget/padding/spaces/gaps.dart';
import 'package:table_calendar/table_calendar.dart';

/// CalendarView
class CalendarView extends StatelessWidget {
  /// CalendarView initialization
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedDays = <DateTime>[
      DateTime.now().add(const Duration(days: 4)),
      DateTime.now().add(const Duration(days: 7)),
      DateTime.now().add(const Duration(days: 10)),
    ];
    return Scaffold(
      backgroundColor: Greys.neutral10,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Greys.neutral10,
          title: const Text(
            'Egzersiz Takvimi',
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
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
              selectedDayPredicate: (day) {
                return selectedDays.any(
                  (selectedDay) =>
                      selectedDay.year == day.year &&
                      selectedDay.month == day.month &&
                      selectedDay.day == day.day,
                );
              },
            ),
          ),
          const Gaps.heightNormal(),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.06,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: const Center(
              child: Row(
                children: [
                  Gaps.widthSmall(),
                  Text('Egzersiz, Adımsayar'),
                ],
              ),
            ),
          ),
          const Gaps.heightSmall(),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.06,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: const Center(
              child: Row(
                children: [
                  Gaps.widthSmall(),
                  Text('Fiziksel Aktivite Günü'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
