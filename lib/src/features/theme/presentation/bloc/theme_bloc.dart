import 'package:finance_flow/src/features/theme/domain/repository/theme_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc(this._repository)
    : super(ThemeState(themeMode: _repository.getThemeModeSync())) {
    on<ThemeInitial>(_onInitial);
    on<ThemeChanged>(_onChanged);
  }

  final ThemeRepository _repository;

  Future<void> _onInitial(ThemeInitial event, Emitter<ThemeState> emit) async {
    final mode = await _repository.getThemeMode();
    if (mode != state.themeMode) emit(state.copyWith(themeMode: mode));
  }

  Future<void> _onChanged(ThemeChanged event, Emitter<ThemeState> emit) async {
    await _repository.setThemeMode(event.themeMode);
    emit(state.copyWith(themeMode: event.themeMode));
  }
}
