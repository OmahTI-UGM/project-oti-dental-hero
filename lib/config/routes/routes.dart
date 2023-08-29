import 'package:dental_hero/features/auth/presentation/page/home_screen/home_screen.dart';
import 'package:dental_hero/features/auth/presentation/page/login_screen/login_screen.dart';
import 'package:dental_hero/features/auth/presentation/page/register_screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/presentation/blocs/ui/dropdown_bloc.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case '/register':
        return MaterialPageRoute(builder: (context) {
          return BlocProvider.value(
              value: context.read<DropdownBloc>(),
              child: const RegisterScreen());
        });

      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
