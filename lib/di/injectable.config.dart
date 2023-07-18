// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:drift/drift.dart' as _i7;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i8;
import 'package:get_it/get_it.dart' as _i1;
import 'package:icapps_architecture/icapps_architecture.dart' as _i6;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i10;

import '../db/dao/book_dao.dart' as _i12;
import '../db/dao/draft_dao.dart' as _i13;
import '../db/dao/edit_dao.dart' as _i14;
import '../db/dao/history_dao.dart' as _i15;
import '../db/dao/listed_dao.dart' as _i16;
import '../db/dao/search_dao.dart' as _i17;
import '../db/dao/song_dao.dart' as _i18;
import '../db/songlib_db.dart' as _i11;
import '../repository/db_repository.dart' as _i20;
import '../repository/locale_repository.dart' as _i22;
import '../repository/refresh_repository.dart' as _i25;
import '../repository/secure_storage/auth_storage.dart' as _i19;
import '../repository/secure_storage/secure_storage.dart' as _i9;
import '../repository/settings_repository.dart' as _i27;
import '../repository/shared_prefs/local_storage.dart' as _i21;
import '../utils/cache/cache_controller.dart' as _i5;
import '../utils/cache/cache_controlling.dart' as _i4;
import '../vms/drafts/draft_editor_vm.dart' as _i35;
import '../vms/drafts/draft_presentor_vm.dart' as _i36;
import '../vms/global_vm.dart' as _i37;
import '../vms/home/home_vm.dart' as _i38;
import '../vms/home/home_web_vm.dart' as _i39;
import '../vms/home/info_vm.dart' as _i40;
import '../vms/home/onboarding_vm.dart' as _i23;
import '../vms/lists/list_popup_vm.dart' as _i41;
import '../vms/lists/list_view_vm.dart' as _i42;
import '../vms/manage/settings_vm.dart' as _i28;
import '../vms/selection/progress_vm.dart' as _i24;
import '../vms/selection/selection_vm.dart' as _i26;
import '../vms/songs/song_editor_vm.dart' as _i31;
import '../vms/songs/song_presentor_vm.dart' as _i32;
import '../vms/splash_vm.dart' as _i33;
import '../vms/user/signin_vm.dart' as _i29;
import '../vms/user/signup_vm.dart' as _i30;
import '../vms/user/user_vm.dart' as _i34;
import '../webservice/app_web_service.dart' as _i3;
import 'injectable.dart' as _i43; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.AppWebService>(() => _i3.AppWebService());
  gh.singleton<_i4.CacheControlling>(_i5.CacheController());
  gh.singleton<_i6.ConnectivityHelper>(registerModule.connectivityHelper());
  await gh.singletonAsync<_i7.DatabaseConnection>(
    () => registerModule.provideDatabaseConnection(),
    preResolve: true,
  );
  gh.lazySingleton<_i8.FlutterSecureStorage>(() => registerModule.storage());
  gh.lazySingleton<_i9.SecureStorage>(
      () => _i9.SecureStorage(get<_i8.FlutterSecureStorage>()));
  await gh.singletonAsync<_i10.SharedPreferences>(
    () => registerModule.prefs(),
    preResolve: true,
  );
  gh.lazySingleton<_i11.SongLibDB>(
      () => registerModule.provideSongLibDB(get<_i7.DatabaseConnection>()));
  gh.lazySingleton<_i12.BookDao>(() => _i12.BookDao(get<_i11.SongLibDB>()));
  gh.lazySingleton<_i13.DraftDao>(() => _i13.DraftDao(get<_i11.SongLibDB>()));
  gh.lazySingleton<_i14.EditDao>(() => _i14.EditDao(get<_i11.SongLibDB>()));
  gh.lazySingleton<_i15.HistoryDao>(
      () => _i15.HistoryDao(get<_i11.SongLibDB>()));
  gh.lazySingleton<_i16.ListedDao>(() => _i16.ListedDao(get<_i11.SongLibDB>()));
  gh.lazySingleton<_i17.SearchDao>(() => _i17.SearchDao(get<_i11.SongLibDB>()));
  gh.lazySingleton<_i6.SharedPreferenceStorage>(
      () => registerModule.sharedPreferences(get<_i10.SharedPreferences>()));
  gh.lazySingleton<_i6.SimpleKeyValueStorage>(
      () => registerModule.keyValueStorage(
            get<_i6.SharedPreferenceStorage>(),
            get<_i9.SecureStorage>(),
          ));
  gh.lazySingleton<_i18.SongDao>(() => _i18.SongDao(get<_i11.SongLibDB>()));
  gh.lazySingleton<_i19.AuthStorage>(
      () => _i19.AuthStorage(get<_i6.SimpleKeyValueStorage>()));
  gh.lazySingleton<_i20.DbRepository>(() => _i20.DbRepository(
        get<_i12.BookDao>(),
        get<_i13.DraftDao>(),
        get<_i14.EditDao>(),
        get<_i15.HistoryDao>(),
        get<_i16.ListedDao>(),
        get<_i17.SearchDao>(),
        get<_i18.SongDao>(),
      ));
  gh.lazySingleton<_i21.LocalStorage>(() => _i21.LocalStorage(
        get<_i19.AuthStorage>(),
        get<_i6.SharedPreferenceStorage>(),
      ));
  gh.lazySingleton<_i22.LocaleRepository>(
      () => _i22.LocaleRepository(get<_i6.SharedPreferenceStorage>()));
  gh.factory<_i23.OnboardingVm>(
      () => _i23.OnboardingVm(get<_i21.LocalStorage>()));
  gh.factory<_i24.ProgressVm>(() => _i24.ProgressVm(
        get<_i3.AppWebService>(),
        get<_i20.DbRepository>(),
        get<_i21.LocalStorage>(),
      ));
  gh.lazySingleton<_i25.RefreshRepository>(
      () => _i25.RefreshRepository(get<_i19.AuthStorage>()));
  gh.factory<_i26.SelectionVm>(() => _i26.SelectionVm(
        get<_i3.AppWebService>(),
        get<_i20.DbRepository>(),
        get<_i21.LocalStorage>(),
      ));
  gh.lazySingleton<_i27.SettingsRepository>(
      () => _i27.SettingsRepository(get<_i6.SharedPreferenceStorage>()));
  gh.factory<_i28.SettingsVm>(() => _i28.SettingsVm(
        get<_i20.DbRepository>(),
        get<_i21.LocalStorage>(),
      ));
  gh.factory<_i29.SigninVm>(() => _i29.SigninVm(get<_i21.LocalStorage>()));
  gh.factory<_i30.SignupVm>(() => _i30.SignupVm(get<_i21.LocalStorage>()));
  gh.factory<_i31.SongEditorVm>(() => _i31.SongEditorVm(
        get<_i20.DbRepository>(),
        get<_i21.LocalStorage>(),
      ));
  gh.factory<_i32.SongPresentorVm>(() => _i32.SongPresentorVm(
        get<_i20.DbRepository>(),
        get<_i21.LocalStorage>(),
      ));
  gh.factory<_i33.SplashVm>(() => _i33.SplashVm(get<_i21.LocalStorage>()));
  gh.factory<_i34.UserVm>(() => _i34.UserVm(get<_i21.LocalStorage>()));
  gh.factory<_i35.DraftEditorVm>(() => _i35.DraftEditorVm(
        get<_i20.DbRepository>(),
        get<_i21.LocalStorage>(),
      ));
  gh.factory<_i36.DraftPresentorVm>(() => _i36.DraftPresentorVm(
        get<_i20.DbRepository>(),
        get<_i21.LocalStorage>(),
      ));
  gh.singleton<_i37.GlobalVm>(_i37.GlobalVm(
    get<_i22.LocaleRepository>(),
    get<_i27.SettingsRepository>(),
    get<_i21.LocalStorage>(),
  ));
  gh.singleton<_i38.HomeVm>(_i38.HomeVm(
    get<_i20.DbRepository>(),
    get<_i21.LocalStorage>(),
  ));
  gh.factory<_i39.HomeWebVm>(() => _i39.HomeWebVm(
        get<_i3.AppWebService>(),
        get<_i20.DbRepository>(),
        get<_i21.LocalStorage>(),
      ));
  gh.factory<_i40.InfoVm>(() => _i40.InfoVm(get<_i21.LocalStorage>()));
  gh.factory<_i41.ListPopupVm>(() => _i41.ListPopupVm(
        get<_i20.DbRepository>(),
        get<_i21.LocalStorage>(),
      ));
  gh.factory<_i42.ListViewVm>(() => _i42.ListViewVm(
        get<_i20.DbRepository>(),
        get<_i21.LocalStorage>(),
      ));
  return get;
}

class _$RegisterModule extends _i43.RegisterModule {}
