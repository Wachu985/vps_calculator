import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:vps_calculator/theme/theme.dart';

import 'bloc/vps_bloc.dart';

void main() {
  runApp(BlocProvider(
    create: (_) => VpsBloc(),
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(child,
          maxWidth: 2460,
          minWidth: 800,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(480, name: MOBILE),
            const ResponsiveBreakpoint.resize(800, name: TABLET),
            const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
            const ResponsiveBreakpoint.resize(2460, name: '4K'),
          ],
          background: Container(color: const Color(0xFFF5F5F5))),
      theme: context.watch<VpsBloc>().state.theme,
      debugShowCheckedModeBanner: false,
      title: 'VPS Calculator',
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.read<VpsBloc>().add(VpsEvent.resetTotal());
            },
            child: const Icon(Icons.refresh_outlined)),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "Calculador de Costos de Servicio VPS ETECSA",
            style: TextStyle(
                fontSize: 30,
                color: context.watch<VpsBloc>().state.theme?.hintColor),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  color: context.watch<VpsBloc>().state.theme?.hintColor,
                  onPressed: () {
                    context.read<VpsBloc>().add(VpsEvent.resetTotal());
                  },
                  icon: const Icon(Icons.refresh_outlined)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  color: context.watch<VpsBloc>().state.theme?.hintColor,
                  onPressed: () {
                    context.read<VpsBloc>().add(VpsEvent.changeTheme());
                  },
                  icon: context.watch<VpsBloc>().state.theme ==
                          ThemeWidget().themeLight()
                      ? const Icon(Icons.nightlight)
                      : const Icon(Icons.sunny)),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                if (constraints.maxWidth > 600) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RecursoWidget(
                        title: 'Memoria RAM',
                        update: context.watch<VpsBloc>().state.ram,
                        onAdding: () {
                          int value = context.read<VpsBloc>().state.ram;
                          if (value >= 0) {
                            context
                                .read<VpsBloc>()
                                .add(VpsEvent.updateRam(value: value + 512));
                          }
                        },
                        onDelete: () {
                          int value = context.read<VpsBloc>().state.ram;
                          if (value > 0) {
                            context
                                .read<VpsBloc>()
                                .add(VpsEvent.updateRam(value: value - 512));
                          }
                        },
                      ),
                      RecursoWidget(
                        title: 'CPU',
                        update: context.watch<VpsBloc>().state.cpu,
                        onAdding: () {
                          int value = context.read<VpsBloc>().state.cpu;
                          if (value >= 0) {
                            context
                                .read<VpsBloc>()
                                .add(VpsEvent.updateCPU(value: value + 1));
                          }
                        },
                        onDelete: () {
                          int value = context.read<VpsBloc>().state.cpu;
                          if (value > 0) {
                            context
                                .read<VpsBloc>()
                                .add(VpsEvent.updateCPU(value: value - 1));
                          }
                        },
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      RecursoWidget(
                        title: 'Memoria RAM',
                        update: context.watch<VpsBloc>().state.ram,
                        onAdding: () {
                          int value = context.read<VpsBloc>().state.ram;
                          if (value >= 0) {
                            context
                                .read<VpsBloc>()
                                .add(VpsEvent.updateRam(value: value + 512));
                          }
                        },
                        onDelete: () {
                          int value = context.read<VpsBloc>().state.ram;
                          if (value > 0) {
                            context
                                .read<VpsBloc>()
                                .add(VpsEvent.updateRam(value: value - 512));
                          }
                        },
                      ),
                      RecursoWidget(
                        title: 'CPU',
                        update: context.watch<VpsBloc>().state.cpu,
                        onAdding: () {
                          int value = context.read<VpsBloc>().state.cpu;
                          if (value >= 0) {
                            context
                                .read<VpsBloc>()
                                .add(VpsEvent.updateCPU(value: value + 1));
                          }
                        },
                        onDelete: () {
                          int value = context.read<VpsBloc>().state.cpu;
                          if (value > 0) {
                            context
                                .read<VpsBloc>()
                                .add(VpsEvent.updateCPU(value: value - 1));
                          }
                        },
                      ),
                    ],
                  );
                }
              }),
              RecursoWidget(
                title: 'Disco Duro',
                update: context.watch<VpsBloc>().state.discoDuro,
                onAdding: () {
                  int value = context.read<VpsBloc>().state.discoDuro;
                  if (value >= 0) {
                    context
                        .read<VpsBloc>()
                        .add(VpsEvent.updateDisco(value: value + 20));
                  }
                },
                onDelete: () {
                  int value = context.read<VpsBloc>().state.discoDuro;
                  if (value > 0) {
                    context
                        .read<VpsBloc>()
                        .add(VpsEvent.updateDisco(value: value - 20));
                  }
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 100),
                child: MesesWidget(),
              ),
              const SalidaWidget()
            ],
          ),
        ),
      ),
    );
  }
}

class MesesWidget extends StatelessWidget {
  const MesesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Cantidad de Meses',
          style: TextStyle(fontSize: 25),
        ),
        Slider(
            activeColor: Colors.deepPurple,
            inactiveColor:
                context.watch<VpsBloc>().state.theme?.colorScheme.secondary,
            label: context.watch<VpsBloc>().state.valueMeses == 1
                ? '1 Mes'
                : " ${context.watch<VpsBloc>().state.valueMeses} Meses",
            divisions: 12,
            min: 1,
            max: 12,
            value: context.watch<VpsBloc>().state.valueMeses.toDouble(),
            onChanged: (value) {
              context
                  .read<VpsBloc>()
                  .add(VpsEvent.updateMeses(value: value.toInt()));
            }),
      ],
    );
  }
}

class SalidaWidget extends StatelessWidget {
  const SalidaWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Precio del VPS',
          style: TextStyle(fontSize: 25),
        ),
        Container(
          margin: const EdgeInsets.all(20),
          height: 50,
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color:
                  context.watch<VpsBloc>().state.theme?.colorScheme.secondary),
          child: Center(
            child: Text(
              context.watch<VpsBloc>().state.total.toString(),
              style: const TextStyle(fontSize: 30),
            ),
          ),
        ),
      ],
    );
  }
}

class RecursoWidget extends StatelessWidget {
  final String title;
  final int update;
  final Function() onDelete;
  final Function() onAdding;

  const RecursoWidget({
    super.key,
    required this.title,
    required this.update,
    required this.onDelete,
    required this.onAdding,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 25),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed: onDelete, icon: const Icon(Icons.remove)),
            Container(
              margin: const EdgeInsets.all(20),
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: context
                      .watch<VpsBloc>()
                      .state
                      .theme
                      ?.colorScheme
                      .secondary),
              child: Center(
                child: Text(
                  update.toString(),
                  style: const TextStyle(fontSize: 30),
                ),
              ),
            ),
            IconButton(onPressed: onAdding, icon: const Icon(Icons.add)),
          ],
        ),
      ],
    );
  }
}
