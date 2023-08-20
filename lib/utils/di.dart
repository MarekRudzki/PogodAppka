import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:pogodappka/utils/di.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  asExtension: true,
)
void configureDependencies() => getIt.init();
