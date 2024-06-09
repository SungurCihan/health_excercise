import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_excercise/feature/exercise/view/sunny_day_view.dart';

@RoutePage()

/// Test Excercise View
class TestExcerciseView extends StatelessWidget {
  /// Test Excercise View constructor
  const TestExcerciseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20),
            const Text('Hoş Geldiniz'),
            const SizedBox(height: 20),
            const Text('Merhaba'),
            const SizedBox(height: 20),
            const Text(
              'Uygulamayı kullanmaya başlayabilmeniz için Temel Egzersiz Bölgenizin belirlenmesi gerekmektedir. Bu amaçla 6 dakikalık bir test yürüşüyüne tabi tutulacaksınız',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // Kabul et butonuna tıklanınca yapılacak işlemler
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SunnyDayView(),
                        settings: const RouteSettings(
                          arguments: 360,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text(
                    'Devam Et',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: SystemNavigator.pop,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text(
                    'Uygulamayı Kapat',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
