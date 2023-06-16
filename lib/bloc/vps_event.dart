part of 'vps_bloc.dart';

abstract class VpsEvent {
  factory VpsEvent.resetTotal() => ResetTotal();
  factory VpsEvent.changeTheme() => ChangeTheme();
  factory VpsEvent.updateRam({required int value}) => UpdateRam(value: value);
  factory VpsEvent.updateDisco({required int value}) =>
      UpdateDisco(value: value);
  factory VpsEvent.updateCPU({required int value}) => UpdateCPU(value: value);
  factory VpsEvent.updateMeses({required int value}) =>
      UpdateMeses(value: value);
}

class ResetTotal implements VpsEvent {}

class ChangeTheme implements VpsEvent {}

class UpdateRam implements VpsEvent {
  final int value;

  UpdateRam({required this.value});
}

class UpdateDisco implements VpsEvent {
  final int value;

  UpdateDisco({required this.value});
}

class UpdateCPU implements VpsEvent {
  final int value;

  UpdateCPU({required this.value});
}

class UpdateMeses implements VpsEvent {
  final int value;

  UpdateMeses({required this.value});
}
