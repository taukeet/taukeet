// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:taukeet/core/di/modules.dart' as _i323;
import 'package:taukeet/features/location/data/repositories/location_repository_impl.dart'
    as _i29;
import 'package:taukeet/features/location/data/services/geocoding_service_impl.dart'
    as _i449;
import 'package:taukeet/features/location/domain/repositories/location_repository.dart'
    as _i421;
import 'package:taukeet/features/location/domain/services/location_service.dart'
    as _i777;
import 'package:taukeet/features/settings/data/repositories/settings_repository_impl.dart'
    as _i442;
import 'package:taukeet/features/settings/data/services/settings_service_impl.dart'
    as _i864;
import 'package:taukeet/features/settings/domain/repositories/settings_repository.dart'
    as _i674;
import 'package:taukeet/features/settings/domain/services/settings_service.dart'
    as _i198;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i777.LocationService>(() => _i449.GeocodingServiceImpl());
    gh.lazySingleton<_i198.SettingsService>(
        () => _i864.SettingsServiceImpl(gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i421.LocationRepository>(
        () => _i29.LocationRepositoryImpl(gh<_i777.LocationService>()));
    gh.lazySingleton<_i674.SettingsRepository>(
        () => _i442.SettingsRepositoryImpl(gh<_i198.SettingsService>()));
    return this;
  }
}

class _$RegisterModule extends _i323.RegisterModule {}
