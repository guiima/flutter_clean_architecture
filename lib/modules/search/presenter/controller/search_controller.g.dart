// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchController on _SearchController, Store {
  late final _$resultSearchAtom =
      Atom(name: '_SearchController.resultSearch', context: context);

  @override
  List<ResultSearch> get resultSearch {
    _$resultSearchAtom.reportRead();
    return super.resultSearch;
  }

  @override
  set resultSearch(List<ResultSearch> value) {
    _$resultSearchAtom.reportWrite(value, super.resultSearch, () {
      super.resultSearch = value;
    });
  }

  late final _$searchignTextAsyncAction =
      AsyncAction('_SearchController.searchignText', context: context);

  @override
  Future<void> searchignText(String searchText) {
    return _$searchignTextAsyncAction
        .run(() => super.searchignText(searchText));
  }

  @override
  String toString() {
    return '''
resultSearch: ${resultSearch}
    ''';
  }
}
