import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_creations/db/animation/Animationtextfade.dart';
import 'package:new_creations/statemanagementpractice/counterbloc/counter_bloc.dart';
import 'package:new_creations/statemanagementpractice/counterui.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CounterBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: CounterAppUI());
  }
}
