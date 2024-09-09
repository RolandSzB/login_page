import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_page/pages/forgot_password/forgot_password_cubit.dart';
import 'package:login_page/pages/forgot_password/forgot_password_event.dart';
import 'package:login_page/pages/forgot_password/forgot_password_state.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  ForgotPasswordScreenState createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final screenCubit = ForgotPasswordCubit();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 38, 156, 42),
      ),
      body: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listenWhen: (previous, current) => previous.event != current.event,
        listener: (BuildContext context, ForgotPasswordState state) {
          final event = state.event;
          if (event != null) {
            _onEvent(context, event);
          }
        },
        builder: (BuildContext context, ForgotPasswordState state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(ForgotPasswordState state) {
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              const Text(
                "Enter Your Email and we will send you a link to reset your password",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  context.read<ForgotPasswordCubit>().updateEmail(value);
                },
                decoration: InputDecoration(
                  labelText: "Email",
                  border: const OutlineInputBorder(),
                  errorText: state.emailError,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<ForgotPasswordCubit>().resetPassword();
                },
                child: const Text("Submit"),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onEvent(BuildContext context, ForgotPasswordEvent event) {
    switch (event) {
      case ForgotPasswordSuccess():
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("The email was sent. Please check it!"),
          behavior: SnackBarBehavior.floating,
        ));
        break;
      case ForgotPasswordErrorEvent():
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(event.error),
          behavior: SnackBarBehavior.floating,
        ));
        break;
    }
  }
}
