import 'package:dental_hero/features/activity/presentation/page/result_screen/result_screen.dart';
import 'package:dental_hero/features/auth/presentation/page/login_screen/login_screen.dart';
import 'package:dental_hero/features/auth/presentation/page/register_screen/register_screen.dart';
import 'package:dental_hero/features/gallery/presentation/page/photo_album/photo_album.dart';
import 'package:dental_hero/features/gallery/presentation/page/photo_steps/photo_step_1.dart';
import 'package:dental_hero/features/gallery/presentation/page/photo_steps/photo_step_2.dart';
import 'package:dental_hero/features/gallery/presentation/page/photo_steps/photo_step_3.dart';
import 'package:dental_hero/features/gallery/presentation/page/photo_steps/photo_step_4.dart';
import 'package:dental_hero/features/home/presentation/page/home_screen/home_screen.dart';
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

      case '/album':
        return MaterialPageRoute(builder: (_) => AlbumScreen());

      case '/photo-steps':
        return MaterialPageRoute(builder: (_) => const PhotoStep1Screen());

      case '/photo-step-2':
        return MaterialPageRoute(builder: (_) => const PhotoStep2Screen());

      case '/photo-step-3':
        return MaterialPageRoute(builder: (_) => const PhotoStep3Screen());

      case '/photo-step-4':
        return MaterialPageRoute(builder: (_) => const PhotoStep4Screen());

      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
