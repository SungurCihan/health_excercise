// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:health_excercise/product/init/theme/greys.dart';
import 'package:health_excercise/product/navigation/app_router.dart';
import 'package:health_excercise/product/widget/countdown/countdown.dart';
import 'package:health_excercise/product/widget/padding/spaces/gaps.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sensors_plus/sensors_plus.dart';

@RoutePage()
final class ExerciseView extends StatefulWidget {
  const ExerciseView({super.key});

  @override
  State<ExerciseView> createState() => _ExcerciseViewState();
}

class _ExcerciseViewState extends State<ExerciseView>
    with TickerProviderStateMixin {
  Position? _lastPosition;
  late final AnimationController _controller;
  double _totalDistance = 0;
  int levelClock = 10;
  static const double _threshold = 3.5;
  int _stepCount = 0;
  double _prevMagnitude = 0;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  bool isTimerStopped = false;

  double _calculateMagnitude(UserAccelerometerEvent event) {
    return sqrt(pow(event.x, 2) + pow(event.y, 2) + pow(event.z, 2));
  }

  void _startTracking() {
    try {
      _requestLocationPermission();

      Geolocator.getPositionStream(
        locationSettings: const LocationSettings(),
      ).listen((Position position) {
        if (_lastPosition != null) {
          setState(() {
            _totalDistance += Geolocator.distanceBetween(
              _lastPosition!.latitude,
              _lastPosition!.longitude,
              position.latitude,
              position.longitude,
            );
          });
        }
        _lastPosition = position;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _requestLocationPermission() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      status = await Permission.location.request();
      if (!status.isGranted) {
        // Kullanıcı izni reddetti, burada uygun bir işlem yapabilirsiniz.
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: levelClock,
      ),
    );

    _controller.forward();

    _startTracking();

    _streamSubscriptions.add(
      userAccelerometerEventStream().listen((event) {
        final magnitude =
            sqrt(pow(event.x, 2) + pow(event.y, 2) + pow(event.z, 2));

        if (_prevMagnitude > _threshold && magnitude < _threshold) {
          setState(() {
            _stepCount++;
          });
        }

        _prevMagnitude = magnitude;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Greys.neutral30,
      body: Center(
        child: Column(
          children: [
            Image.asset(
              'assets/images/walking_woman.png',
            ), // Assuming the image is located in the assets/images folder
            const Gaps.heightMedium(),
            Countdown(
              key: const Key('countdown'),
              animation: StepTween(
                begin: levelClock, //
                end: 0,
              ).animate(_controller),
            ),
            const Gaps.heightSmall(),
            Text('Adım Sayısı: $_stepCount'),
            Text('Toplam Mesafe: $_totalDistance'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Durdur button onPressed logic
                if (!isTimerStopped) {
                  _controller.stop();
                } else {
                  _controller.forward();
                }

                setState(() {
                  isTimerStopped = !isTimerStopped;
                });
              },
              child: Text(isTimerStopped ? 'Devam Ettir' : 'Durdur'),
            ),
            const Gaps.heightSmall(),
            Visibility(
              visible: !_controller.isCompleted,
              child: ElevatedButton(
                onPressed: () {
                  // Şimdi Sonlandır button onPressed logic
                  _controller.stop();
                },
                child: const Text('Şimdi Sonlandır'),
              ),
            ),
            Visibility(
              visible: _controller.isCompleted,
              child: ElevatedButton(
                onPressed: () {
                  // Bitir button onPressed logic
                  _controller.stop();
                  context.router.push(const SurveyAfterExcerciseRoute());
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.cyan),
                  minimumSize: MaterialStateProperty.all(const Size(155, 45)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        15,
                      ), // Köşelerin yuvarlaklığını ayarlar
                    ),
                  ),
                ),
                child: const Text(
                  'Bitir',
                  style: TextStyle(
                    color: Greys.neutral20,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
