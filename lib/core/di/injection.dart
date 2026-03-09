import 'package:get_it/get_it.dart';
import 'package:perfect_numbers/core/db/database_helper.dart';
import 'package:perfect_numbers/features/perfect_number/data/datasources/search_local_datasource.dart';
import 'package:perfect_numbers/features/perfect_number/data/repositories/perfect_number_repository_impl.dart';
import 'package:perfect_numbers/features/perfect_number/domain/repositories/perfect_number_repository.dart';
import 'package:perfect_numbers/features/perfect_number/domain/usecases/check_perfect_number_usecase.dart';
import 'package:perfect_numbers/features/perfect_number/domain/usecases/find_perfect_numbers_usecase.dart';
import 'package:perfect_numbers/features/perfect_number/domain/usecases/get_history_usecase.dart';
import 'package:perfect_numbers/features/perfect_number/domain/usecases/save_search_usecase.dart';

final sl = GetIt.instance;

Future<void> setupDependencies() async {
  // ─── Core ──────────────────────────────────────────────────────────────────
  sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper.instance);

  // ─── Data Sources ──────────────────────────────────────────────────────────
  sl.registerLazySingleton<SearchLocalDatasource>(
    () => SearchLocalDatasourceImpl(sl()),
  );

  // ─── Repositories ──────────────────────────────────────────────────────────
  sl.registerLazySingleton<PerfectNumberRepository>(
    () => PerfectNumberRepositoryImpl(sl()),
  );

  // ─── Use Cases ─────────────────────────────────────────────────────────────
  sl.registerFactory<CheckPerfectNumberUsecase>(
    () => CheckPerfectNumberUsecase(),
  );
  sl.registerFactory<FindPerfectNumbersUsecase>(
    () => FindPerfectNumbersUsecase(),
  );

  sl.registerLazySingleton<SaveSearchUsecase>(() => SaveSearchUsecase(sl()));
  sl.registerLazySingleton<GetHistoryUsecase>(() => GetHistoryUsecase(sl()));
}
