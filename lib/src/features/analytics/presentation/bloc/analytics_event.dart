part of 'analytics_bloc.dart';

abstract class AnalyticsEvent {}

class AnalyticsInitial extends AnalyticsEvent {}

class AnalyticsRefreshRequested extends AnalyticsEvent {
  AnalyticsRefreshRequested(this.completer);

  final Completer<void> completer;
}
