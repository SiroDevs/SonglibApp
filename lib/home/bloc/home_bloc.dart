import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';

import '../../common/data/models/book.dart';
import '../../common/data/models/lists.dart';
import '../../common/data/models/song.dart';
import '../../common/domain/db_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

part 'home_bloc.freezed.dart';

@singleton
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DbRepository dbRepo;
  HomeBloc(this.dbRepo) : super(const HomeState()) {
    on<HomeFetch>(_onFetch);
  }


  Future<void> _onFetch(
    HomeFetch event,
    Emitter<HomeState> emit,
  ) async {
    var books = await dbRepo.fetchBooks();
    emit(
      state.copyWith(
        books: books,
      ),
    );
  }
}
