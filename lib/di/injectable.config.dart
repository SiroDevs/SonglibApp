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

import '../db/dao/book_dao.dart' as _i13;
import '../db/dao/draft_dao.dart' as _i14;
import '../db/dao/edit_dao.dart' as _i15;
import '../db/dao/history_dao.dart' as _i16;
import '../db/dao/listed_dao.dart' as _i17;
import '../db/dao/search_dao.dart' as _i18;
import '../db/dao/song_dao.dart' as _i19;
import '../db/songlib_db.dart' as _i11;
import '../repository/db_repository.dart' as _i21;
import '../repository/locale_repository.dart' as _i23;
import '../repository/refresh_repository.dart' as _i26;
import '../repository/secure_storage/auth_storage.dart' as _i20;
import '../repository/secure_storage/secure_storage.dart' as _i9;
import '../repository/settings_repository.dart' as _i28;
import '../repository/shared_prefs/local_storage.dart' as _i22;
import '../repository/web_repository.dart' as _i36;
import '../utils/cache/cache_controller.dart' as _i5;
import '../utils/cache/cache_controlling.dart' as _i4;
import '../vms/drafts/draft_editor_vm.dart' as _i37;
import '../vms/drafts/draft_presentor_vm.dart' as _i38;
import '../vms/global_vm.dart' as _i39;
import '../vms/home/home_vm.dart' as _i40;
import '../vms/home/home_web_vm.dart' as _i41;
import '../vms/home/info_vm.dart' as _i42;
import '../vms/home/onboarding_vm.dart' as _i24;
import '../vms/lists/list_popup_vm.dart' as _i43;
import '../vms/lists/list_view_vm.dart' as _i44;
import '../vms/manage/settings_vm.dart' as _i29;
import '../vms/selection/progress_vm.dart' as _i25;
import '../vms/selection/selection_vm.dart' as _i27;
import '../vms/songs/song_editor_vm.dart' as _i32;
import '../vms/songs/song_presentor_vm.dart' as _i33;
import '../vms/splash_vm.dart' as _i34;
import '../vms/user/signin_vm.dart' as _i30;
import '../vms/user/signup_vm.dart' as _i31;
import '../vms/user/user_vm.dart' as _i35;
import '../webservice/app_web_service.dart' as _i3;
import '../webservice/song_web_service.dart' as _i12;
import 'injectable.dart' as _i45; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i12.SongWebService>(() => _i12.SongWebService());
  gh.lazySingleton<_i13.BookDao>(() => _i13.BookDao(get<_i11.SongLibDB>()));
  gh.lazySingleton<_i14.DraftDao>(() => _i14.DraftDao(get<_i11.SongLibDB>()));
  gh.lazySingleton<_i15.EditDao>(() => _i15.EditDao(get<_i11.SongLibDB>()));
  gh.lazySingleton<_i16.HistoryDao>(
      () => _i16.HistoryDao(get<_i11.SongLibDB>()));
  gh.lazySingleton<_i17.ListedDao>(() => _i17.ListedDao(get<_i11.SongLibDB>()));
  gh.lazySingleton<_i18.SearchDao>(() => _i18.SearchDao(get<_i11.SongLibDB>()));
  gh.lazySingleton<_i6.SharedPreferenceStorage>(
      () => registerModule.sharedPreferences(get<_i10.SharedPreferences>()));
  gh.lazySingleton<_i6.SimpleKeyValueStorage>(
      () => registerModule.keyValueStorage(
            get<_i6.SharedPreferenceStorage>(),
            get<_i9.SecureStorage>(),
          ));
  gh.lazySingleton<_i19.SongDao>(() => _i19.SongDao(get<_i11.SongLibDB>()));
  gh.lazySingleton<_i20.AuthStorage>(
      () => _i20.AuthStorage(get<_i6.SimpleKeyValueStorage>()));
  gh.lazySingleton<_i21.DbRepository>(() => _i21.DbRepository(
        get<_i13.BookDao>(),
        get<_i14.DraftDao>(),
        get<_i15.EditDao>(),
        get<_i16.HistoryDao>(),
        get<_i17.ListedDao>(),
        get<_i18.SearchDao>(),
        get<_i19.SongDao>(),
      ));
  gh.lazySingleton<_i22.LocalStorage>(() => _i22.LocalStorage(
        get<_i20.AuthStorage>(),
        get<_i6.SharedPreferenceStorage>(),
      ));
  gh.lazySingleton<_i23.LocaleRepository>(
      () => _i23.LocaleRepository(get<_i6.SharedPreferenceStorage>()));
  gh.factory<_i24.OnboardingVm>(
      () => _i24.OnboardingVm(get<_i22.LocalStorage>()));
  gh.factory<_i25.ProgressVm>(() => _i25.ProgressVm(
        get<_i3.AppWebService>(),
        get<_i21.DbRepository>(),
        get<_i22.LocalStorage>(),
      ));
  gh.lazySingleton<_i26.RefreshRepository>(
      () => _i26.RefreshRepository(get<_i20.AuthStorage>()));
  gh.factory<_i27.SelectionVm>(() => _i27.SelectionVm(
        get<_i3.AppWebService>(),
        get<_i21.DbRepository>(),
        get<_i22.LocalStorage>(),
      ));
  gh.lazySingleton<_i28.SettingsRepository>(
      () => _i28.SettingsRepository(get<_i6.SharedPreferenceStorage>()));
  gh.factory<_i29.SettingsVm>(() => _i29.SettingsVm(
        get<_i21.DbRepository>(),
        get<_i22.LocalStorage>(),
      ));
  gh.factory<_i30.SigninVm>(() => _i30.SigninVm(get<_i22.LocalStorage>()));
  gh.factory<_i31.SignupVm>(() => _i31.SignupVm(get<_i22.LocalStorage>()));
  gh.factory<_i32.SongEditorVm>(() => _i32.SongEditorVm(
        get<_i21.DbRepository>(),
        get<_i22.LocalStorage>(),
      ));
  gh.factory<_i33.SongPresentorVm>(() => _i33.SongPresentorVm(
        get<_i21.DbRepository>(),
        get<_i22.LocalStorage>(),
      ));
  gh.factory<_i34.SplashVm>(() => _i34.SplashVm(get<_i22.LocalStorage>()));
  gh.factory<_i35.UserVm>(() => _i35.UserVm(get<_i22.LocalStorage>()));
  gh.lazySingleton<_i36.WebRepository>(() => _i36.WebRepository(
        get<_i22.LocalStorage>(),
        get<_i12.SongWebService>(),
      ));
  gh.factory<_i37.DraftEditorVm>(() => _i37.DraftEditorVm(
        get<_i21.DbRepository>(),
        get<_i22.LocalStorage>(),
      ));
  gh.factory<_i38.DraftPresentorVm>(() => _i38.DraftPresentorVm(
        get<_i21.DbRepository>(),
        get<_i22.LocalStorage>(),
      ));
  gh.singleton<_i39.GlobalVm>(_i39.GlobalVm(
    get<_i23.LocaleRepository>(),
    get<_i28.SettingsRepository>(),
    get<_i22.LocalStorage>(),
  ));
  gh.singleton<_i40.HomeVm>(_i40.HomeVm(
    get<_i21.DbRepository>(),
    get<_i22.LocalStorage>(),
  ));
  gh.factory<_i41.HomeWebVm>(() => _i41.HomeWebVm(
        get<_i3.AppWebService>(),
        get<_i21.DbRepository>(),
        get<_i22.LocalStorage>(),
      ));
  gh.factory<_i42.InfoVm>(() => _i42.InfoVm(get<_i22.LocalStorage>()));
  gh.factory<_i43.ListPopupVm>(() => _i43.ListPopupVm(
        get<_i21.DbRepository>(),
        get<_i22.LocalStorage>(),
      ));
  gh.factory<_i44.ListViewVm>(() => _i44.ListViewVm(
        get<_i21.DbRepository>(),
        get<_i22.LocalStorage>(),
      ));
  return get;
}

class _$RegisterModule extends _i45.RegisterModule {}
