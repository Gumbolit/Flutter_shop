import 'dart:async';
import 'package:dio/dio.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



part 'random_search_event.dart';
part 'random_search_state.dart';

const apiUrl = 'https://api.jikan.moe/v4/random/anime';

EventTransformer<E> debounceDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.debounce(duration), mapper);
  };
}

class RandomSearchBloc extends Bloc<RandomSearchEvent, RandomSearchState> {
  RandomSearchBloc() : super(RandomSearchState()) {
    on<SearchRandomEvent>(
      _onSearch
    );
  }

  final _httpClient = Dio();

  _onSearch(SearchRandomEvent event, Emitter<RandomSearchState> emit) async {


    if (event.query.length < 3) return;
    final res1 = await _httpClient.get(
      apiUrl,

    );

    if (event.query.length < 3) return;
    final res2 = await _httpClient.get(
      apiUrl,

    );


/*
    print(" ");
    print(" ");
    print("res.data['data'] Type - ");
    print( res.data['data'].runtimeType);
    print( res.data['data']);

    print(" ");
    print(" ");
    print("FavoritRes - ");
    final FavoritRes = addFavoritesKeyToList(res.data['data']);
    print( FavoritRes);


    print(" ");
    print("addFavoritesKeyToList Type - ");
    print( addFavoritesKeyToList(res.data['data']).runtimeType);

     */


    emit(RandomSearchState(earch_list: combineMaps(res1.data['data'],res2.data['data'])));


  }
}

List<Map> combineMaps(Map map1, Map map2) {
  List<Map> combinedList = [];

  if (map1['synopsis']==null){
    map1['synopsis']='You well see - you well find out what the anime is about)))';
  };
  if (map2['synopsis']==null){
    map2['synopsis']='You well see - you well find out what the anime is about)))';
  };

  if (map1['title']==null){
    map1['title']='Nameless Anime';
  };
  if (map2['title']==null){
    map2['title']='Nameless Anime';
  };

  combinedList.add(map1);
  combinedList.add(map2);

  return combinedList;
}
