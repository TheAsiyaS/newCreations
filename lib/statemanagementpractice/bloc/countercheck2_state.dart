part of 'countercheck2_bloc.dart';

@freezed
abstract class Countercheck2State with _$Countercheck2State {
  const factory Countercheck2State({
    required int count
  }) = _Countercheck2State;
  

  //set value of count for app start (initial time)
  factory Countercheck2State.initial()=> const Countercheck2State(count: 0);
  
}
