import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_validate_password/cubit/auth_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            return SafeArea(
                child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('INI HOME PAGE, Login Sebagai ${state.user.name}'),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthFailed) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(state.error),
                          ),
                        );
                      } else if (state is AuthInitial) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/sign-in', (route) => false);
                      }
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Container(
                        width: double.infinity,
                        color: Colors.black,
                        child: TextButton(
                          onPressed: () {
                            context.read<AuthCubit>().signOut();
                          },
                          child: Text('Sign Out'),
                        ),
                      );
                    },
                  )
                ],
              ),
            ));
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
