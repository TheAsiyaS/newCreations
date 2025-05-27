part of 'countercheck2_bloc.dart';

@freezed
class Countercheck2Event with _$Countercheck2Event {
  const factory Countercheck2Event.increment() = Incerment;
  const factory Countercheck2Event.decrement() = Decrement;
}
 