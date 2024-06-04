import 'package:equatable/equatable.dart';

/// The home state class
final class HomeState extends Equatable {
  /// The home state constructor
  const HomeState({required this.isLoading});

  /// The loading state of the home page
  final bool isLoading;

  @override
  List<Object?> get props => [isLoading];

  /// Copy method to create a new instance of the HomeState
  HomeState copyWith({bool? isLoading}) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
