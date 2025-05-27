import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_creations/statemanagementpractice/bloc/countercheck2_bloc.dart';

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
            BlocBuilder<Countercheck2Bloc, Countercheck2State>(
                builder: (context, state) {
              return Text('count data :${state.count} ');
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
                  context
                      .read<Countercheck2Bloc>()
                      .add(const Countercheck2Event.increment());
                },
                icon: const Icon(Icons.add)),
            IconButton(
                onPressed: () {
                  context
                      .read<Countercheck2Bloc>()
                      .add(const Countercheck2Event.decrement());
                },
                icon: const Icon(Icons.minimize_outlined))
          ],
        ),
      ),
    );
  }
}
