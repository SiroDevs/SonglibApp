// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:drift/drift.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i7;

import '../db/app_database.dart' as _i9;
import '../db/dao/app_dao.dart' as _i23;
import '../db/dao/book_dao.dart' as _i10;
import '../db/dao/draft_dao.dart' as _i11;
import '../db/dao/edit_dao.dart' as _i12;
import '../db/dao/history_dao.dart' as _i13;
import '../db/dao/listed_dao.dart' as _i14;
import '../db/dao/search_dao.dart' as _i17;
import '../db/dao/song_dao.dart' as _i20;
import '../repository/db_repository.dart' as _i25;
import '../repository/local_storage.dart' as _i15;
import '../repository/web_repository.dart' as _i22;
import '../utils/cache/cache_controller.dart' as _i5;
import '../utils/cache/cache_controlling.dart' as _i4;
import '../viewmodels/drafts/draft_editor_vm.dart' as _i26;
import '../viewmodels/drafts/draft_presentor_vm.dart' as _i27;
import '../viewmodels/global_vm.dart' as _i24;
import '../viewmodels/home/home_vm.dart' as _i28;
import '../viewmodels/home/home_web_vm.dart' as _i29;
import '../viewmodels/home/info_vm.dart' as _i30;
import '../viewmodels/home/onboarding_vm.dart' as _i16;
import '../viewmodels/lists/list_popup_vm.dart' as _i31;
import '../viewmodels/lists/list_view_vm.dart' as _i32;
import '../viewmodels/manage/settings_vm.dart' as _i34;
import '../viewmodels/selection/selection_vm.dart' as _i33;
import '../viewmodels/songs/song_editor_vm.dart' as _i35;
import '../viewmodels/songs/song_presentor_vm.dart' as _i36;
import '../viewmodels/splash_vm.dart' as _i37;
import '../viewmodels/user/signin_vm.dart' as _i18;
import '../viewmodels/user/signup_vm.dart' as _i19;
import '../viewmodels/user/user_vm.dart' as _i21;
import '../webservice/book_web_service.dart' as _i3;
import '../webservice/song_web_service.dart' as _i8;
import 'injectable.dart' as _i38; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i3.BookWebService>(() => _i3.BookWebService());
  gh.singleton<_i4.CacheControlling>(_i5.CacheController());
  await gh.singletonAsync<_i6.DatabaseConnection>(
    () => registerModule.provideDatabaseConnection(),
    preResolve: true,
  );
  await gh.singletonAsync<_i7.SharedPreferences>(
    () => registerModule.prefs(),
    preResolve: true,
  );
  gh.lazySingleton<_i8.SongWebService>(() => _i8.SongWebService());
  gh.lazySingleton<_i9.AppDatabase>(
      () => registerModule.provideAppDatabase(get<_i6.DatabaseConnection>()));
  gh.lazySingleton<_i10.BookDao>(() => _i10.BookDao(get<_i9.AppDatabase>()));
  gh.lazySingleton<_i11.DraftDao>(() => _i11.DraftDao(get<_i9.AppDatabase>()));
  gh.lazySingleton<_i12.EditDao>(() => _i12.EditDao(get<_i9.AppDatabase>()));
  gh.lazySingleton<_i13.HistoryDao>(
      () => _i13.HistoryDao(get<_i9.AppDatabase>()));
  gh.lazySingleton<_i14.ListedDao>(
      () => _i14.ListedDao(get<_i9.AppDatabase>()));
  gh.lazySingleton<_i15.LocalStorage>(
      () => _i15.LocalStorage(get<_i7.SharedPreferences>()));
  gh.factory<_i16.OnboardingVm>(
      () => _i16.OnboardingVm(get<_i15.LocalStorage>()));
  gh.lazySingleton<_i17.SearchDao>(
      () => _i17.SearchDao(get<_i9.AppDatabase>()));
  gh.factory<_i18.SigninVm>(() => _i18.SigninVm(get<_i15.LocalStorage>()));
  gh.factory<_i19.SignupVm>(() => _i19.SignupVm(get<_i15.LocalStorage>()));
  gh.lazySingleton<_i20.SongDao>(() => _i20.SongDao(get<_i9.AppDatabase>()));
  gh.factory<_i21.UserVm>(() => _i21.UserVm(get<_i15.LocalStorage>()));
  gh.lazySingleton<_i22.WebRepository>(() => _i22.WebRepository(
        get<_i15.LocalStorage>(),
        get<_i3.BookWebService>(),
        get<_i8.SongWebService>(),
      ));
  gh.lazySingleton<_i23.AppDao>(() => _i23.AppDao(get<_i9.AppDatabase>()));
  gh.singleton<_i24.AppVm>(_i24.AppVm(get<_i15.LocalStorage>()));
  gh.lazySingleton<_i25.DbRepository>(() => _i25.DbRepository(
        get<_i23.AppDao>(),
        get<_i10.BookDao>(),
        get<_i11.DraftDao>(),
        get<_i12.EditDao>(),
        get<_i13.HistoryDao>(),
        get<_i14.ListedDao>(),
        get<_i17.SearchDao>(),
        get<_i20.SongDao>(),
      ));
  gh.factory<_i26.DraftEditorVm>(() => _i26.DraftEditorVm(
        get<_i25.DbRepository>(),
        get<_i15.LocalStorage>(),
      ));
  gh.factory<_i27.DraftPresentorVm>(() => _i27.DraftPresentorVm(
        get<_i25.DbRepository>(),
        get<_i15.LocalStorage>(),
      ));
  gh.singleton<_i28.HomeVm>(_i28.HomeVm(
    get<_i25.DbRepository>(),
    get<_i15.LocalStorage>(),
  ));
  gh.factory<_i29.HomeWebVm>(() => _i29.HomeWebVm(
        get<_i22.WebRepository>(),
        get<_i25.DbRepository>(),
        get<_i15.LocalStorage>(),
      ));
  gh.factory<_i30.InfoVm>(() => _i30.InfoVm(get<_i15.LocalStorage>()));
  gh.factory<_i31.ListPopupVm>(() => _i31.ListPopupVm(
        get<_i25.DbRepository>(),
        get<_i15.LocalStorage>(),
      ));
  gh.factory<_i32.ListViewVm>(() => _i32.ListViewVm(
        get<_i25.DbRepository>(),
        get<_i15.LocalStorage>(),
      ));
  gh.factory<_i33.SelectionVm>(() => _i33.SelectionVm(
        get<_i22.WebRepository>(),
        get<_i25.DbRepository>(),
        get<_i15.LocalStorage>(),
      ));
  gh.factory<_i34.SettingsVm>(() => _i34.SettingsVm(
        get<_i25.DbRepository>(),
        get<_i15.LocalStorage>(),
      ));
  gh.factory<_i35.SongEditorVm>(() => _i35.SongEditorVm(
        get<_i25.DbRepository>(),
        get<_i15.LocalStorage>(),
      ));
  gh.factory<_i36.SongPresentorVm>(() => _i36.SongPresentorVm(
        get<_i25.DbRepository>(),
        get<_i15.LocalStorage>(),
      ));
  gh.factory<_i37.SplashVm>(() => _i37.SplashVm(
        get<_i25.DbRepository>(),
        get<_i15.LocalStorage>(),
      ));
  return get;
}

class _$RegisterModule extends _i38.RegisterModule {}
