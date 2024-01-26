import 'dart:async';
import 'package:dio/dio.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'search_event.dart';
part 'search_state.dart';

const apiUrl = 'https://api.jikan.moe/v4/anime';

EventTransformer<E> debounceDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.debounce(duration), mapper);
  };
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState()) {
    on<SearchUserEvent>(
      _onSearch,
      transformer: debounceDroppable(
        Duration(seconds: 2),
      ),
    );
  }

  final _httpClient = Dio();

  _onSearch(SearchUserEvent event, Emitter<SearchState> emit) async {
    if (event.query.length < 3) return;
    final res = await _httpClient.get(
      apiUrl,
      queryParameters: {
        'q': event.query,
      },
    );

    /*
    print(" ");
    print(" ");
    print("res.data['data'] Type - ");
    print( res.data['data'][0].runtimeType);
    print( res.data['data'][0]["mal_id"]);

    print(" ");
    print(" ");
    print("FavoritRes - ");
    final FavoritRes = addFavoritesKeyToList(res.data['data']);
    print( FavoritRes);
     */

    print(" ");
    print("addFavoritesKeyToList Type - ");
    print( addFavoritesKeyToList(res.data['data']).runtimeType);


    emit(SearchState(users: addFavoritesKeyToList(res.data['data'])));
  }
}

List<dynamic> addFavoritesKeyToList(List<dynamic> list) {
  List<dynamic> newList = [];

  for (var i = 0; i < list.length; i++) {
    if (list[i] is Map<String, dynamic>) {
      Map<String, dynamic> map = Map.from(list[i] as Map<String, dynamic>);
      map['favorite'] = false;
      newList.add(map);
    } else {
      newList.remove(list[i]);
    }
  }
  return newList;
}
