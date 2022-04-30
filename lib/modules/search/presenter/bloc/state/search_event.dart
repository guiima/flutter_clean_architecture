abstract class SearchEvent {}

class SearchignText extends SearchEvent {
  final String searchText;

  SearchignText(this.searchText);
}
