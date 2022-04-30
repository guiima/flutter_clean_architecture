import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/modules/search/data/models/result_search_model.dart';
import 'package:flutter_clean_architecture/modules/search/domain/entities/result_search.dart';
import 'package:flutter_clean_architecture/modules/search/domain/errors/errors.dart';
import 'package:flutter_clean_architecture/modules/search/external/datasources/github_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../utils/github_response.dart';

class DioMock extends Mock implements Dio {}

void main() {
  late DioMock dio;
  late String path;
  late GithubDatasource datasource;
  late String searchText;

  setUp(() {
    dio = DioMock();
    datasource = GithubDatasource(dio: dio);
    path = 'https://api.github.com/search/users?q=guiima';
    searchText = 'guiima';
  });

  test('deve retornar uma lista de ResultSearchModel', () async {
    when(() => dio.get(path)).thenAnswer((_) async => Response(
        requestOptions: RequestOptions(path: path),
        data: jsonDecode(githubResult),
        statusCode: 200));

    final response = await datasource.getSearch(searchText);
    expect(response, isA<List<ResultSearchModel>>());
  });

  test('deve retornar um DatasourceError se o statusCode for diferente de 200',
      () async {
    when(() => dio.get(path)).thenAnswer((_) async => Response(
        requestOptions: RequestOptions(path: path),
        data: null,
        statusCode: 404));

    final response = datasource.getSearch(searchText);
    expect(response, throwsA(isA<DatasourceError>()));
  });

  test('deve retornar um Exception se tiver um erro no Dio', () async {
    when(() => dio.get(path)).thenThrow(Exception());

    final response = datasource.getSearch(searchText);
    expect(response, throwsA(isA<Exception>()));
  });
}
