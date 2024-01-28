import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../custom_wiget/custom_boyum_navigator.dart';
import '../favourites/ClassFavourite.dart';
import 'search_bloc/search_bloc.dart';

/*class Search_screen extends StatelessWidget {
  const Search_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text("Search_screen", /*style: TextStyle(color: Colors.white)*/),
            //CustomBotumBar(Index: 0),
          ]),
        ),
        bottomNavigationBar: CustomBotumBar(Index: 1));
  }
}

 */


class Search_screen extends StatelessWidget {
  const Search_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SearchBloc()..add(SearchUserEvent("evangelion")),
        ),
      ],
      child: Scaffold(
        body: MyHomePage(),
        bottomNavigationBar:CustomBotumBar(Index: 1) ,


      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //рабочий код с лайками
  /*@override
  Widget build(BuildContext context) {
    final users = context.select((SearchBloc bloc) => bloc.state.users);
    return Column(
      children: [
        const Text('Search User'),
        const SizedBox(height: 20),
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'User name',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            context.read<SearchBloc>().add(SearchUserEvent(value));
          },
        ),
        if (users.isNotEmpty)
          Expanded(
            child: GridView.count(
              crossAxisCount: 2, // Display two columns
              children: List.generate(users.length, (index) {

                return ListTile(
                  title: Column(
                    children: [
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10), // Rounded corners
                            child: Container(
                              width: 100, // Adjust to your desired size
                              height: 100, // Adjust to your desired size
                              child: Image.network(
                                users[index]['images']['jpg']['image_url'] ?? '',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              users[index]['favorite'] ? Icons.favorite : Icons.favorite_border,
                              color: users[index]['favorite'] ? Colors.red : Colors.grey,

                            ),
                            onPressed: () {
                              print(users[index]['title'] + " до нажатия favorite в значении" + users[index]['favorite'].toString());
                              //print(users[index]['title'] + " в значении $isLiked");
                              if (users[index]['favorite'])
                                setState(() {
                                  users[index]['favorite']=false;
                                });
                              else
                                setState(() {
                                  users[index]['favorite']=true;
                                });

                              //print(users[index]['title'] + " в значении $isLiked");
                              //print( users[index].runtimeType);
                              print(users[index]['title'] + " после нажатия favorite в значении" + users[index]['favorite'].toString());
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        users[index]['title'].length > 17
                            ? '${users[index]['title'].substring(0, 17)}...'
                            : users[index]['title'],
                      ),
                      const SizedBox(height: 10),
                      Text(users[index]['score'].toString()),
                    ],
                  ),
                );
              }),
            ),
          ),
      ],
    );
  }

   */
  FavoriteList favoriteList = FavoriteList();

  @override
  void initState() {
    super.initState();
    favoriteList.initialize();
    //favoriteList.deleteAllFavorites();
  }

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    var users = List.from(context.select((SearchBloc bloc) => bloc.state.users));
    var usersCopie = users;
    if (isChecked) {
      users.sort((a, b) {
        final double scoreA = a['score'].toDouble() ?? 0.0;
        final double scoreB = b['score'].toDouble() ?? 0.0;
        return scoreB.compareTo(scoreA);
      });
    } else {
      users=usersCopie;
    }
    return
        Column(
          children: [
            const Text('Search User'),
            //const SizedBox(height: 20),
            Container(
              height: 150, // Replace with your desired height
              child: Column(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'User name',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        context.read<SearchBloc>().add(SearchUserEvent(value));
                      },
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          onChanged: (value) {
                            print("isChecked в значении до изменений $isChecked");
                            setState(() {

                              isChecked = value!;
                              print("isChecked в значении после изменений $isChecked");
                            });


                          },
                        ),
                        Text(
                          'Sort in ascending order',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (users.isNotEmpty)
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(users.length, (index) {
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
                                            users[index]['favorite'] = false;
                                          });
                                        } else {
                                          await favoriteList.addFavorite(users[index]["mal_id"].toString());
                                          setState(() {
                                            users[index]['favorite'] = true;
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
              Column(mainAxisSize: MainAxisSize.min, children: [
                CircularProgressIndicator(),
                //CustomBotumBar(Index: 0),
              ])

          ],
        );


  }

}

