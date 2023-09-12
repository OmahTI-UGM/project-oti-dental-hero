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
    // TODO: on prod, add delay
    Future<void>.delayed(const Duration(seconds: 2), () {
      BlocProvider.of<AuthBloc>(context).add(const CheckAuthEvent());
    });

    return BlocListener<AuthBloc, AuthState>(
      listener: _listener,
      child: _buildBody(),
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

  _buildBody() {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.asset('assets/images/splash.png'),
          ),
          Center(
            child: Image.asset('assets/images/logo_full.png'),
          ),
        ],
      ),
    );
  }
}
