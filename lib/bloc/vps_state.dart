part of 'vps_bloc.dart';

class VpsState extends Equatable {
  const VpsState(
      {this.valueMeses = 1,
      this.cpu = 0,
      this.discoDuro = 0,
      this.ram = 0,
      this.total = 0,
      this.theme});
  final int valueMeses;
  final int cpu;
  final ThemeData? theme;
  final int discoDuro;
  final int ram;
  final double total;

  factory VpsState.initialState() =>
      VpsState(theme: ThemeWidget().themeLight());

  VpsState copyWith({
    int? valueMeses,
    int? cpu,
    int? discoDuro,
    int? ram,
    ThemeData? theme,
    double? total,
  }) {
    return VpsState(
      valueMeses: valueMeses ?? this.valueMeses,
      cpu: cpu ?? this.cpu,
      theme: theme ?? this.theme,
      discoDuro: discoDuro ?? this.discoDuro,
      ram: ram ?? this.ram,
      total: total ?? this.total,
    );
  }

  @override
  List<Object?> get props => [valueMeses, cpu, discoDuro, ram, total, theme];
}
