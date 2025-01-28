/*
import 'package:get_it/get_it.dart';
import 'package:monapp/services/api_service.dart';
import 'package:monapp/services/auth_service.dart';
import 'package:monapp/features/profile/data/profile_repository.dart';
import 'package:monapp/features/profile/domain/usecases/profile_usecase.dart';

final GetIt locator = GetIt.instance;  // This will hold all of our dependencies

void setupDependencyInjection() {
  // Registering Services
  locator.registerLazySingleton<ApiService>(() => ApiService());
  locator.registerLazySingleton<AuthService>(() => AuthService());

  // Registering Repositories
  locator.registerLazySingleton<ProfileRepository>(() => ProfileRepository(apiService: locator<ApiService>()));

  // Registering UseCases
  locator.registerLazySingleton<ProfileUseCase>(() => ProfileUseCase(profileRepository: locator<ProfileRepository>()));
}
*/