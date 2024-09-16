import 'package:equatable/equatable.dart';

abstract class RegisterPageState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterPageState {}

class RegisterLoading extends RegisterPageState {}

class RegisterSuccess extends RegisterPageState {}

class RegisterError extends RegisterPageState {
  final String message;

  RegisterError(this.message);

  @override
  List<Object?> get props => [message];
}
