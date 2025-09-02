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
import 'package:taukeet/features/location/data/repositories/location_repository_impl.dart'
    as _i29;
import 'package:taukeet/features/location/data/services/geocoding_service_impl.dart'
    as _i449;
import 'package:taukeet/features/location/domain/repositories/location_repository.dart'
    as _i421;
import 'package:taukeet/features/location/domain/services/location_service.dart'
    as _i777;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i777.LocationService>(() => _i449.GeocodingServiceImpl());
    gh.lazySingleton<_i421.LocationRepository>(
        () => _i29.LocationRepositoryImpl(gh<_i777.LocationService>()));
    return this;
  }
}
