import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/modules/search/data/datasources/source_datasource.dart';
import 'package:flutter_clean_architecture/modules/search/data/repositories/search_repository_impl.dart';
import 'package:flutter_clean_architecture/modules/search/domain/entities/result_search.dart';
import 'package:flutter_clean_architecture/modules/search/domain/errors/errors.dart';
import 'package:flutter_clean_architecture/modules/search/domain/repositories/search_repository.dart';
import 'package:flutter_clean_architecture/modules/search/domain/usecases/search_text.dart';
import 'package:flutter_clean_architecture/modules/search/external/datasources/github_datasource.dart';
import 'package:flutter_clean_architecture/modules/search/presenter/search/search_bloc.dart';
import 'package:flutter_clean_architecture/modules/search/presenter/search/state/search_event.dart';
import 'package:flutter_clean_architecture/modules/search/presenter/search/state/search_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class SearchTextMock extends Mock implements SearchText {}

class DioMock extends Mock implements Dio {}

void main() {
  late SearchBloc bloc;
  late SearchText usecase;
  late String searchText;

  setUp(() {
    usecase = SearchTextMock();
    searchText = 'guiima';
    bloc = SearchBloc(SearchStart(), usecase);
  });

  blocTest(
    'deve retornar os estados na ordem correta',
    build: () => bloc,
    act: (SearchBloc bloc) {
      when(() => usecase.searchText(searchText))
          .thenAnswer((_) async => const Right(<ResultSearch>[]));

      bloc.add(SearchignText(searchText));
    },
    expect: () => [
      isA<SearchLoading>(),
      isA<SearchSuccess>(),
    ],
  );

  blocTest(
    'deve retornar um erro',
    build: () => bloc,
    act: (SearchBloc bloc) {
      when(() => usecase.searchText(searchText))
          .thenAnswer((_) async => Left(InvalidTextError('')));

      bloc.add(SearchignText(searchText));
    },
    expect: () => [
      isA<SearchLoading>(),
      isA<SearchEror>(),
    ],
  );
}
