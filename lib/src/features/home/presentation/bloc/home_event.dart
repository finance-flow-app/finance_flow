part of 'home_bloc.dart';

abstract class HomeEvent {}

class HomeInitial extends HomeEvent {}

class HomeRefreshRequested extends HomeEvent {
  HomeRefreshRequested(this.completer);

  final Completer<void> completer;
}
