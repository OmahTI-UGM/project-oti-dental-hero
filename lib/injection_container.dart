import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_hero/features/activity/data/data_sources/remote/activity_api_service.dart';
import 'package:dental_hero/features/activity/domain/usecases/get_activity.dart';
import 'package:dental_hero/features/activity/domain/usecases/save_activity.dart';
import 'package:dental_hero/features/activity/presentation/blocs/timer/timer_bloc.dart';
import 'package:dental_hero/features/auth/domain/repository/auth_repository.dart';
import 'package:dental_hero/features/auth/domain/usecases/login.dart';
import 'package:dental_hero/features/auth/domain/usecases/register.dart';
import 'package:dental_hero/features/auth/presentation/blocs/ui/dropdown_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

import 'core/constants/ticker.dart';
import 'features/activity/presentation/blocs/activity/activity_bloc.dart';
import 'features/auth/data/data_sources/remote/auth_api_service.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/presentation/blocs/auth/auth_bloc.dart';

import 'features/activity/data/repositories/activity_repository_impl.dart';
import 'features/activity/domain/repository/activity_repository.dart';
import 'features/activity/domain/usecases/get_user_activities.dart';

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
  sl.registerSingleton<ActivityApiService>(ActivityApiService(firestore: sl()));

// Repositories
  sl.registerSingleton<AuthRepository>(
      AuthRepositoryImpl(authApiService: sl()));
  sl.registerSingleton<ActivityRepository>(
      ActivityRepositoryImpl(activityApiService: sl()));

  // Use Cases
  sl.registerSingleton<LoginUseCase>(LoginUseCase(repository: sl()));
  sl.registerSingleton<RegisterUseCase>(RegisterUseCase(repository: sl()));

  sl.registerSingleton<GetActivityUseCase>(
      GetActivityUseCase(repository: sl()));
  sl.registerSingleton<GetUserActivitiesUseCase>(
      GetUserActivitiesUseCase(repository: sl()));
  sl.registerSingleton<SaveActivityUseCase>(
      SaveActivityUseCase(repository: sl()));

  // Blocs
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl(), sl()));
  sl.registerFactory<DropdownBloc>(() => DropdownBloc());
  sl.registerFactory<ActivityBloc>(
      () => ActivityBloc(saveActivityUseCase: sl()));
  sl.registerFactory<TimerBloc>(() => TimerBloc(ticker: const Ticker()));
}
