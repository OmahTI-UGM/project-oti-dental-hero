import 'package:dental_hero/config/routes/routes.dart';
import 'package:dental_hero/core/common/activity.dart';
import 'package:dental_hero/core/common/navigation/navigation_cubit.dart';
import 'package:dental_hero/features/activity/presentation/blocs/timer/timer_bloc.dart';
import 'package:dental_hero/features/activity/presentation/page/activity_screen/activity_screen.dart';
import 'package:dental_hero/features/augmented_reality/presentation/pages/ar_screen/ar_screen.dart';
import 'package:dental_hero/features/auth/presentation/blocs/ui/dropdown_bloc.dart';
import 'package:dental_hero/features/auth/presentation/page/login_screen/login_screen.dart';
import 'package:dental_hero/features/home/presentation/page/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/activity/presentation/blocs/activity/activity_bloc.dart';
import 'features/augmented_reality/presentation/pages/ar_screen/ar_screen.dart';
import 'features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'injection_container.dart'; //Dependency injector

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies(); //Inject all the dependencies and wait for it is done (i.e. UI won't built until all the dependencies are injected)
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NavigationCubit(),
          ),
          BlocProvider<AuthBloc>(
            create: (context) => sl(),
          ),
          BlocProvider<TimerBloc>(
            create: (context) => sl(),
          ),
          BlocProvider<DropdownBloc>(
            create: (context) => sl(),
          ),
          BlocProvider<ActivityBloc>(
            create: (context) => sl(),
          )
        ],
        child: MaterialApp(
          title: 'Dental Hero',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: AppRoutes.onGenerateRoutes,
          home: LoginScreen(),
          // home: ActivityScreen(),
        ));
  }
}
