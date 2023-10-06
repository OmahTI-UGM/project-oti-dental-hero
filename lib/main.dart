import 'package:dental_hero/config/routes/routes.dart';
import 'package:dental_hero/core/common/splash_screen/splash_screen.dart';
import 'package:dental_hero/features/activity/presentation/blocs/confetti/confetti_bloc.dart';
import 'package:dental_hero/features/activity/presentation/blocs/timer/timer_bloc.dart';
import 'package:dental_hero/features/augmented_reality/presentation/blocs/ar/ar_bloc.dart';
import 'package:dental_hero/features/augmented_reality/presentation/blocs/qr/qr_bloc.dart';
import 'package:dental_hero/features/auth/presentation/blocs/ui/dropdown_bloc.dart';
import 'package:dental_hero/features/home/presentation/blocs/home/home_bloc.dart';
import 'package:dental_hero/features/statistic/presentation/blocs/statistic/statistic_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/activity/presentation/blocs/activity/activity_bloc.dart';
import 'features/auth/domain/entities/user.dart';
import 'features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'features/gallery/presentation/blocs/image_picker/image_picker_bloc.dart';
import 'features/statistic/presentation/blocs/leaderboard/leaderboard_bloc.dart';
import 'injection_container.dart'; //Dependency injector

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies(); //Inject all the dependencies and wait for it is done (i.e. UI won't built until all the dependencies are injected)

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final UserEntity? user;

  const MyApp({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => sl(),
          ),
          BlocProvider<HomeBloc>(
            create: (context) => sl(),
          ),
          BlocProvider<TimerBloc>(
            create: (context) => sl(),
          ),
          BlocProvider<DropdownBloc>(
            create: (context) => sl(),
          ),
          BlocProvider<ImagePickerBloc>(
            create: (context) => sl(),
          ),
          BlocProvider<ActivityBloc>(
            create: (context) => sl(),
          ),
          BlocProvider<QrBloc>(
            create: (context) => sl(),
          ),
          BlocProvider<ArBloc>(
            create: (context) => sl(),
          ),
          BlocProvider<LeaderboardBloc>(
            create: (context) => sl(),
          ),
          BlocProvider<ConfettiCubit>(
            create: (context) => sl(),
          ),
          BlocProvider<StatisticBloc>(
            create: (context) => sl(),
          ),
        ],
        child: MaterialApp(
          title: 'Dental Hero',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: AppRoutes.onGenerateRoutes,
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
          // home: ActivityScreen(),
        ));
  }
}
