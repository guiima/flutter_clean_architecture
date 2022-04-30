import 'package:flutter_clean_architecture/modules/search/domain/entities/result_search.dart';
import 'package:flutter_clean_architecture/modules/search/domain/usecases/search_text.dart';
import 'package:mobx/mobx.dart';

part 'search_controller.g.dart';

class SearchController = _SearchController with _$SearchController;

abstract class _SearchController with Store {
  final SearchText usecase;

  _SearchController(this.usecase);

  @observable
  List<ResultSearch> resultSearch = ObservableList.of([]);

  @action
  Future<void> searchignText(String searchText) async {
    if (searchText.isEmpty) {
      resultSearch = <ResultSearch>[];
    } else {
      final response = await usecase.searchText(searchText);
      response.fold((l) => l, (r) {
        resultSearch = r;
      });
    }
  }
}
