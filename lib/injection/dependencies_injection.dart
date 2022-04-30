import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/modules/search/data/datasources/source_datasource.dart';
import 'package:flutter_clean_architecture/modules/search/data/repositories/search_repository_impl.dart';
import 'package:flutter_clean_architecture/modules/search/domain/repositories/search_repository.dart';
import 'package:flutter_clean_architecture/modules/search/domain/usecases/search_text.dart';
import 'package:flutter_clean_architecture/modules/search/external/datasources/github_datasource.dart';
import 'package:flutter_clean_architecture/modules/search/presenter/bloc/search_bloc.dart';
import 'package:flutter_clean_architecture/modules/search/presenter/bloc/state/search_state.dart';
import 'package:flutter_clean_architecture/modules/search/presenter/controller/search_controller.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void injectDependencies() {
  if (!getIt.isRegistered<Dio>()) {
    getIt.registerFactory<Dio>(() => Dio());
  }

  if (!getIt.isRegistered<SearchDataSource>()) {
    getIt.registerFactory<SearchDataSource>(
      () => GithubDatasource(dio: getIt()),
    );
  }

  if (!getIt.isRegistered<SearchRepository>()) {
    getIt.registerFactory<SearchRepository>(
      () => SearchRepositoryImpl(datasource: getIt()),
    );
  }

  if (!getIt.isRegistered<SearchText>()) {
    getIt.registerFactory<SearchText>(
      () => SearchTextImpl(searchRepository: getIt()),
    );
  }

  if (!getIt.isRegistered<SearchBloc>()) {
    getIt.registerFactory<SearchBloc>(
      () => SearchBloc(SearchStart(), getIt()),
    );
  }

  if (!getIt.isRegistered<SearchController>()) {
    getIt.registerFactory<SearchController>(
      () => SearchController(usecase: getIt()),
    );
  }
}
