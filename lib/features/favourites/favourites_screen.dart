import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../custom_wiget/custom_boyum_navigator.dart';
import '../../custom_class/ClassUserInf.dart';
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
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            'FAVORITES',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
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

  UserInf favoriteList = UserInf();
  bool exists_favoriteList = false;

  @override
  void initState() {
    super.initState();
    favoriteList.initialize();
    Future.delayed(Duration.zero, () {
      favoriteList.initialize();
      setState(() {
        exists_favoriteList = favoriteList.registration.isEmpty;
        //print("setState(() внутри initState значение exists_favoriteList  " + exists_favoriteList.toString());
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      exists_favoriteList = favoriteList.registration.isEmpty;
      //print("setState(() внутри initState значение exists_favoriteList  " + exists_favoriteList.toString());
    });

    print("avoriteList.registration.isEmpty " + favoriteList.registration.isEmpty.toString());

    if(exists_favoriteList){
      return Center(
        child: Text(
          'Attention: Error! You are not logged in to your account.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {



      return BlocBuilder<FavouritSearchBloc, FavouritSearchState>(
        builder: (context, state) {
          print("первая сборка _FavouritesListScreenState");
          final users = state.favourit_list;
          if (users.isEmpty){
            return Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ), /*style: TextStyle(color: Colors.white)*/
                //CustomBotumBar(Index: 0),
              ]),
            );

          } else {
            return Column(
              children: [
                SizedBox(height: 20),
                //const SizedBox(height: 20),

                if (users.isNotEmpty)
                //print(users[0]["empty"].toString()),
                  if (users[0]["empty"] == 0)
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              "Your favorites list is empty.",
                              style: TextStyle(
                                fontSize: 18, // Adjust the size as needed
                                /*color: Colors.white*/
                              ),
                            ),
                          ),
                          // CustomBottomBar(Index: 0),
                        ],
                      ),
                    ),

                if (!users.any((map) => map.containsKey('empty')))
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

              ],

            );

          }

        },
      );

    };




  }
}


