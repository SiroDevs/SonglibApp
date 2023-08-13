// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:drift/drift.dart' as _i3;
import 'package:firebase_analytics/firebase_analytics.dart' as _i4;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i7;
import 'package:songlib/di/injectable.dart' as _i10;
import 'package:songlib/viewmodels/app_viewmodel.dart' as _i9;
import 'package:songlib/viewmodels/home_viewmodel.dart' as _i6;
import 'package:songlib/viewmodels/splash_viewmodel.dart' as _i8;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> initGetIt({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    await gh.singletonAsync<_i3.DatabaseConnection>(
      () => registerModule.provideDatabaseConnection(),
      preResolve: true,
    );
    gh.lazySingleton<_i4.FirebaseAnalytics>(
        () => registerModule.provideFirebaseAnalytics());
    gh.lazySingleton<_i5.FlutterSecureStorage>(() => registerModule.storage());
    gh.factory<_i6.HomeViewModel>(() => _i6.HomeViewModel());
    await gh.singletonAsync<_i7.SharedPreferences>(
      () => registerModule.prefs(),
      preResolve: true,
    );
    gh.factory<_i8.SplashViewModel>(() => _i8.SplashViewModel());
    gh.singleton<_i9.AppViewModel>(
        _i9.AppViewModel(gh<_i7.SharedPreferences>()));
    return this;
  }
}

class _$RegisterModule extends _i10.RegisterModule {}
