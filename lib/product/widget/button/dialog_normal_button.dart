import 'package:flutter/material.dart';
import 'package:health_excercise/product/widget/button/normal_button.dart';
import 'package:widgets/widgets.dart';

/// DialogNormalButton
class DialogNormalButton extends StatelessWidget {
  /// DialogNormalButton
  const DialogNormalButton({required this.onComplete, super.key});

  /// onComplete
  final ValueChanged<bool> onComplete;
  @override
  Widget build(BuildContext context) {
    return NormalButton(
      title: 'Dialog Normal Button',
      onPressed: () async {
        final response =
            await SuccessDialog.show(title: 'title', context: context);
        onComplete.call(response);
      },
    );
  }
}
