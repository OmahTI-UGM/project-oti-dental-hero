import 'package:dental_hero/core/common/navigation/navigation_cubit.dart';
import 'package:dental_hero/features/home/presentation/page/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di; //Dependency injector

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di
      .init(); //Inject all the dependencies and wait for it is done (i.e. UI won't built until all the dependencies are injected)

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
        ],
        child: MaterialApp(
          title: 'Dental Hero',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomeScreen(),
        ));
  }
}
