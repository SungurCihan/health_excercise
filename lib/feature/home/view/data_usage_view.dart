import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_excercise/product/init/cache/shared_manager.dart';
import 'package:health_excercise/product/navigation/app_router.dart';

/// DataUsage
@RoutePage()
class DataUsageView extends StatelessWidget {
  /// DataUsage constructor
  const DataUsageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Bu uygulama meme kanseri sonrası bireylerin kanıta dayalı yönergelere uygun olarak fiziksel aktivitelerini geliştirmeleri amacıyla oluşturulmuştur. Uygulama aynı zamanda bir araştırmanın parçasıdır. Hem araştırma hem de uygulamanın iyileştirilmesi için kullanım verilerinizi takip etmemiz ve bunu yapmak için sizin onayınıza ihtiyacımız var. ',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // Kabul et butonuna tıklanınca yapılacak işlemler
                    await SharedManager.setDataUsage(answer: true);
                    if (context.mounted) {
                      await context.pushRoute(BottomNavigationBarRoute());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text(
                    'Kabul Et',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Reddet butonuna tıklanınca yapılacak işlemler
                    SharedManager.setDataUsage(answer: false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text(
                    'Reddet',
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
