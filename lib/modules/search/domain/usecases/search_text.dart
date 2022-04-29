import 'package:flutter_clean_architecture/modules/search/domain/entities/result_search.dart';
import 'package:flutter_clean_architecture/modules/search/domain/errors/errors.dart';
import 'package:flutter_clean_architecture/modules/search/domain/repositories/search_repository.dart';
import 'package:dartz/dartz.dart';

abstract class SearchText {
  Future<Either<FailureSearch, List<ResultSearch>>> searchText(
      String searchText);
}

class SearchTextImpl implements SearchText {
  final SearchRepository _searchRepository;

  SearchTextImpl(this._searchRepository);

  @override
  Future<Either<FailureSearch, List<ResultSearch>>> searchText(
      String searchText) async {
    if (searchText.isEmpty) {
      return Left(InvalidTextError('O Texto não pode ser vazio!'));
    }
    return await _searchRepository.search(searchText);
  }
}
