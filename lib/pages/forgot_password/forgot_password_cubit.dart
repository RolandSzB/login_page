// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_page/pages/forgot_password/forgot_password_event.dart';
import 'package:login_page/pages/forgot_password/forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(const ForgotPasswordState.initial()) {
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    try {
      emit(state.copyWith(isLoading: true));

      // Perform data loading logic here

      emit(state.copyWith(isLoading: false));
    } catch (error) {
      emit(state.copyWith(isLoading: false));
      emit(state.copyWith(
          event: () => ForgotPasswordErrorEvent("An error happened")));
    }
  }

  void updateEmail(String email) {
    emit(state.copyWith(
      email: email,
      emailError: () => null,
    ));
  }

  bool _isEmailValid() {
    // regular expression for email validation
    final emailRegex = RegExp(r'^[\w.+-]+@[a-zA-Z0-9-]+(\.[a-zA-Z]{2,})+$');

    if (state.email.isEmpty) {
      // email address is empty
      return false;
    } else if (!emailRegex.hasMatch(state.email)) {
      // email address is not valid
      return false;
    }

    // email address is valid
    return true;
  }

  Future resetPassword() async {
    if (_isEmailValid() == false) {
      emit(state.copyWith(emailError: () => "Email is not valid!"));
      return;
    }

    try {
      emit(state.copyWith(isLoading: true));
      await FirebaseAuth.instance.sendPasswordResetEmail(email: state.email);
      emit(state.copyWith(
        isLoading: false,
        event: () => ForgotPasswordSuccess(),
      ));
    } catch (e) {
      emit(state.copyWith(
          event: () => ForgotPasswordErrorEvent("An error happened")));
    }
  }
}
