part of 'counter_bloc.dart';

@immutable
sealed class CounterEvent {
  const CounterEvent();
}


//extend eg ( Car could extend a Vehicle class) 
final class IncrementCounter extends CounterEvent {
  const IncrementCounter();// for increment the value 
}
final class DecrementCounter extends CounterEvent {
  const DecrementCounter();// for increment the value 
}
