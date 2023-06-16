import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../theme/theme.dart';

part 'vps_event.dart';
part 'vps_state.dart';

class VpsBloc extends Bloc<VpsEvent, VpsState> {
  VpsBloc() : super(VpsState.initialState()) {
    on<UpdateRam>(_updateRam);
    on<UpdateDisco>(_updateDisco);
    on<UpdateCPU>(_updateCPU);
    on<UpdateMeses>(_updateMeses);
    on<ChangeTheme>(_changeTheme);
    on<ResetTotal>(_resetTotal);
  }

  FutureOr<void> _updateRam(UpdateRam event, Emitter<VpsState> emit) {
    final total = (state.cpu * (730.56 * state.valueMeses) * 0.04) +
        (state.discoDuro * (730.56 * state.valueMeses) * 0.01) +
        ((event.value ~/ 512) * (730.56 * state.valueMeses) * 0.025);
    emit(state.copyWith(
        total: double.parse(total.toStringAsFixed(2)), ram: event.value));
  }

  FutureOr<void> _updateCPU(UpdateCPU event, Emitter<VpsState> emit) {
    final total = (event.value * (730.56 * state.valueMeses) * 0.04) +
        (state.discoDuro * (730.56 * state.valueMeses) * 0.01) +
        ((state.ram ~/ 512) * (730.56 * state.valueMeses) * 0.025);
    emit(state.copyWith(
        total: double.parse(total.toStringAsFixed(2)), cpu: event.value));
  }

  FutureOr<void> _updateDisco(UpdateDisco event, Emitter<VpsState> emit) {
    final total = (state.cpu * (730.56 * state.valueMeses) * 0.04) +
        (event.value * (730.56 * state.valueMeses) * 0.01) +
        ((state.ram ~/ 512) * (730.56 * state.valueMeses) * 0.025);
    emit(state.copyWith(
        total: double.parse(total.toStringAsFixed(2)), discoDuro: event.value));
  }

  FutureOr<void> _updateMeses(UpdateMeses event, Emitter<VpsState> emit) {
    final total = (state.cpu * (730.56 * event.value) * 0.04) +
        (state.discoDuro * (730.56 * event.value) * 0.01) +
        ((state.ram ~/ 512) * (730.56 * event.value) * 0.025);
    emit(state.copyWith(
        total: double.parse(total.toStringAsFixed(2)),
        valueMeses: event.value));
  }

  FutureOr<void> _changeTheme(ChangeTheme event, Emitter<VpsState> emit) {
    if (state.theme == ThemeWidget().themeLight()) {
      emit(state.copyWith(theme: ThemeWidget().themeDark()));
    } else {
      emit(state.copyWith(theme: ThemeWidget().themeLight()));
    }
  }

  FutureOr<void> _resetTotal(ResetTotal event, Emitter<VpsState> emit) {
    emit(state.copyWith(cpu: 0, discoDuro: 0, ram: 0, total: 0, valueMeses: 1));
  }
}
