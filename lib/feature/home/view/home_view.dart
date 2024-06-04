import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_excercise/product/init/theme/greys.dart';
import 'package:health_excercise/product/service/excercise_service.dart';
import 'package:health_excercise/product/widget/padding/spaces/gaps.dart';

/// Home view
@RoutePage()
final class HomeView extends StatelessWidget {
  /// Home view constructor
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Greys.neutral10,
        title: const Text('Anasayfa'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: ExcerciseService.getCourierCoords,
        child: Icon(Icons.add),
      ),
      backgroundColor: Greys.neutral10,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
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
                  _nextExcercise(),
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
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Pazartesi, 10 Haziran 2024, 18.30',
                      style: TextStyle(
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

  Row _nextExcercise() {
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
              Align(
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Atılan Adım Sayısı',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '7.469/10.000',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Gaps.heightSmall(),
          const ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ), // Kenarları yuvarlar
            child: SizedBox(
              height: 7, // Kalınlığı artırır
              child: LinearProgressIndicator(
                value: 0.7,
                backgroundColor: Color(0xffE5D1DB), // Boş hali E5D1DB renginde
                valueColor: AlwaysStoppedAnimation<Color>(
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
                  value: '7.469',
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
                  value: '1.234',
                ),
              ),
            ],
          ),
          _infoCard(
            title: 'Toplam Egzersiz Süresi',
            value: '12 saat 34 dakika',
          ),
        ],
      ),
    );
  }

  Container _infoCard({required String title, required String value}) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: const Color(0xffF2E8ED),
        borderRadius: BorderRadius.circular(10),
      ),
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
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
