import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_validate_password/cubit/auth_cubit.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController(text: '');
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');
  bool _isVisible = false;
  bool _isPasswordEightCharacters = false;
  bool _hasPasswordOneNumber = false;

  onPasswordChanged(String password) {
    final numericRegex = RegExp(r'[0-9]');

    setState(() {
      _isPasswordEightCharacters = false;
      if (password.length >= 8) _isPasswordEightCharacters = true;

      _hasPasswordOneNumber = false;
      if (numericRegex.hasMatch(password)) _hasPasswordOneNumber = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            "Create Your Account",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "Please create a secure password including the following criteria below.",
              style: TextStyle(
                  fontSize: 16, height: 1.5, color: Colors.grey.shade600),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black)),
                hintText: "Username",
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black)),
                hintText: "Email",
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: passwordController,
              onChanged: (password) => onPasswordChanged(password),
              obscureText: !_isVisible,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isVisible = !_isVisible;
                    });
                  },
                  icon: _isVisible
                      ? const Icon(
                          Icons.visibility,
                          color: Colors.black,
                        )
                      : const Icon(
                          Icons.visibility_off,
                          color: Colors.grey,
                        ),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black)),
                hintText: "Password",
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      color: _isPasswordEightCharacters
                          ? Colors.green
                          : Colors.transparent,
                      border: _isPasswordEightCharacters
                          ? Border.all(color: Colors.transparent)
                          : Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(50)),
                  child: const Center(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text("Contains at least 8 characters")
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      color: _hasPasswordOneNumber
                          ? Colors.green
                          : Colors.transparent,
                      border: _hasPasswordOneNumber
                          ? Border.all(color: Colors.transparent)
                          : Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(50)),
                  child: const Center(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text("Contains at least 1 number")
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                // TODO: implement listener
                if (state is AuthSuccess) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/sign-in', (route) => false);
                } else if (state is AuthFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(state.error),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return MaterialButton(
                  height: 50,
                  minWidth: double.infinity,
                  onPressed: () {
                    context.read<AuthCubit>().signUp(
                        email: emailController.text,
                        password: passwordController.text,
                        name: nameController.text);
                  },
                  color: Colors.black,
                  child: const Text(
                    "CREATE YOUR ACCOUNT",
                    style: TextStyle(color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
