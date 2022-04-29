import 'package:bloc/bloc.dart';
import 'package:flutter_clean_architecture/modules/search/domain/errors/errors.dart';
import 'package:flutter_clean_architecture/modules/search/domain/usecases/search_text.dart';
import 'package:flutter_clean_architecture/modules/search/presenter/search/state/search_event.dart';
import 'package:flutter_clean_architecture/modules/search/presenter/search/state/search_state.dart';

class SearchBloc extends Bloc<SearchignText, SearchState> {
  final SearchText usecase;

  SearchBloc(initialState, this.usecase) : super(SearchStart()) {
    on<SearchignText>((event, emit) async {
      emit(SearchLoading());

      final response = await usecase.searchText(event.searchText);
      final result =
          response.fold((l) => SearchEror(l), (r) => SearchSuccess(r));

      emit(result);
    });
  }
}
