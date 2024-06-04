import 'package:flutter/material.dart';

/// General Gaps
final class Gaps extends SizedBox {
  /// Height Gaps

  /// [Gaps.heightSmall] is 8
  const Gaps.heightSmall({super.key}) : super(height: 8);

  /// [Gaps.heightMedium] is 16
  const Gaps.heightMedium({super.key}) : super(height: 16);

  /// [Gaps.heightNormal] is 20
  const Gaps.heightNormal({super.key}) : super(height: 20);

  /// [Gaps.heightLarge] is 32
  const Gaps.heightLarge({super.key}) : super(height: 32);

  /// Width Gaps

  /// [Gaps.widthSmall] is 8
  const Gaps.widthSmall({super.key}) : super(width: 8);

  /// [Gaps.widthMedium] is 16
  const Gaps.widthMedium({super.key}) : super(width: 16);

  /// [Gaps.widthNormal] is 20
  const Gaps.widthNormal({super.key}) : super(width: 20);

  /// [Gaps.widthLarge] is 32
  const Gaps.widthLarge({super.key}) : super(width: 32);
}
