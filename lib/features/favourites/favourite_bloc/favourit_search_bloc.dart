import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';

import '../ClassFavourite.dart';


part 'favourit_search_event.dart';
part 'favourit_search_state.dart';



const apiUrl = 'https://api.jikan.moe/v4/anime';



class FavouritSearchBloc extends Bloc<FavouritSearchEvent, FavouritSearchState> {
  FavouritSearchBloc() : super(FavouritSearchState()) {
    on<RequestFavouritEvent>(
      _onSearch,
    );
  }

  final dio = Dio();

  _onSearch(RequestFavouritEvent event, Emitter<FavouritSearchState> emit) async {
    final List<Map<String, dynamic>> res = [];

    FavoriteList favoriteList = FavoriteList();
    await favoriteList.initialize();
    print("вызов внутри блока, список избранного favoriteList.favorites:");
    print(favoriteList.favorites);


    Future<Response<dynamic>> _retryGet(String url) async {
      const maxRetries = 3;
      var retries = 0;

      while (retries < maxRetries) {
        try {
          return await dio.get(url);
        } on DioException catch (e) {
          if (e.response?.statusCode == 429) {
            final delay = Duration(seconds: retries * 2);
            print('Rate limit exceeded. Retrying in $delay...');
            await Future.delayed(delay);
            retries++;
          } else {
            rethrow;
          }
        }
      }

      throw Exception('Exceeded maximum number of retries');
    }

    if (favoriteList != null && favoriteList.favorites.isNotEmpty) {
      for (var i = 0; i < favoriteList.favorites.length; i++) {
        final animeId = favoriteList.favorites[i];
        print("animeId $animeId");
        final apiUrl = 'https://api.jikan.moe/v4/anime/$animeId/full';
        print("запрос apiUrl " + apiUrl);

        try {
          final foundByAnimeId = await _retryGet(apiUrl);
          final animeData = foundByAnimeId.data['data'];
          animeData['favorite'] = true; // Add {'favorite': true} element to animeData
          res.add(animeData);
          print(res[i]['favorite'].toString());
        } catch (e) {
          // Handle the error here
          print('Error fetching anime data for ID $animeId: $e');
        }

        await Future.delayed(Duration(milliseconds: 500));
      }

      //final updatedFavoritesList = await addFavoritesKeyToList(res);
      emit(FavouritSearchState(favourit_list: res));
    }else {
      emit(FavouritSearchState(favourit_list: []));
    }

  }
}
