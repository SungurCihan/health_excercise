import 'package:flutter/material.dart';

/// A countdown timer widget that displays the remaining time.
class Countdown extends AnimatedWidget {
  /// Creates a countdown timer widget.
  const Countdown({required this.animation, required Key key})
      : super(key: key, listenable: animation);

  /// The animation that controls the state of the countdown timer.
  final Animation<int> animation;

  @override
  Text build(BuildContext context) {
    final clockTimer = Duration(seconds: animation.value);

    final timerText =
        '${clockTimer.inMinutes.remainder(60)}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    return Text(
      timerText,
      style: const TextStyle(
        fontSize: 110,
        // color: Theme.of(context).primaryColor,
      ),
    );
  }
}
