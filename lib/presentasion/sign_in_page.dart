import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_validate_password/cubit/auth_cubit.dart';
/**
 * Author: Ambika Dulal
 * profile: https://github.com/ambikadulal
 * images:pixabay.com
  */

class SignInPage extends StatelessWidget {
  static final String path = "lib/src/pages/login/login13.dart";

  @override
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        //topLeft: Radius.circular(60),
                        // topRight: Radius.circular(60),
                        //bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(300),
                      ),
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://cdn.pixabay.com/photo/2015/03/30/12/37/jellyfish-698521__340.jpg'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 30,
                        width: 80,
                        height: 200,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://cdn.pixabay.com/photo/2019/12/24/08/54/flying-dandelions-4716287__340.png'))),
                        ),
                      ),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 150,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://cdn.pixabay.com/photo/2016/08/25/07/30/red-1618916__340.png'))),
                        ),
                      ),
                      Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 150,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://cdn.pixabay.com/photo/2019/10/22/07/52/dandelions-4567966__340.png'))),
                        ),
                      ),
                      Positioned(
                        child: Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, .2),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey[100]!))),
                              child: TextField(
                                controller: emailController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email or Phone number",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                controller: passwordController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(colors: [
                              Color.fromRGBO(143, 148, 251, 1),
                              Color.fromRGBO(143, 148, 251, .6),
                            ])),
                        child: Center(
                            child: BlocConsumer<AuthCubit, AuthState>(
                          listener: (context, state) {
                            if (state is AuthSuccess) {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/home-page', (route) => false);
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
                            return TextButton(
                              onPressed: () {
                                print(emailController.text);
                                print(passwordController.text);
                                context.read<AuthCubit>().signIn(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          },
                        )),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/sign-up');
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                            bottom: 40,
                          ),
                          child: Text(
                            'Don\'t have an account? Sign Up',
                          ),
                        ),
                      ),
                      Text(
                        "Forgot Password?",
                        style:
                            TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
