import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/modules/search/domain/entities/result_search.dart';
import 'package:flutter_clean_architecture/modules/search/domain/errors/errors.dart';
import 'package:flutter_clean_architecture/modules/search/domain/repositories/search_repository.dart';
import 'package:flutter_clean_architecture/modules/search/domain/usecases/search_text.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class SearchRepositoryMock extends Mock implements SearchRepository {}

void main() {
  late SearchRepositoryMock repositoryMock;
  late SearchTextImpl searchTextImpl;
  late String searchText;

  setUp(() {
    repositoryMock = SearchRepositoryMock();
    searchTextImpl = SearchTextImpl(repositoryMock);
    searchText = 'search text';
  });

  test('deve retornar uma lista de ResultSearch', () async {
    when(() => repositoryMock.search(searchText))
        .thenAnswer((_) async => const Right(<ResultSearch>[]));

    final _response = await searchTextImpl.searchText(searchText);
    final _result = _response.fold((l) => l, (r) => r);

    expect(_result, isNotNull);
    expect(_result, isA<List<ResultSearch>>());
  });

  test('deve retornar uma Exception caso o texto seja inválido', () async {
    when(() => repositoryMock.search(searchText))
        .thenAnswer((_) async => const Right(<ResultSearch>[]));

    final _response = await searchTextImpl.searchText('');
    final _result = _response.fold((l) => l, (r) => r);

    expect(_result, isNotNull);
    expect(_result, isA<InvalidTextError>());
  });
}
