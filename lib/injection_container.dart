import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance; //sl is referred to as Service Locator

// Depencency Injection
Future<void> init() async {
  // Blocs

  // Use Cases

  // Repositories

  // Data sources

  // External
  final FirebaseApp app = await Firebase.initializeApp();
  sl.registerSingleton<FirebaseApp>(app);
}
