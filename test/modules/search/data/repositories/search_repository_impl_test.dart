import 'package:flutter_clean_architecture/modules/search/data/datasources/source_datasource.dart';
import 'package:flutter_clean_architecture/modules/search/data/models/result_search_model.dart';
import 'package:flutter_clean_architecture/modules/search/data/repositories/search_repository_impl.dart';
import 'package:flutter_clean_architecture/modules/search/domain/entities/result_search.dart';
import 'package:flutter_clean_architecture/modules/search/domain/errors/errors.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class SearchDataSourceMock extends Mock implements SearchDataSource {}

void main() {
  late SearchDataSourceMock datasource;
  late SearchRepositoryImpl repository;
  late String searchText;

  setUp(() {
    datasource = SearchDataSourceMock();
    repository = SearchRepositoryImpl(datasource);
    searchText = 'search text';
  });

  test('deve retornar uma lista de ResultSearch', () async {
    when(() => datasource.getSearch(searchText))
        .thenAnswer((_) async => <ResultSearchModel>[]);

    final _response = await repository.search(searchText);
    final _result = _response.fold((l) => l, (r) => r);

    expect(_result, isA<List<ResultSearch>>());
  });

  test('deve retornar um DatasourceError se o datasouce flhar', () async {
    when(() => datasource.getSearch(searchText)).thenThrow(Exception());

    final _response = await repository.search(searchText);
    final _result = _response.fold((l) => l, (r) => r);

    expect(_result, isA<DatasourceError>());
  });
}
