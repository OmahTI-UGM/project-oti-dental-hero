import 'package:dental_hero/core/constants/time_state_enum.dart';
import 'package:dental_hero/features/activity/presentation/page/activity_screen/activity_screen.dart';
import 'package:dental_hero/features/activity/presentation/page/result_screen/result_screen.dart';
import 'package:dental_hero/features/auth/presentation/page/login_screen/login_screen.dart';
import 'package:dental_hero/features/auth/presentation/page/register_screen/register_screen.dart';
import 'package:dental_hero/features/home/presentation/page/home_screen/home_screen.dart';
import 'package:dental_hero/features/settings/presentation/pages/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/presentation/blocs/ui/dropdown_bloc.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case '/register':
        return MaterialPageRoute(builder: (context) {
          return BlocProvider.value(
              value: context.read<DropdownBloc>(), child: RegisterScreen());
        });

      case '/result':
        return MaterialPageRoute(
            builder: (_) => ResultScreen(
                  duration: settings.arguments as int,
                ));

      case '/activity':
        return MaterialPageRoute(builder: (_) {
          return ActivityScreen(
            timeState: settings.arguments as TimeState?,
          );
        });

      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsScreen());

      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
