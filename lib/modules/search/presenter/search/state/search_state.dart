import 'package:flutter_clean_architecture/modules/search/domain/entities/result_search.dart';
import 'package:flutter_clean_architecture/modules/search/domain/errors/errors.dart';

abstract class SearchState {}

class SearchSuccess implements SearchState {
  final List<ResultSearch> list;

  SearchSuccess(this.list);
}

class SearchStart implements SearchState {}

class SearchLoading implements SearchState {}

class SearchEror implements SearchState {
  final FailureSearch error;

  SearchEror(this.error);
}
