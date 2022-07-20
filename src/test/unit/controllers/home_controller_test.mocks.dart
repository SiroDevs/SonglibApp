// Mocks generated by Mockito 5.2.0 from annotations
// in songlib/test/unit/controllers/home_controller_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;
import 'dart:ui' as _i8;

import 'package:flutter/material.dart' as _i3;
import 'package:get/get.dart' as _i4;
import 'package:get/get_state_manager/src/simple/list_notifier.dart' as _i7;
import 'package:get_storage/get_storage.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:songlib/exports.dart' as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeGetStorage_0 extends _i1.Fake implements _i2.GetStorage {}

class _FakeScrollController_1 extends _i1.Fake implements _i3.ScrollController {
}

class _FakeInternalFinalCallback_2<T> extends _i1.Fake
    implements _i4.InternalFinalCallback<T> {}

/// A class which mocks [HomeController].
///
/// See the documentation for Mockito's code generation for more information.
class MockHomeController extends _i1.Mock implements _i5.HomeController {
  MockHomeController() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetStorage get userData =>
      (super.noSuchMethod(Invocation.getter(#userData),
          returnValue: _FakeGetStorage_0()) as _i2.GetStorage);
  @override
  _i3.ScrollController get bookListScrollController =>
      (super.noSuchMethod(Invocation.getter(#bookListScrollController),
          returnValue: _FakeScrollController_1()) as _i3.ScrollController);
  @override
  _i3.ScrollController get songListScrollController =>
      (super.noSuchMethod(Invocation.getter(#songListScrollController),
          returnValue: _FakeScrollController_1()) as _i3.ScrollController);
  @override
  bool get isLoading =>
      (super.noSuchMethod(Invocation.getter(#isLoading), returnValue: false)
          as bool);
  @override
  set isLoading(bool? _isLoading) =>
      super.noSuchMethod(Invocation.setter(#isLoading, _isLoading),
          returnValueForMissingStub: null);
  @override
  bool get isSearching =>
      (super.noSuchMethod(Invocation.getter(#isSearching), returnValue: false)
          as bool);
  @override
  set isSearching(bool? _isSearching) =>
      super.noSuchMethod(Invocation.setter(#isSearching, _isSearching),
          returnValueForMissingStub: null);
  @override
  String get selectedBooks =>
      (super.noSuchMethod(Invocation.getter(#selectedBooks), returnValue: '')
          as String);
  @override
  set selectedBooks(String? _selectedBooks) =>
      super.noSuchMethod(Invocation.setter(#selectedBooks, _selectedBooks),
          returnValueForMissingStub: null);
  @override
  int get mainBook =>
      (super.noSuchMethod(Invocation.getter(#mainBook), returnValue: 0) as int);
  @override
  set mainBook(int? _mainBook) =>
      super.noSuchMethod(Invocation.setter(#mainBook, _mainBook),
          returnValueForMissingStub: null);
  @override
  set books(List<_i5.Book>? _books) =>
      super.noSuchMethod(Invocation.setter(#books, _books),
          returnValueForMissingStub: null);
  @override
  set fullList(List<_i5.Song>? _fullList) =>
      super.noSuchMethod(Invocation.setter(#fullList, _fullList),
          returnValueForMissingStub: null);
  @override
  set bookList(List<_i5.Song>? _bookList) =>
      super.noSuchMethod(Invocation.setter(#bookList, _bookList),
          returnValueForMissingStub: null);
  @override
  set db(_i5.MyDatabase? _db) => super.noSuchMethod(Invocation.setter(#db, _db),
      returnValueForMissingStub: null);
  @override
  int get selectedTab =>
      (super.noSuchMethod(Invocation.getter(#selectedTab), returnValue: 0)
          as int);
  @override
  set selectedTab(int? _selectedTab) =>
      super.noSuchMethod(Invocation.setter(#selectedTab, _selectedTab),
          returnValueForMissingStub: null);
  @override
  _i4.InternalFinalCallback<void> get onStart =>
      (super.noSuchMethod(Invocation.getter(#onStart),
              returnValue: _FakeInternalFinalCallback_2<void>())
          as _i4.InternalFinalCallback<void>);
  @override
  _i4.InternalFinalCallback<void> get onDelete =>
      (super.noSuchMethod(Invocation.getter(#onDelete),
              returnValue: _FakeInternalFinalCallback_2<void>())
          as _i4.InternalFinalCallback<void>);
  @override
  bool get initialized =>
      (super.noSuchMethod(Invocation.getter(#initialized), returnValue: false)
          as bool);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  int get listeners =>
      (super.noSuchMethod(Invocation.getter(#listeners), returnValue: 0)
          as int);
  @override
  void onInit() => super.noSuchMethod(Invocation.method(#onInit, []),
      returnValueForMissingStub: null);
  @override
  void onReady() => super.noSuchMethod(Invocation.method(#onReady, []),
      returnValueForMissingStub: null);
  @override
  void onClose() => super.noSuchMethod(Invocation.method(#onClose, []),
      returnValueForMissingStub: null);
  @override
  void onTabTapped(int? index) =>
      super.noSuchMethod(Invocation.method(#onTabTapped, [index]),
          returnValueForMissingStub: null);
  @override
  _i6.Future<List<_i5.Book>?> fetchBookList() =>
      (super.noSuchMethod(Invocation.method(#fetchBookList, []),
              returnValue: Future<List<_i5.Book>?>.value())
          as _i6.Future<List<_i5.Book>?>);
  @override
  _i6.Future<List<_i5.Song>?> fetchFullSongList() =>
      (super.noSuchMethod(Invocation.method(#fetchFullSongList, []),
              returnValue: Future<List<_i5.Song>?>.value())
          as _i6.Future<List<_i5.Song>?>);
  @override
  _i6.Future<List<_i5.Song>?> fetchBookSongList() =>
      (super.noSuchMethod(Invocation.method(#fetchBookSongList, []),
              returnValue: Future<List<_i5.Song>?>.value())
          as _i6.Future<List<_i5.Song>?>);
  @override
  _i6.Future<void> resetBookSongList(_i5.Book? book) =>
      (super.noSuchMethod(Invocation.method(#resetBookSongList, [book]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  void update([List<Object>? ids, bool? condition = true]) =>
      super.noSuchMethod(Invocation.method(#update, [ids, condition]),
          returnValueForMissingStub: null);
  @override
  void $configureLifeCycle() =>
      super.noSuchMethod(Invocation.method(#$configureLifeCycle, []),
          returnValueForMissingStub: null);
  @override
  _i7.Disposer addListener(_i7.GetStateUpdate? listener) =>
      (super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValue: () {}) as _i7.Disposer);
  @override
  void removeListener(_i8.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void refresh() => super.noSuchMethod(Invocation.method(#refresh, []),
      returnValueForMissingStub: null);
  @override
  void refreshGroup(Object? id) =>
      super.noSuchMethod(Invocation.method(#refreshGroup, [id]),
          returnValueForMissingStub: null);
  @override
  void notifyChildrens() =>
      super.noSuchMethod(Invocation.method(#notifyChildrens, []),
          returnValueForMissingStub: null);
  @override
  void removeListenerId(Object? id, _i8.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListenerId, [id, listener]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  _i7.Disposer addListenerId(Object? key, _i7.GetStateUpdate? listener) =>
      (super.noSuchMethod(Invocation.method(#addListenerId, [key, listener]),
          returnValue: () {}) as _i7.Disposer);
  @override
  void disposeId(Object? id) =>
      super.noSuchMethod(Invocation.method(#disposeId, [id]),
          returnValueForMissingStub: null);
}
