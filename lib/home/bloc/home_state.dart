part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
    @Default([]) List<Book> books,
    @Default([]) List<SongExt> filtered,
    @Default([]) List<SongExt> songs,
    @Default([]) List<SongExt> likes,
    @Default([]) List<SongExt> listSongs,
    @Default([]) List<String> verses,
    @Default([]) List<String> versesLike,
    @Default([]) List<String> versesDraft,
    @Default([]) List<ListedExt> listedSongs,
    @Default([]) List<Listed> listeds,
    @Default([]) List<Draft> drafts,
    @Default('') String songTitle,
    @Default('') String songTitleL,
  }) = _HomeState;
}
