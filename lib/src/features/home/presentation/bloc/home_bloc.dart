import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<HomeInitial>(_onHomeInitial);
    on<HomeRefreshRequested>(_onHomeRefreshRequested);
  }

  void _onHomeInitial(HomeInitial event, Emitter<HomeState> emit) {
    // При необходимости можно загрузить начальные данные.
  }

  Future<void> _onHomeRefreshRequested(
    HomeRefreshRequested event,
    Emitter<HomeState> emit,
  ) async {
    try {
      // TODO: загрузка данных при обновлении (баланс, лимиты и тд).
      await Future.delayed(const Duration(milliseconds: 300));
      if (!event.completer.isCompleted) event.completer.complete();
    } catch (e, st) {
      if (!event.completer.isCompleted) event.completer.completeError(e, st);
    }
  }
}
