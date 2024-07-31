import 'package:flutter/material.dart';
import 'package:health_excercise/feature/auth/model/excercise.dart';
import 'package:health_excercise/product/init/theme/greys.dart';
import 'package:health_excercise/product/service/excercise_service.dart';
import 'package:health_excercise/product/widget/padding/spaces/gaps.dart';
import 'package:table_calendar/table_calendar.dart';

/// CalendarView
class CalendarView extends StatefulWidget {
  /// CalendarView initialization
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  final excercises = <Excercise>[];

  @override
  void initState() {
    super.initState();
    getExcerciseDays();
  }

  Future<void> getExcerciseDays() async {
    excercises.clear();
    final today = DateTime.now();
    final justToday = DateTime(today.year, today.month, today.day);
    final excercicesFromService = await ExcerciseService.getExcercise();
    if (excercicesFromService != null) {
      for (final excercise in excercicesFromService) {
        final justDate = DateTime(
          excercise.excerciseDate.year,
          excercise.excerciseDate.month,
          excercise.excerciseDate.day,
        );
        if (!excercise.doneExercise && justDate.isAfter(justToday)) {
          setState(() {
            excercises.add(excercise);
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
              availableCalendarFormats: const {
                CalendarFormat.month: 'Month',
              },
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
              locale: 'tr_TR',
              calendarStyle: const CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Colors.pink,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
              onDaySelected: (selectedDay, focusedDay) async {
                for (final element in excercises) {
                  if (element.excerciseDate.year == selectedDay.year &&
                      element.excerciseDate.month == selectedDay.month &&
                      element.excerciseDate.day == selectedDay.day) {
                    final pickedDate = await showDatePicker(
                      context: context,
                      locale: const Locale('tr', 'TR'),
                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                      initialDate:
                          selectedDay, // İlk seçim için mevcut seçili gün
                      firstDate: DateTime(2000), // Seçilebilecek en eski tarih
                      lastDate: DateTime(2025), // Seçilebilecek en yeni tarih
                    );

                    if (pickedDate != null) {
                      final result = await ExcerciseService.updateExcerciseDate(
                        element.id,
                        pickedDate,
                      );

                      if (result && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Güncelleme işlemi başarılı.'),
                            duration: Duration(seconds: 2),
                          ),
                        );

                        await getExcerciseDays();
                      } else if (!result && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Güncelleme işlemi başarısız.'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    }
                  }
                }
              },
              selectedDayPredicate: (day) {
                return excercises.any(
                  (selectedDay) =>
                      selectedDay.excerciseDate.year == day.year &&
                      selectedDay.excerciseDate.month == day.month &&
                      selectedDay.excerciseDate.day == day.day,
                );
              },
            ),
          ),
          const Gaps.heightNormal(),
          const Text('Yeşil -> Bugün', style: TextStyle(color: Colors.green)),
          const Text(
            'Pembe -> Egzersiz Günü',
            style: TextStyle(color: Colors.pink),
          ),
          const Text(
            '*Egzersiz gününü değiştirmek için ilgili güne basınız.',
            style: TextStyle(color: Colors.red),
          ),
          // Container(
          //   width: MediaQuery.of(context).size.width * 0.9,
          //   height: MediaQuery.of(context).size.height * 0.06,
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(10),
          //     border: Border.all(
          //       color: Colors.grey,
          //     ),
          //   ),
          //   child: const Center(
          //     child: Row(
          //       children: [
          //         Gaps.widthSmall(),
          //         Text('Egzersiz, Adımsayar'),
          //       ],
          //     ),
          //   ),
          // ),
          // const Gaps.heightSmall(),
          // Container(
          //   width: MediaQuery.of(context).size.width * 0.9,
          //   height: MediaQuery.of(context).size.height * 0.06,
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(10),
          //     border: Border.all(
          //       color: Colors.grey,
          //     ),
          //   ),
          //   child: const Center(
          //     child: Row(
          //       children: [
          //         Gaps.widthSmall(),
          //         Text('Fiziksel Aktivite Günü'),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
