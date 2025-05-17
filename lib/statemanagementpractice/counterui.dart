import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_creations/statemanagementpractice/counterbloc/counter_bloc.dart';

class CounterAppUI extends StatelessWidget {
  const CounterAppUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter app with bloc'),
      ),
      body: Center(
        // ✅ Center added
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<CounterBloc, CounterState>(builder: (context, state) {
              return Text('count data :${(state as CounterInitial).count} ');
            }),
            const SizedBox(height: 20), // spacing
            Container(
              height: 150,
              width: 150,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 139, 174, 181),
                image: DecorationImage(
                  image: AssetImage(
                    'assets/Top-5-must-visit-island-destinations-in-the-world.webp',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  context.read<CounterBloc>().add(const IncrementCounter());
                },
                icon: const Icon(Icons.add)),
                    IconButton(
                onPressed: () {
                  context.read<CounterBloc>().add(const DecrementCounter());
                },
                icon: const Icon(Icons.minimize_outlined))
          ],
        ),
      ),
    );
  }
}
