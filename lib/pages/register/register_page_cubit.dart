import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register_page_event.dart';
import 'register_page_state.dart';

class RegisterPageBloc extends Bloc<RegisterPageEvent, RegisterPageState> {
  final FirebaseAuth _firebaseAuth;

  RegisterPageBloc(this._firebaseAuth) : super(RegisterInitial()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
  }

  void _onRegisterSubmitted(
      RegisterSubmitted event, Emitter<RegisterPageState> emit) async {
    emit(RegisterLoading());

    if (event.password != event.confirmPassword) {
      emit(RegisterError("Passwords don't match"));
      return;
    }

    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        emit(RegisterError('Email already in use.'));
      } else {
        emit(RegisterError(e.message ?? 'Registration failed.'));
      }
    }
  }
}
