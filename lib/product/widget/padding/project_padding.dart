import 'package:flutter/material.dart';

/// Project general padding items
final class ProjectPadding extends EdgeInsets {
  /// All Padding
  ///

  /// [ProjectPadding.allSmall] is 8
  const ProjectPadding.allSmall() : super.all(8);

  /// [ProjectPadding.allMedium] is 16
  const ProjectPadding.allMedium() : super.all(16);

  /// [ProjectPadding.allNormal] is 20
  const ProjectPadding.allNormal() : super.all(20);

  /// [ProjectPadding.allLarge] is 32
  const ProjectPadding.allLarge() : super.all(32);

  /// Symetric Vertical
  /// [ProjectPadding.symetricVerticalSmall] is 8
  const ProjectPadding.symetricVerticalSmall() : super.symmetric(vertical: 8);

  /// [ProjectPadding.symetricVerticalMedium] is 16
  const ProjectPadding.symetricVerticalMedium() : super.symmetric(vertical: 16);

  /// [ProjectPadding.symetricVerticalNormal] is 20
  const ProjectPadding.symetricVerticalNormal() : super.symmetric(vertical: 20);

  /// [ProjectPadding.symetricVerticalLarge] is 32
  const ProjectPadding.symetricVerticalLarge() : super.symmetric(vertical: 32);

  /// Symetric Vertical
  /// [ProjectPadding.symetricHorizontalSmall] is 8
  const ProjectPadding.symetricHorizontalSmall()
      : super.symmetric(horizontal: 8);

  /// [ProjectPadding.symetricHorizontalMedium] is 16
  const ProjectPadding.symetricHorizontalMedium()
      : super.symmetric(horizontal: 16);

  /// [ProjectPadding.symetricHorizontalNormal] is 20
  const ProjectPadding.symetricHorizontalNormal()
      : super.symmetric(horizontal: 20);

  /// [ProjectPadding.symetricHorizontalLarge] is 32
  const ProjectPadding.symetricHorizontalLarge()
      : super.symmetric(horizontal: 32);

  /// Only left,right,bottom
}
