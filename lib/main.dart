import 'package:dental_hero/config/routes/routes.dart';
import 'package:dental_hero/core/common/navigation/navigation_cubit.dart';
import 'package:dental_hero/features/auth/presentation/page/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        ],
        child: MaterialApp(
          title: 'Dental Hero',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: AppRoutes.onGenerateRoutes,
          home: const LoginScreen(),
        ));
  }
}
