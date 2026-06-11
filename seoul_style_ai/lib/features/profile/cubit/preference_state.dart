import 'package:equatable/equatable.dart';
import '../../../data/models/user_preference.dart';

abstract class PreferenceState extends Equatable {
  const PreferenceState();

  @override
  List<Object?> get props => [];
}

class PreferenceInitial extends PreferenceState {}

class PreferenceLoading extends PreferenceState {}

class PreferenceLoaded extends PreferenceState {
  final UserPreference preference;

  const PreferenceLoaded(this.preference);

  @override
  List<Object?> get props => [preference];
}

class PreferenceError extends PreferenceState {
  final String message;

  const PreferenceError(this.message);

  @override
  List<Object?> get props => [message];
}
