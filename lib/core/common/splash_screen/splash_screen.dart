import 'package:dental_hero/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:dental_hero/features/auth/presentation/blocs/auth/auth_event.dart';
import 'package:dental_hero/features/auth/presentation/blocs/auth/auth_state.dart';
import 'package:dental_hero/features/auth/presentation/page/login_screen/login_screen.dart';
import 'package:dental_hero/features/home/presentation/page/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    Future<void>.delayed(const Duration(seconds: 2), () {
      BlocProvider.of<AuthBloc>(context).add(const CheckAuthEvent());
    });

    return BlocListener<AuthBloc, AuthState>(
      listener: _listener,
      child: _buildBody(height, width),
    );
  }

  _listener(BuildContext context, AuthState state) {
    if (state is AuthInitial) {
      BlocProvider.of<AuthBloc>(context).add(const CheckAuthEvent());
    }

    if (state is AuthSuccess) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    }

    if (state is AuthFailed) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  _buildBody(double height, width) {
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Image.asset('assets/images/logo_full.png'),
        ),
      ),
    );
  }
}
