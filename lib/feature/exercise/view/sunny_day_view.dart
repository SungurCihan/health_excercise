import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_excercise/feature/exercise/view/exercise_view.dart';

/// Sunny Day View
@RoutePage()
class SunnyDayView extends StatelessWidget {
  /// Sunny Day View constructor
  const SunnyDayView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/sunny_day.jpeg'),
          const SizedBox(height: 20),
          const Text(
            'Güneşli bir hava tercih edin!',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'En az 600 metre uzunluğunda bir yol üzerinde egzersiz yapmak için harika bir gün!',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              final routeData = ModalRoute.of(context)!.settings.arguments;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ExerciseView(),
                  settings: RouteSettings(
                    arguments: routeData,
                  ),
                ),
              );
            },
            child: const Text('Hazırsanız Başlayın'),
          ),
        ],
      ),
    );
  }
}
