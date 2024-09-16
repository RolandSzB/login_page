import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_page/components/my_button.dart';
import 'package:login_page/components/my_textfield.dart';
import 'register_page_cubit.dart';
import 'register_page_event.dart';
import 'register_page_state.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 215, 247, 200),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const Icon(Icons.person_add,
                    size: 100, color: Color.fromARGB(255, 25, 136, 29)),
                const SizedBox(height: 40),
                Text('Hy there new user!',
                    style: TextStyle(
                        color: Color.fromARGB(255, 3, 119, 23), fontSize: 16)),
                const SizedBox(height: 20),
                MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false),
                const SizedBox(height: 10),
                MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true),
                const SizedBox(height: 10),
                MyTextField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true),
                const SizedBox(height: 25),
                BlocConsumer<RegisterPageBloc, RegisterPageState>(
                  listener: (context, state) {
                    if (state is RegisterError) {
                      showErrorMessage(context, state.message);
                    } else if (state is RegisterSuccess) {
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    if (state is RegisterLoading) {
                      return const CircularProgressIndicator();
                    }

                    return MyButton(
                      text: 'Register',
                      onTap: () {
                        final email = emailController.text;
                        final password = passwordController.text;
                        final confirmPassword = confirmPasswordController.text;

                        context.read<RegisterPageBloc>().add(
                              RegisterSubmitted(
                                  email, password, confirmPassword),
                            );
                      },
                    );
                  },
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already a member?',
                        style: TextStyle(color: Colors.grey[700])),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        'Login Now',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showErrorMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.red,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
