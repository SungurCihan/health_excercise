import 'dart:math';

import 'package:flutter/material.dart';
import 'package:health_excercise/product/init/theme/greys.dart';
import 'package:health_excercise/product/widget/padding/project_padding.dart';
import 'package:health_excercise/product/widget/padding/spaces/gaps.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vertical_percent_indicator/vertical_percent_indicator.dart';

/// ActivityView
class ActivityView extends StatelessWidget {
  /// ActivityView initialization
  const ActivityView({super.key});

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
          Center(
            child: CircularPercentIndicator(
              radius: 100,
              percent: 0.75,
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
                        const Text(
                          '7 567',
                          style: TextStyle(fontSize: 28),
                        ),
                        const Gaps.heightSmall(),
                        Text(
                          '10 000',
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
          const Gaps.heightLarge(),
          const Gaps.heightLarge(),
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
          const Gaps.heightMedium(),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.2,
            child: Center(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 7,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: VerticalBarIndicator(
                      percent: Random().nextDouble(),
                      width: 10,
                      animationDuration: const Duration(seconds: 1),
                      color: [
                        Colors.pinkAccent,
                        Colors.pinkAccent.withOpacity(0.9),
                      ],
                      footer: '${DateTime.now().day - (6 - index)}.04',
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
