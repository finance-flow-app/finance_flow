part of 'analytics_bloc.dart';

class AnalyticsState extends Equatable {
  const AnalyticsState({this.isLoading = false});

  final bool isLoading;

  AnalyticsState copyWith({bool? isLoading}) {
    return AnalyticsState(isLoading: isLoading ?? this.isLoading);
  }

  @override
  List<Object?> get props => [isLoading];
}
