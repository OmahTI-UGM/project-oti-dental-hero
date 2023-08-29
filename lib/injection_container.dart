import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_hero/features/auth/domain/repository/auth_repository.dart';
import 'package:dental_hero/features/auth/domain/usecases/login.dart';
import 'package:dental_hero/features/auth/domain/usecases/register.dart';
import 'package:dental_hero/features/auth/presentation/blocs/ui/dropdown_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

import 'features/auth/data/data_sources/remote/auth_api_service.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/presentation/blocs/auth/auth_bloc.dart';

final sl = GetIt.instance; //sl is referred to as Service Locator

// Depencency Injection
Future<void> initializeDependencies() async {
  // External
  final FirebaseApp app = await Firebase.initializeApp();
  sl.registerSingleton<FirebaseApp>(app);

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  sl.registerSingleton<FirebaseFirestore>(firestore);

  // Data Sources
  sl.registerSingleton<AuthApiService>(AuthApiService(firestore: sl()));

// Repositories
  sl.registerSingleton<AuthRepository>(
      AuthRepositoryImpl(authApiService: sl()));

  // Use Cases
  sl.registerSingleton<LoginUseCase>(LoginUseCase(repository: sl()));
  sl.registerSingleton<RegisterUseCase>(RegisterUseCase(repository: sl()));

  // Blocs
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl(), sl()));
  sl.registerFactory<DropdownBloc>(() => DropdownBloc());
}
