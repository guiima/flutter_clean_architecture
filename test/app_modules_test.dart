import 'package:flutter_clean_architecture/app_modules.dart';
import 'package:flutter_clean_architecture/modules/search/domain/entities/result_search.dart';
import 'package:flutter_clean_architecture/modules/search/domain/usecases/search_text.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late SearchText usecase;
  late String searchText;
  Modular.init(AppModule());

  setUp(() {
    usecase = Modular.get<SearchText>();
    searchText = 'searchText';
  });

  test('deve recuperar o usecase sem erro', () {
    expect(usecase, isA<SearchTextImpl>());
  });

  test('deve trazer uma lista de result search', () async {
    // poderia adicionar o mock do dio
    final _response = await usecase.searchText(searchText);
    final _result = _response.fold((l) => l, (r) => r);

    expect(_result, isA<List<ResultSearch>>());
  });
}
