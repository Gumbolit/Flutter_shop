import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_project/features/catalog/search_random/random_search_bloc.dart';
import '../../custom_wiget/custom_boyum_navigator.dart';

/*class Catalog_screen extends StatelessWidget {
  const Catalog_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.black,
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text("Catalog_screen", /*style: TextStyle(color: Colors.white)*/),
            //CustomBotumBar(Index: 0),
          ]),
        ),
        bottomNavigationBar: CustomBotumBar(Index: 0));
  }
}*/


class Catalog_screen extends StatelessWidget {
  const Catalog_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RandomSearchBloc()..add(SearchRandomEvent("flcl")),
        ),
      ],
      child: Scaffold(
        body: CatalogRandomSearch(),
        bottomNavigationBar:CustomBotumBar(Index: 0) ,


      ),
    );
  }
}

class CatalogRandomSearch extends StatefulWidget {
  @override
  State<CatalogRandomSearch> createState() => _CatalogRandomSearchState();
}

class _CatalogRandomSearchState extends State<CatalogRandomSearch> {
  PageController controller = PageController();
  int pageNamber = 0;

  @override
  Widget build(BuildContext context) {
    final users = context.select((RandomSearchBloc bloc) => bloc.state.earch_list);
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.close))],
      ),
      body: Center(
        child: PageView.builder(
          controller: controller,
          onPageChanged: (number) {
            pageNamber = number;
            print("pageNamber PageView $pageNamber");
            setState(() {
              context.read<RandomSearchBloc>().add(SearchRandomEvent("flcl"));
            });
          },
          itemBuilder: (BuildContext context, int index) {
            //final currentIndex = index % 2;
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 1),
              child: Column(
                children: [

                  if (users.isNotEmpty)
                    Text(
                      users.isNotEmpty && users[0]['title'] != null
                          ? (users[0]['title'].length > 25
                          ? '${users[0]['title'].substring(0, 25)}...'
                          : users[0]['title'])
                          : '',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (users.isNotEmpty)
                    Container(
                      width: 270,
                      height: 270,
                      child: Image.network(
                        users[0]['images']['jpg']['image_url'] ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                  SizedBox(height: 10),
                  if (users.isNotEmpty)
                    Text(
                      users.isNotEmpty && users[0]['synopsis'] != null
                          ? (users[0]['synopsis'].length > 30
                          ? '${users[0]['synopsis'].substring(0, 30)}...'
                          : users[0]['synopsis'])
                          : '',
                      style: TextStyle(
                        fontSize: 18,

                      ),
                    ),
                  if (users.isEmpty)
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                          ),
                        ],
                      ),
                    ),

                  SizedBox(height: 15),

                  if (users.isNotEmpty)
                    Text(
                      users.isNotEmpty && users[0]['title'] != null
                          ? (users[1]['title'].length > 25
                          ? '${users[1]['title'].substring(0, 25)}...'
                          : users[1]['title'])
                          : '',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (users.isNotEmpty)
                    Container(
                      width: 270,
                      height: 270,
                      child: Image.network(
                        users[1]['images']['jpg']['image_url'] ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                  SizedBox(height: 10),
                  if (users.isNotEmpty)
                    Text(
                      users.isNotEmpty && users[0]['synopsis'] != null
                          ? (users[1]['synopsis'].length > 30
                          ? '${users[1]['synopsis'].substring(0, 30)}...'
                          : users[1]['synopsis'])
                          : '',
                      style: TextStyle(
                        fontSize: 18,

                      ),
                    ),
                  if (users.isEmpty)
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                          ),
                        ],
                      ),
                    ),

                ],
              ),
            );


          },
        ),
      ),
    );
  }
}