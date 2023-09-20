import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_hero/features/activity/data/data_sources/remote/activity_api_service.dart';
import 'package:dental_hero/features/activity/domain/usecases/create_initial_activities.dart';
import 'package:dental_hero/features/activity/domain/usecases/get_activity.dart';
import 'package:dental_hero/features/activity/domain/usecases/save_activity.dart';
import 'package:dental_hero/features/activity/domain/usecases/update_activity.dart';
import 'package:dental_hero/features/activity/presentation/blocs/confetti/confetti_bloc.dart';
import 'package:dental_hero/features/activity/presentation/blocs/timer/timer_bloc.dart';
import 'package:dental_hero/features/auth/data/data_sources/local/auth_sharedprefs_service.dart';
import 'package:dental_hero/features/auth/data/data_sources/remote/user_api_service.dart';
import 'package:dental_hero/features/auth/data/repositories/user_repository_impl.dart';
import 'package:dental_hero/features/auth/domain/repository/auth_repository.dart';
import 'package:dental_hero/features/auth/domain/usecases/check_auth.dart';
import 'package:dental_hero/features/auth/domain/usecases/login.dart';
import 'package:dental_hero/features/auth/domain/usecases/logout.dart';
import 'package:dental_hero/features/auth/domain/usecases/register.dart';
import 'package:dental_hero/features/auth/presentation/blocs/ui/dropdown_bloc.dart';
import 'package:dental_hero/features/home/presentation/blocs/home/home_bloc.dart';
import 'package:dental_hero/features/gallery/presentation/blocs/image_picker_bloc.dart';
import 'package:dental_hero/features/statistic/presentation/blocs/leaderboard/leaderboard_bloc.dart';
import 'package:dental_hero/features/statistic/presentation/blocs/statistic/statistic_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/constants/ticker.dart';
import 'features/activity/presentation/blocs/activity/activity_bloc.dart';
import 'features/auth/data/data_sources/remote/auth_api_service.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repository/user_repository.dart';
import 'features/auth/domain/usecases/get_leaderboard.dart';
import 'features/auth/domain/usecases/increment_score.dart';
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

  final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPrefs);

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  sl.registerSingleton<FirebaseFirestore>(firestore);

  // Data Sources
  sl.registerSingleton<AuthApiService>(AuthApiService(firestore: sl()));
  sl.registerSingleton<AuthSharedPrefsService>(
      AuthSharedPrefsService(sharedPrefs: sl()));
  sl.registerSingleton<UserApiService>(UserApiService(firestore: sl()));
  sl.registerSingleton<ActivityApiService>(ActivityApiService(firestore: sl()));

// Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(
    authApiService: sl(),
    authSharedPrefsService: sl(),
  ));
  sl.registerSingleton<UserRepository>(
      UserRepositoryImpl(userApiService: sl()));
  sl.registerSingleton<ActivityRepository>(
      ActivityRepositoryImpl(activityApiService: sl()));

  // Use Cases
  sl.registerSingleton<LoginUseCase>(LoginUseCase(repository: sl()));
  sl.registerSingleton<RegisterUseCase>(RegisterUseCase(repository: sl()));
  sl.registerSingleton<CheckAuthUseCase>(CheckAuthUseCase(repository: sl()));
  sl.registerSingleton<LogoutUseCase>(LogoutUseCase(repository: sl()));

  sl.registerSingleton<GetLeaderboardUseCase>(
      GetLeaderboardUseCase(repository: sl()));
  sl.registerSingleton<IncrementScoreUseCase>(
      IncrementScoreUseCase(repository: sl()));

  sl.registerSingleton<GetActivityUseCase>(
      GetActivityUseCase(repository: sl()));
  sl.registerSingleton<GetUserActivitiesUseCase>(
      GetUserActivitiesUseCase(repository: sl()));
  sl.registerSingleton<SaveActivityUseCase>(
      SaveActivityUseCase(repository: sl()));
  sl.registerSingleton<UpdateActivityUseCase>(
      UpdateActivityUseCase(repository: sl()));
  sl.registerSingleton<CreateInitialActivitiesUseCase>(
      CreateInitialActivitiesUseCase(repository: sl()));

  // Blocs
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory<HomeBloc>(() => HomeBloc(sl()));
  sl.registerFactory<DropdownBloc>(() => DropdownBloc());
  sl.registerFactory<LeaderboardBloc>(() => LeaderboardBloc(sl()));
  sl.registerFactory<StatisticBloc>(() => StatisticBloc(sl()));
  sl.registerFactory<ActivityBloc>(() => ActivityBloc(
        saveActivityUseCase: sl(),
        updateActivityUseCase: sl(),
        incrementScoreUseCase: sl(),
      ));
  sl.registerFactory<ImagePickerBloc>(
    () => ImagePickerBloc(),
  );

  sl.registerFactory<TimerBloc>(() => TimerBloc(ticker: const Ticker()));
  // sl.registerFactory<ConfettiBloc>(() => ConfettiBloc());
  sl.registerFactory<ConfettiCubit>(() => ConfettiCubit());
}
