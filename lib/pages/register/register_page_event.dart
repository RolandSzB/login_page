import 'package:equatable/equatable.dart';

abstract class RegisterPageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterSubmitted extends RegisterPageEvent {
  final String email;
  final String password;
  final String confirmPassword;

  RegisterSubmitted(this.email, this.password, this.confirmPassword);

  @override
  List<Object> get props => [email, password, confirmPassword];
}
