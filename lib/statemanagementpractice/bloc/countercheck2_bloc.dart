import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'countercheck2_event.dart';
part 'countercheck2_state.dart';
part 'countercheck2_bloc.freezed.dart';

class Countercheck2Bloc extends Bloc<Countercheck2Event, Countercheck2State> {
  //already we set intital value in state, but we have tell to our bloc

  Countercheck2Bloc() : super(Countercheck2State.initial()) {
    on<Incerment>((event, emit) {
      // TODO: implement event handler
      return emit(state.copyWith(count: state.count + 1));
    });
    on<Decrement>((event, emit) {
      // TODO: implement event handler
      return emit(state.copyWith(count: state.count - 1));
    });
  }
}
