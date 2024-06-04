/// Radius Constant
enum ProjectRadius {
  /// 8.
  small(8),

  /// 16.
  medium(16),

  /// 20.
  normal(20),

  /// 32.
  large(32);

  const ProjectRadius(this.value);

  /// value.
  final double value;
}
