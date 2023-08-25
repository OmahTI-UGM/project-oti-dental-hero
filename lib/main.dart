import 'package:dental_hero/features/auth/presentation/page/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
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
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: theme(),
        // onGenerateRoute: AppRoutes.onGenerateRoutes,
        home: LoginScreen());
  }
}
