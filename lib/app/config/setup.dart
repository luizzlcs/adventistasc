import 'package:adventistasc/app/pages/counter_controller.dart';
import 'package:adventistasc/app/repositories/counter_repository.dart';
import 'package:adventistasc/app/service/counter_service.dart';
import 'package:adventistasc/main.dart';

void setup() {
  // Registrar CounterRepository primeiro
  getIt.registerLazySingleton<CounterRepository>(() => CounterRepository());

  // Registrar CounterService passando o repositório correto
  getIt.registerLazySingleton<CounterService>(
      () => CounterService(getIt<CounterRepository>()));

  // Registrar CounterController passando CounterService e outra dependência necessária
  getIt.registerLazySingleton<CounterController>(
    () => CounterController(
      getIt<CounterService>(),
    ),
  );
}
