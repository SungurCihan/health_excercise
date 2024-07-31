// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:health_excercise/feature/bottom_navigation_bar/view/bottom_navigation_bar_view.dart';
import 'package:health_excercise/feature/exercise/view/survey_after_excercise_view.dart';
import 'package:health_excercise/product/init/theme/greys.dart';
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
  int levelClock = 600;
  static const double _threshold = 3;
  int _stepCount = 0;
  double _prevMagnitude = 0;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  StreamSubscription<Position>? _positionStreamSubscription;

  double? _speed;

  bool isTimerStopped = false;
  bool isAnimationOkay = false;
  bool isTest = false;

  // double _calculateMagnitude(UserAccelerometerEvent event) {
  //   return sqrt(pow(event.x, 2) + pow(event.y, 2) + pow(event.z, 2));
  // }

  void _startTracking() {
    try {
      _requestLocationPermission();

      _positionStreamSubscription = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(),
      ).listen((Position position) {
        setState(() {
          _speed = position.speed;
        });
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

  Future<void> _stopTracking() async {
    await _positionStreamSubscription?.cancel();
  }

  void _resumeTracking() {
    _startTracking();
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

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final routeData = ModalRoute.of(context)!.settings.arguments as List?;

        if (routeData != null) {
          routeData[1] == 360 ? isTest = true : isTest = false;

          levelClock = routeData[1] as int;
        } else {
          levelClock = 600;
        }

        _controller = AnimationController(
          vsync: this,
          duration: Duration(
            seconds: levelClock,
          ),
        );

        _controller.forward();
        setState(() {
          isAnimationOkay = true;
        });

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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Greys.neutral30,
        body: isAnimationOkay
            ? Center(
                child: Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Image.asset(
                        'assets/images/walking_woman.png',
                      ),
                    ), // Assuming the image is located in the assets/images folder
                    const Gaps.heightMedium(),
                    Expanded(
                      flex: 2,
                      child: Countdown(
                        key: const Key('countdown'),
                        animation: StepTween(
                          begin: levelClock, //
                          end: 0,
                        ).animate(_controller),
                      ),
                    ),
                    const Gaps.heightSmall(),
                    Text('Adım Sayısı: $_stepCount'),
                    Text(
                      'Toplam Mesafe: ${_totalDistance.toStringAsFixed(2)} metre',
                    ),
                    // Text(
                    //   _speed != null
                    //       ? '${(_speed! * 3.6).toStringAsFixed(2)} metre/saniye'
                    //       : 'Hız ölçülüyor...',
                    // ),
                    // const SizedBox(height: 20),
                    if (!isTest)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            // Durdur button onPressed logic
                            if (!isTimerStopped) {
                              _controller.stop();
                              await _stopTracking();
                            } else {
                              _controller.forward();
                              _resumeTracking();
                            }

                            setState(() {
                              isTimerStopped = !isTimerStopped;
                            });
                          },
                          child:
                              Text(isTimerStopped ? 'Devam Ettir' : 'Durdur'),
                        ),
                      ),
                    const Gaps.heightSmall(),
                    if (!isTest)
                      Visibility(
                        visible: !_controller.isCompleted,
                        child: ElevatedButton(
                          onPressed: () async {
                            // Şimdi Sonlandır button onPressed logic
                            _controller.stop();
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BottomNavigationBarView(),
                              ),
                            );
                          },
                          child: const Text('Şimdi Sonlandır'),
                        ),
                      ),
                    Visibility(
                      visible: _controller.isCompleted,
                      child: ElevatedButton(
                        onPressed: () async {
                          // Bitir button onPressed logic
                          _controller.stop();
                          final routeData = ModalRoute.of(context)!
                              .settings
                              .arguments as List?;
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SurveyAfterExcerciseView(),
                              settings: RouteSettings(
                                arguments: [routeData?[0], _stepCount],
                              ),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(Colors.cyan),
                          minimumSize:
                              WidgetStateProperty.all(const Size(155, 45)),
                          shape: WidgetStateProperty.all(
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
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
