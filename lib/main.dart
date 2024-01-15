import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'features/onbording/onbording_screen.dart';
import 'navigator.dart';



void main() {
  runApp(const ShopApp());
}

class ShopApp extends StatelessWidget {
  const ShopApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShopApp',
      onGenerateRoute: onGenerateRoute,
      //onGenerateRoute: generateRoutes,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      //home: TheShopApp(),
    );
  }
}

/*class visit extends StatefulWidget {
  @override
  State<visit> createState() => _visitState();
}

class _visitState extends State<visit> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    onGenerateRoute: onGenerateRoute,
    );
  }
}*/

/*
class TheShopApp extends StatefulWidget {
  @override
  State<TheShopApp> createState() => _MyScreenState();
}

class _MyScreenState extends State<TheShopApp> {
  PageController controller = PageController();
  int pageNamber = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.close))],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          //мы задаем размер ячейки Column минимальным чтобы он отцентрировал по высоте
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
              //padding: const EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                height: 380, //width: ,
                //padding: const EdgeInsets.symmetric(horizontal: 60),
                child: PageView(
                  controller: controller,
                  onPageChanged: (number) {
                    pageNamber = number;
                    print("pageNamber $pageNamber");
                    setState(() {});
                  },
                  children: [
                    Column(
                      children: [
                        Image(
                          image: AssetImage(
                            "asset/logo/logo.png",
                          ),
                          fit: BoxFit.fill,
                        ),
                        SizedBox(height: 20),
                        Text(
                          "ПОКУПАЙТЕ ПРОДУКТЫ НЕ ВЫХОДЯ ИЗ ДОМА ИЛИ ПОЛУЧАЙТЕ БОНУСЫ ЗА ПРОГУЛКУ ЗА НИМИ.",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Image(
                          image: AssetImage(
                            "asset/logo/logo.png",
                          ),
                          fit: BoxFit.fill,
                        ),
                        SizedBox(height: 20),
                        Text(
                          "УДОБНАЯ НАВИГАЦИЯ ВНУТРИ МАГАЗИНА НЕ ПОЗВОЛИТ ВАМ ПОТЕРЯТЬСЯ ИЛИ ЧТО-ТО ЗАБЫТЬ.",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Image(
                          image: AssetImage(
                            "asset/logo/logo.png",
                          ),
                          fit: BoxFit.fill,
                        ),
                        SizedBox(height: 20),
                        Text(
                          "ДЕЛИТЕСЬ КОРЗИНОЙ С\nБЛИЗКИМИ ДДРУЗЬЯМИ.",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Image(
                          image: AssetImage(
                            "asset/logo/logo.png",
                          ),
                          fit: BoxFit.fill,
                        ),
                        SizedBox(height: 20),
                        Text(
                          "\nПРИЯТНОЙ РАБОТЫ С ПРИЛОЖЕНИЕМ.",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(

              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                backgroundColor: Colors.black,
                textStyle: TextStyle(fontSize: 13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),

                  //side: BorderSide(width: 50, color: Colors.black),
                ),
                minimumSize: Size(380, 40),
              ),
              onPressed: () {
                setState(() {
                  if (pageNamber <= 3) {
                    pageNamber++;
                  } else {
                    pageNamber = pageNamber;
                  }
                });
                controller.animateToPage(
                  pageNamber,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              },
              child: Text(pageNamber == 3 ? "НАЧАТЬ" : "ДАЛЕЕ",
                  style: TextStyle(
                      color: Colors
                          .white) /*"ДАЛЕЕ", style: TextStyle(color: Colors.white,),*/),
            ),
            SizedBox(height: 20),
            SmoothPageIndicator(
              controller: controller,
              count: 4,
              effect: SlideEffect(
                //PaintingStyle paintStyle = PaintingStyle.fill,
                paintStyle: PaintingStyle.stroke,
                spacing: 16.0,
                radius: 20,
                dotWidth: 14.0,
                dotHeight: 14.0,
                //paintStyle:  PaintingStyle.fill,
                //strokeWidth:  4.5,
                dotColor: Colors.black,
                activeDotColor: Colors.black,
              ),

            ),
          ],
        ),
      ),
    );
  }
}
*/