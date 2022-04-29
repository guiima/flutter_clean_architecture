import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/modules/search/presenter/search_page.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'modules/search/data/repositories/search_repository_impl.dart';
import 'modules/search/domain/usecases/search_text.dart';
import 'modules/search/external/datasources/github_datasource.dart';
import 'modules/search/presenter/search/search_bloc.dart';
import 'modules/search/presenter/search/state/search_state.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => Dio()),
        Bind((i) => GithubDatasource(i())),
        Bind((i) => SearchRepositoryImpl(i())),
        Bind((i) => SearchTextImpl(i())),
        Bind((i) => SearchBloc(SearchStart(), i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const SearchPage(),
        ),
      ];
}
