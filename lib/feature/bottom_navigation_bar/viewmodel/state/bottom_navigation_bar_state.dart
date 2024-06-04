import 'package:equatable/equatable.dart';

/// BottomNavigationBarState
final class BottomNavigationBarState extends Equatable {
  /// BottomNavigationBarState constructor
  const BottomNavigationBarState({required this.currentPage});

  /// Current page
  final int currentPage;

  @override
  List<Object?> get props => [currentPage];

  /// Copy with
  BottomNavigationBarState copyWith({
    int? currentPage,
  }) {
    return BottomNavigationBarState(
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
