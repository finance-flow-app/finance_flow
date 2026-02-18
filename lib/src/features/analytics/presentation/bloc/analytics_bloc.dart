import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'analytics_event.dart';
part 'analytics_state.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  AnalyticsBloc() : super(const AnalyticsState()) {
    on<AnalyticsInitial>(_onAnalyticsInitial);
    on<AnalyticsRefreshRequested>(_onAnalyticsRefreshRequested);
  }
  void _onAnalyticsInitial(
    AnalyticsInitial event,
    Emitter<AnalyticsState> emit,
  ) {}

  Future<void> _onAnalyticsRefreshRequested(
    AnalyticsRefreshRequested event,
    Emitter<AnalyticsState> emit,
  ) async {
    // если bloc уже закрыт — лучше вообще ничего не делать
    if (isClosed) {
      if (!event.completer.isCompleted) event.completer.complete();
      return;
    }

    emit(state.copyWith(isLoading: true));

    try {
      // TODO: загрузка данных при обновлении (аналитика).
      await Future.delayed(const Duration(milliseconds: 300));

      // успех
      if (!event.completer.isCompleted) {
        event.completer.complete();
      }
    } catch (e, st) {
      // ошибка
      if (!event.completer.isCompleted) {
        event.completer.completeError(e, st);
      }
    } finally {
      if (!isClosed) {
        emit(state.copyWith(isLoading: false));
      }
    }
  }
}
