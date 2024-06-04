import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_excercise/product/init/theme/greys.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  backgroundColor: MaterialStateProperty.all(
                    Colors.green,
                  ), // Butonun rengini kırmızı yapar
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        30,
                      ), // Butonun kenarlarını yarım daire yapar
                    ),
                  ),
                ),
                child: const Text(
                  'Tamamla',
                  style: TextStyle(color: Greys.neutral00),
                ),
              ),
            ],
          ),
        ],
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
}
