import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
sealed class ForgotPasswordEvent extends Equatable {}

@immutable
class ForgotPasswordErrorEvent extends ForgotPasswordEvent {
  final String error;

  ForgotPasswordErrorEvent(this.error);

  @override
  List<Object?> get props => [error];
}

@immutable
class ForgotPasswordSuccess extends ForgotPasswordEvent {
  ForgotPasswordSuccess();

  @override
  List<Object?> get props => [];
}
