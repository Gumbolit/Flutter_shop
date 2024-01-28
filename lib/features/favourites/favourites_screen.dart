import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../custom_wiget/custom_boyum_navigator.dart';
import 'ClassFavourite.dart';
import 'favourite_bloc/favourit_search_bloc.dart';

class Favourites_screen extends StatelessWidget {
  const Favourites_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FavouritSearchBloc()..add(RequestFavouritEvent()),
        ),
      ],
      child: Scaffold(
        body: FavouritesListScreen(),
        bottomNavigationBar:CustomBotumBar(Index: 3) ,

      ),
    );
  }
}

class FavouritesListScreen extends StatefulWidget {
  const FavouritesListScreen({super.key});

  @override
  State<FavouritesListScreen> createState() => _FavouritesListScreenState();
}

class _FavouritesListScreenState extends State<FavouritesListScreen> {

  FavoriteList favoriteList = FavoriteList();

  @override
  void initState() {
    super.initState();
    favoriteList.initialize();
    //favoriteList.deleteAllFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouritSearchBloc, FavouritSearchState>(
      builder: (context, state) {
        print("первая сборка _FavouritesListScreenState");
        final users = state.favourit_list; // Access the favorit_list from the state

        return Scaffold(
          body:Column(
            children: [
              const Text('Search User'),
              //const SizedBox(height: 20),

              if (users.isNotEmpty)
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(users.length, (index) {
                      print('users[0][favorite]'+users[0]['favorite'].toString());
                      return ListTile(
                        title: Column(
                          children: [
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    child: Image.network(
                                      users[index]['images']['jpg']['image_url'] ?? '',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white60,
                                  ),
                                  child: Center(
                                    child: SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        icon: Icon(
                                          users[index]['favorite'] ? Icons.favorite : Icons.favorite_border,
                                          color: users[index]['favorite'] ? Colors.red : Colors.white,
                                        ),
                                        onPressed: () async {
                                          print(users[index]['title'] + " до нажатия favorite в значении" + users[index]['favorite'].toString());

                                          if (users[index]['favorite']) {
                                            await favoriteList.deleteFavorite(users[index]["mal_id"].toString());
                                            setState(() {
                                              //users[index]['favorite'] = false;
                                              final favouritSearchBloc = BlocProvider.of<FavouritSearchBloc>(context);
                                              favouritSearchBloc.add(RequestFavouritEvent());
                                            });
                                          } else {
                                            await favoriteList.addFavorite(users[index]["mal_id"].toString());
                                            setState(() {
                                              //users[index]['favorite'] = true;
                                              final favouritSearchBloc = BlocProvider.of<FavouritSearchBloc>(context);
                                              favouritSearchBloc.add(RequestFavouritEvent());
                                            });
                                          }

                                          print(users[index]['title'] + " после нажатия favorite в значении" + users[index]['favorite'].toString());
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              users[index]['title'].length > 17
                                  ? '${users[index]['title'].substring(0, 17)}...'
                                  : users[index]['title'],
                            ),
                            const SizedBox(height: 5),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Text(
                                  users[index]['score'].toString(),
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              if (users.isEmpty)
                Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ); // Replace this with your actual widget tree
      },
    );
  }
}


