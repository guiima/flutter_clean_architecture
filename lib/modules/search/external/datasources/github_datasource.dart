import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/modules/search/data/datasources/source_datasource.dart';
import 'package:flutter_clean_architecture/modules/search/data/models/result_search_model.dart';
import 'package:flutter_clean_architecture/modules/search/domain/errors/errors.dart';

extension on String {
  normalizeToGithub() {
    return replaceAll(' ', '+');
  }
}

class GithubDatasource implements SearchDataSource {
  final Dio dio;

  GithubDatasource({required this.dio});

  @override
  Future<List<ResultSearchModel>> getSearch(String searchText) async {
    final response = await dio.get(
        'https://api.github.com/search/users?q=${searchText.normalizeToGithub()}');

    if (response.statusCode == 200) {
      final list = (response.data['items'] as List)
          .map((e) => ResultSearchModel.fromMap(e))
          .toList();

      return list;
    } else {
      throw DatasourceError();
    }
  }
}
