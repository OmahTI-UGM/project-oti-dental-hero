import 'package:dental_hero/core/constants/snapshot_state_enum.dart';
import 'package:dental_hero/core/constants/time_state_enum.dart';
import 'package:dental_hero/features/activity/presentation/page/activity_screen/activity_screen.dart';
import 'package:dental_hero/features/activity/presentation/page/result_screen/result_screen.dart';
import 'package:dental_hero/features/augmented_reality/presentation/pages/ar_screen/ar_screen.dart';
import 'package:dental_hero/features/augmented_reality/presentation/pages/qr_screen/qr_screen.dart';
import 'package:dental_hero/features/auth/presentation/page/login_screen/login_screen.dart';
import 'package:dental_hero/features/auth/presentation/page/register_screen/register_screen.dart';
import 'package:dental_hero/features/gallery/presentation/page/photo_album/photo_album.dart';
import 'package:dental_hero/features/gallery/presentation/page/photo_steps/photo_step_1.dart';
import 'package:dental_hero/features/gallery/presentation/page/photo_steps/photo_step_2.dart';
import 'package:dental_hero/features/gallery/presentation/page/photo_steps/photo_step_3.dart';
import 'package:dental_hero/features/gallery/presentation/page/photo_steps/photo_step_4.dart';
import 'package:dental_hero/features/home/presentation/page/calendar_screen/calendar_screen.dart';
import 'package:dental_hero/features/home/presentation/page/home_screen/home_screen.dart';
import 'package:dental_hero/features/settings/presentation/pages/settings_screen/settings_screen.dart';
import 'package:dental_hero/features/statistic/presentation/page/statistic_screen/statistic_sceen.dart';
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
        return MaterialPageRoute(builder: (_) => const AlbumScreen());

      case '/photo-steps':
        return MaterialPageRoute(
            builder: (_) => PhotoStep1Screen(
                  snapshotState: settings.arguments as SnapshotState,
                ));

      case '/photo-step-2':
        return MaterialPageRoute(builder: (_) => const PhotoStep2Screen());

      case '/photo-step-3':
        return MaterialPageRoute(builder: (_) => const PhotoStep3Screen());

      case '/photo-step-4':
        return MaterialPageRoute(builder: (_) => const PhotoStep4Screen());
      case '/activity':
        return MaterialPageRoute(builder: (_) {
          return ActivityScreen(
            timeState: settings.arguments as TimeState?,
          );
        });

      case '/statistic':
        return MaterialPageRoute(builder: (_) => const StatisticScreen());

      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsScreen());

      case '/ar':
        return MaterialPageRoute(builder: (_) => const ArScreen());

      case '/qr':
        return MaterialPageRoute(builder: (_) => const QrScreen());

      case '/calendar':
        return MaterialPageRoute(builder: (_) => const CalendarScreen());

      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
