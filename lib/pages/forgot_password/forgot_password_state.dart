import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:login_page/pages/forgot_password/forgot_password_event.dart';

class ForgotPasswordState extends Equatable {
  final bool isLoading;
  final String email;
  final String? emailError;
  final ForgotPasswordEvent? event;

  const ForgotPasswordState.initial()
      : isLoading = true,
        email = '',
        emailError = null,
        event = null;

  const ForgotPasswordState({
    required this.isLoading,
    this.emailError,
    this.event,
    required this.email, // ezzel a modszerrel tudsz null erteket atadni a CopyWith-el egy valtozonak
  });

  // fontos hogy CopyWith-el valtoztasd az ertekeket egy class-ben mert igy nem krealodik mindig egy uj instace az objectbol, hanem a mar meglevo objectet valtoztatod.
  ForgotPasswordState copyWith({
    bool? isLoading,
    ValueGetter<ForgotPasswordEvent?>?
        event, // igy tudsz null erteket atadni a CopyWith-el egy valtozonak
    String? email,
    ValueGetter<String?>? emailError,
  }) {
    return ForgotPasswordState(
      isLoading: isLoading ?? this.isLoading,
      event: event != null ? event() : this.event,
      email: email ?? this.email,
      emailError: emailError != null ? emailError() : this.emailError,
    );
  }

  @override
  List<Object?> get props => [isLoading, event, email, emailError];
}
