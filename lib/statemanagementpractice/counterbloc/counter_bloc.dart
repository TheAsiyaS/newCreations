import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterInitial(count: 0)) {
    //increment

    on<IncrementCounter>((event, emit) {
    final currentState = state;
  if (currentState is CounterInitial) {
    emit(CounterInitial(count: currentState.count +1));
  }
    });
//deceremt
       on<IncrementCounter>((event, emit) {
    final currentState = state;
  if (currentState is CounterInitial) {
    emit(CounterInitial(count: currentState.count -1));
  }
    });
  }
}
