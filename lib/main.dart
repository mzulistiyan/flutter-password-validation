import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_validate_password/cubit/auth_cubit.dart';
import 'package:flutter_validate_password/presentasion/home_page.dart';
import 'package:flutter_validate_password/presentasion/sign_in_page.dart';
import 'package:flutter_validate_password/presentasion/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import 'presentasion/sign_up_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SplashScreen(),
          '/sign-up': (context) => SignUpPage(),
          '/sign-in': (context) => SignInPage(),
          '/home-page': (context) => HomePage(),
        },
      ),
    );
  }
}
