part of 'random_search_bloc.dart';



class RandomSearchEvent {}

class SearchRandomEvent extends RandomSearchEvent {
  final String query;

  SearchRandomEvent(this.query);
}