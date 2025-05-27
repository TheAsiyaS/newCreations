// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'countercheck2_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Countercheck2Event {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Countercheck2Event);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Countercheck2Event()';
  }
}

/// @nodoc
class $Countercheck2EventCopyWith<$Res> {
  $Countercheck2EventCopyWith(
      Countercheck2Event _, $Res Function(Countercheck2Event) __);
}

/// @nodoc

class Incerment implements Countercheck2Event {
  const Incerment();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Incerment);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Countercheck2Event.increment()';
  }
}

/// @nodoc

class Decrement implements Countercheck2Event {
  const Decrement();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Decrement);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Countercheck2Event.decrement()';
  }
}

/// @nodoc
mixin _$Countercheck2State {
  int get count;

  /// Create a copy of Countercheck2State
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Countercheck2StateCopyWith<Countercheck2State> get copyWith =>
      _$Countercheck2StateCopyWithImpl<Countercheck2State>(
          this as Countercheck2State, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Countercheck2State &&
            (identical(other.count, count) || other.count == count));
  }

  @override
  int get hashCode => Object.hash(runtimeType, count);

  @override
  String toString() {
    return 'Countercheck2State(count: $count)';
  }
}

/// @nodoc
abstract mixin class $Countercheck2StateCopyWith<$Res> {
  factory $Countercheck2StateCopyWith(
          Countercheck2State value, $Res Function(Countercheck2State) _then) =
      _$Countercheck2StateCopyWithImpl;
  @useResult
  $Res call({int count});
}

/// @nodoc
class _$Countercheck2StateCopyWithImpl<$Res>
    implements $Countercheck2StateCopyWith<$Res> {
  _$Countercheck2StateCopyWithImpl(this._self, this._then);

  final Countercheck2State _self;
  final $Res Function(Countercheck2State) _then;

  /// Create a copy of Countercheck2State
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = null,
  }) {
    return _then(_self.copyWith(
      count: null == count
          ? _self.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _Countercheck2State implements Countercheck2State {
  const _Countercheck2State({required this.count});

  @override
  final int count;

  /// Create a copy of Countercheck2State
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$Countercheck2StateCopyWith<_Countercheck2State> get copyWith =>
      __$Countercheck2StateCopyWithImpl<_Countercheck2State>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Countercheck2State &&
            (identical(other.count, count) || other.count == count));
  }

  @override
  int get hashCode => Object.hash(runtimeType, count);

  @override
  String toString() {
    return 'Countercheck2State(count: $count)';
  }
}

/// @nodoc
abstract mixin class _$Countercheck2StateCopyWith<$Res>
    implements $Countercheck2StateCopyWith<$Res> {
  factory _$Countercheck2StateCopyWith(
          _Countercheck2State value, $Res Function(_Countercheck2State) _then) =
      __$Countercheck2StateCopyWithImpl;
  @override
  @useResult
  $Res call({int count});
}

/// @nodoc
class __$Countercheck2StateCopyWithImpl<$Res>
    implements _$Countercheck2StateCopyWith<$Res> {
  __$Countercheck2StateCopyWithImpl(this._self, this._then);

  final _Countercheck2State _self;
  final $Res Function(_Countercheck2State) _then;

  /// Create a copy of Countercheck2State
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? count = null,
  }) {
    return _then(_Countercheck2State(
      count: null == count
          ? _self.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
